#!/usr/bin/php -q
<?php

require(dirname(__FILE__, 2) . '/framework/loader.php');

$mods = BeaconMod::GetPullMods();
if (count($mods) == 0) {
	exit;
}

foreach ($mods as $mod) {
	PullMod($mod);
}

function PullMod(BeaconMod $mod) {
	$mod_description = $mod->Name() . ' (' . $mod->ModID() . ')';
	$mod_id = $mod->ModID();
	
	$http = curl_init();
	curl_setopt($http, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($http, CURLOPT_URL, $mod->PullURL());
	$body = curl_exec($http);
	$status = curl_getinfo($http, CURLINFO_HTTP_CODE);
	$content_type = curl_getinfo($http, CURLINFO_CONTENT_TYPE);
	curl_close($http);
	
	if ($status != 200) {
		SendAlert($mod, 'Failed with HTTP status ' . $status . '.');
		return;
	}
	
	if ($content_type === null) {
		SendAlert($mod, 'Did not include Content-Type header.');
		return;
	}
	
	switch ($content_type) {
	case 'application/json':
		$engrams = json_decode($body, true);
		if ($engrams === false) {
			SendAlert($mod, 'Could not parse JSON content.');
		}
		break;
	default:
		SendAlert($mod, 'Unexpected content type: ' . $content_type . '.');
		return;
	}
	
	if (BeaconCommon::IsAssoc($engrams)) {
		// single
		$engrams = array($engrams);
	}
	
	// get the distinct workshop ids for each item
	$database = BeaconCommon::Database();
	$database->BeginTransaction();
	foreach ($engrams as $engram) {
		if (!BeaconCommon::HasAllKeys($engram, 'class', 'label', 'mod_id', 'availability', 'can_blueprint')) {
			$database->Rollback();
			SendAlert($mod, 'An engram is missing keys.');
			return;
		}
		
		$class = $engram['class'];
		$label = $engram['label'];
		$availability_keys = $engram['availability'];
		$can_blueprint = $engram['can_blueprint'];
		
		$availability = 0;
		if (is_array($availability_keys)) {
			foreach ($availability_keys as $key) {
				$key = strtolower(trim($key));
				if ($key === 'island') {
					$availability = $availability | BeaconEngram::ENVIRONMENT_ISLAND;
				}
				if ($key === 'scorched') {
					$availability = $availability | BeaconEngram::ENVIRONMENT_SCORCHED;
				}
			}
		}
		if ($availability === 0) {
			$database->Rollback();
			SendAlert($mod, 'Engram ' . $class . ' does not have an availability.');
			return;
		}
		
		$results = $database->Query('SELECT mod_id FROM engrams WHERE classstring = $1;', $class);
		if ($results->RecordCount() == 1) {
			// update
			if ($results->Field('mod_id') !== $mod_id) {
				$database->Rollback();
				SendAlert($mod, 'Engram ' . $class . ' belongs to another mod.');
				return;
			}
			$database->Query('UPDATE engrams SET label = $2, availability = $3, can_blueprint = $4 WHERE classstring = $1;', $class, $label, $availability, $can_blueprint);
		} else {
			// new
			$database->Query('INSERT INTO engrams (classstring, label, availability, can_blueprint, mod_id) VALUES ($1, $2, $3, $4, $5);', $class, $label, $availability, $can_blueprint, $mod_id);
		}
	}
	$database->Commit();
}

function SendAlert(BeaconMod $mod, string $message) {
	$message = $mod->Name() . ' (' . $mod->WorkshopID() . '): ' . $message;
	$cron = !isset($_ENV['SSH_CLIENT']);
	if ($cron) {
		echo "$message\n";
	} else {
		BeaconCommon::PostSlackMessage($message);
	}
}

?>