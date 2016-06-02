<html>
<head>
</head>
<?
  if ((!IsSet($GLOBALS["meno"])) ||
      (!IsSet($GLOBALS["heslo"])) ||
	  (!IsSet($GLOBALS["heslo2"])) ||
	  ($meno == "") ||
	  ($heslo == "") ||
	  ($heslo2 == ""))
  {
    echo( "<body onload=\"window.location.href='../registracia/msg.php?text=Nezadali ste všetky hodnoty!';\"></body>" );
	echo( "</html>" );
    exit;
  }
  
  if ($heslo != $heslo2)
  {
    echo( "<body onload=\"window.location.href='../registracia/msg.php?text=Nezopakovali ste správne heslo!';\"></body>" );
	echo( "</html>" );
    exit;
  }
  
  //Check if this password exists
  $SQL = MySQL_Connect( "db.host.sk" , "radob" , "evjlls" );
  if ($SQL == false)
  {
    echo( "<body onload=\"window.location.href='index.html';\"></body>" );
	echo( "</html>" );
    exit;
  }
  
  MySQL_Select_DB( "radob" );
  
  $Result = MySQL_Query( "SELECT * FROM users WHERE (users.name = '".$meno."')" , $SQL );
  
  if (MySQL_Num_Rows( $Result ) > 0)
  {
    MySQL_Close( $SQL );
    echo( "<body onload=\"window.location.href='../registracia/msg.php?text=Užívate¾ so zadaným menom už existuje!';\"></body>" );
	echo( "</html>" );
    exit;
  }
  
  MySQL_Query( "INSERT INTO `users` (`name`, `pw`, `url`, `nazov`, `popis`, `adresa`, `tc1`, `tc2`, `fax`, `mail` , `style`) VALUES ('".$meno."', '".Crypt( $heslo , "69" )."', '', '', '', '', '', '', '', '', '')" );
  MySQL_Close( $SQL );
  
  echo( "<body onload=\"window.location.href='../registracia/step2.php?name=".$meno."';\"></body>" );
  echo( "</html>" );
  exit;
?>