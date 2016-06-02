<?
  if ((!IsSet( $GLOBALS["meno"] )) ||
      (!IsSet( $GLOBALS["heslo"] )))
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
  $Result = MySQL_Query( "SELECT * FROM users WHERE name='".$meno."'" , $SQL );
  
  if (MySQL_Num_Rows( $Result ) == 0)  
  {
    echo( "<html><head></head>" );
    echo( "<body onload=\"window.location.href='../zmena/msg.php?text=Uživate¾ so zadaným menom neexistuje!';\"></body>" );
    echo( "</html>" );
    exit;
  }

  $a = Crypt( $heslo , "69" );
  $b = MySQL_Result( $Result , 0 , 1 );   
  if ($a == $b)
  {
    $nazov = MySQL_Result( $Result , 0 , 3 );
    $popis = MySQL_Result( $Result , 0 , 4 );
    $adresa = MySQL_Result( $Result , 0 , 5 );
    $telc1 = MySQL_Result( $Result , 0 , 6 );
    $telc2 = MySQL_Result( $Result , 0 , 7 );
    $fax = MySQL_Result( $Result , 0 , 8 );
    $mail = MySQL_Result( $Result , 0 , 9 );
    $style = MySQL_Result( $Result , 0 , 10 );
	
    require( "../scripts/change2.php" );
  }
  else
  {
    echo( "<html><head></head>" );
    echo( "<body onload=\"window.location.href='../zmena/msg.php?text=Nezadali ste správne heslo!';\"></body>" );
    echo( "</html>" );
    exit;
  }
  
  MySQL_Close( $SQL );
?>