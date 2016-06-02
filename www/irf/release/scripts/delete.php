<?
  if (!IsSet( $GLOBALS["name"] ))
    exit;
	
  $SQL = MySQL_Connect( "db.host.sk" , "radob" , "evjlls" );
  if ($SQL == false)
    exit;
  
  MySQL_Select_DB( "radob" );
  MySQL_Query( "DELETE FROM users WHERE name='".$name."'" , $SQL );
  MySQL_Close( $SQL );
  
  echo( "<html><head></head>" );
  echo( "<body onload=\"window.location.href='../zmena/msg2.php?text=Vaše konto bolo úspešne zmazané!';\"> ");
  echo( "<center><a href=\"../index.html\">i r f</a></center>" );
  echo( "</body>" );
  echo( "</html>" );  
?>