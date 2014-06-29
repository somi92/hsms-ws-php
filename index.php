<?php

    require_once 'nusoap-0.9.5/lib/nusoap.php';

	$service = new soap_server();
	$namespace = "http://192.168.0.15/HSMSWebService/index.php";
	$service -> wsdl -> schemaTargetNamespace = $namespace;
	$service -> configureWSDL("ActionList");
	
	$service -> register("listAllActions",
						array(),
					    array("return" => "xsd:string"),
					    "urn:ActionList",
					    "urn:ActionList#listAllActions",
					    "rpc",
					    "literal",
					    "Get a listing of actions");
	$service -> service($HTTP_RAW_POST_DATA);
	
	function listAllActions() {
		
		$dbhost = "localhost:3036";
		$dbuser = "milos";
		$dbpass = "Skydiving@1992";
		$dbname = "hsms_database";
		
		$conn = mysql_connect($dbhost, $dbuser, $dbpass);
	
		if(!$conn) 
		{
			die("Could not connect: " . mysql_error());
		}
		// echo "Connected successfully!\n";
		
		$hsms = array(
				"desc" => "",
				"num" => "",
				"price" => "",
				"org" => "",
				"web" => "");
		$actions = array();
		
		$sql_query = "select HB.hb_id, HB.opis, HB.broj, HB.cena, ORG.naziv, ORG.website ".
					 "from HUMANITARNI_BROJ HB join ORGANIZACIJA ORG on (HB.org_id = ORG.org_id); ";
					 "order by HB.prioritet;";
		mysql_select_db($dbname);
		
		mysql_query ("SET NAMES 'utf8' COLLATE 'utf8_unicode_ci'");
		
		$result = mysql_query($sql_query, $conn);
		if(!$result) 
		{
			die("Could not execute query: ".mysql_error());
		}
		
		while($table_row = mysql_fetch_array($result, MYSQL_ASSOC)) 
		{
			$hsms = array(
					"desc" => $table_row["opis"],
					"num" => $table_row["broj"],
					"price" => $table_row["cena"],
					"org" => $table_row["naziv"],
					"web" => $table_row["website"]);
			$actions["action"][] = $hsms;
		}
		
		mysql_free_result($result);
		mysql_close($conn);
		
		return json_encode($actions);
	}
	
?>