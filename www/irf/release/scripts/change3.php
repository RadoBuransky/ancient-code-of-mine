<?
  if ((!IsSet( $GLOBALS["name"] )) ||
      (!IsSet( $GLOBALS["nazov"] )) ||
	  (!IsSet( $GLOBALS["popis"] )) ||
	  (!IsSet( $GLOBALS["adresa"] )) ||
	  (!IsSet( $GLOBALS["telc1"] )) ||
	  (!IsSet( $GLOBALS["telc2"] )) ||
	  (!IsSet( $GLOBALS["fax"] )) ||
	  (!IsSet( $GLOBALS["mail"] )))
    exit;  
	
  $SQL = MySQL_Connect( "db.host.sk" , "radob" , "evjlls" );
  if ($SQL == false)
  {
    echo( "<html><head></head>" );
    echo( "<body onload=\"window.location.href='../index.html';\"></body>" );
    echo( "</html>" );
    exit;
  }  

  MySQL_Select_DB( "radob" );
  MySQL_Query( "UPDATE users SET nazov='".$nazov."', popis='".$popis."', adresa='".$adresa."', tc1='".$telc1."', tc2='".$telc2."', fax='".$fax."', mail='".$mail."' WHERE name='".$name."'" );
  MySQL_Close( $SQL );
  
  $url = "http://".$SERVER_NAME."/scripts/generate.php?code=".$name;
  
  echo( "<html><head></head>" );
  echo( "<body onload=\"window.location.href='../zmena/msg2.php?text=Údaje o Vašej spoloènosti boli úspešne zmenené!&url=".$url."';\"></body>" );
  echo( "</html>" );  
?>