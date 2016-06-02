<html>
<head>
</head>
<?
  if ((!IsSet( $GLOBALS["name"] )) ||
      (!IsSet( $GLOBALS["nazov"] )) ||
	  (!IsSet( $GLOBALS["popis"] )) ||
	  (!IsSet( $GLOBALS["adresa"] )) ||
	  (!IsSet( $GLOBALS["telc1"] )) ||
	  (!IsSet( $GLOBALS["telc2"] )) ||
	  (!IsSet( $GLOBALS["fax"] )) ||
	  (!IsSet( $GLOBALS["mail"] )))
  {
    echo( "<body onload=\"window.location.href='../index.html';\"></body>" );
	echo( "</html>" );
    exit;  
  }
  
  $url = "http://".$SERVER_NAME."/scripts/generate.php?code=".$name;
  
  $SQL = MySQL_Connect( "db.host.sk" , "radob" , "evjlls" );
  if ($SQL == false)
  {
    echo( "<body onload=\"window.location.href='index.html';\"></body>" );
	echo( "</html>" );
    exit;
  }
  
  MySQL_Select_DB( "radob" );  
  MySQL_Query( "UPDATE users SET nazov='".$nazov."', url='".$url."', popis='".$popis."', adresa='".$adresa."', tc1='".$telc1."', tc2='".$telc2."', fax='".$fax."', mail='".$mail."' WHERE name='".$name."'" );
  MySQL_Close( $SQL );
  
  echo( "<body onload=\"window.location.href='../registracia/step3.php?name=".$name."';\"></body>" );
  echo( "</html>" );
  exit;
?>

<body>
</body>
</html>