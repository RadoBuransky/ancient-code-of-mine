<html>
<head>
</head>
<?
  if ((!IsSet( $GLOBALS["name"] )) ||
      (!IsSet( $GLOBALS["style"] )))
  {
    echo( "<body onload=\"window.location.href='../index.html';\"></body>" );
	echo( "</html>" );
    exit;  
  }
  
  $SQL = MySQL_Connect( "db.host.sk" , "radob" , "evjlls" );
  if ($SQL == false)
  {
    echo( "<body onload=\"window.location.href='index.html';\"></body>" );
	echo( "</html>" );
    exit;
  }
  
  MySQL_Select_DB( "radob" );  
  MySQL_Query( "UPDATE users SET style='".$style."' WHERE name='".$name."'" );
  MySQL_Close( $SQL );
  
  $url = "http://".$SERVER_NAME."/scripts/generate.php?code=".$name;
  
  echo( "<body onload=\"window.location.href='../registracia/finish.php?url=".$url."';\"></body>" );
  echo( "</html>" );
  exit;
?>

<body>
</body>
</html>