<?
  if (!IsSet( $GLOBALS["code"] ))
    exit;
	
  $SQL = MySQL_Connect( "db.host.sk" , "radob" , "evjlls" );
  if ($SQL == false)
  {
    echo( "<body onload=\"window.location.href='index.html';\"></body>" );
	echo( "</html>" );
    exit;
  }
  
  MySQL_Select_DB( "radob" );  
  $Result = MySQL_Query( "SELECT * FROM users WHERE name='".$code."'" , $SQL );
  
  if ($Result == false)
  {
    echo( "<body onload=\"window.location.href='index.html';\"></body>" );
	echo( "</html>" );
    exit;
  }
  
  $style = 0;
  $nazov = MySQL_Result( $Result , 0 , 3 );
  $popis = MySQL_Result( $Result , 0 , 4 );
  $adresa = MySQL_Result( $Result , 0 , 5 );
  $tc1 = MySQL_Result( $Result , 0 , 6 );
  $tc2 = MySQL_Result( $Result , 0 , 7 );
  $fax = MySQL_Result( $Result , 0 , 8 );
  $mail = MySQL_Result( $Result , 0 , 9 );
  $style = MySQL_Result( $Result , 0 , 10 );
    
  MySQL_Close( $SQL );
  
  echo( "<!DOCTYPE HTML PUBLIC\"-//W3C//DTD HTML 4.0 Transitional//EN\">\n" );
  echo( "<html>\n" );
  echo( "<head>\n" );
  echo( "<meta http-equiv=\"content-type\" content=\"text/html;charset=windows-1250\">\n" );
  echo( "<link rel=stylesheet href=\"../styles/style".$style.".css\" type=\"text/css\" title=\"style.css\">\n" );
  echo( "<title>".$nazov."</title>\n" );
  echo( "</head>\n" );
  echo( "<body>\n" );
  echo( "<center>\n" );
  echo( "<h1>".$nazov."</h1>\n" );
  echo( "</center>\n" );
  echo( "<center>\n" );
  echo( "<table width=600 cellspacing=0 cellpadding=0 border=0>\n" );
  echo( "<tr class=\"dark\">\n" );
  echo( "<td width=10></td>\n" );
  echo( "<td>Názov spoloènosti :</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"light\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>".$nazov."</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"dark\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>Popis èinnosti :</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"light\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>".$popis."</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"dark\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>Adresa :</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"light\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>".$adresa."</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"dark\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>Telefónne èíslo 1 :</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"light\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>".$tc1."</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"dark\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>Telefónne èíslo 2 :</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"light\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>".$tc2."</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"dark\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>Fax :</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"light\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>".$fax."</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"dark\">\n" );
  echo( "<td></td>\n" );
  echo( "<td>Mail :</td>\n" );
  echo( "</tr>\n" );
  echo( "<tr class=\"light\">\n" );
  echo( "<td></td>\n" );
  echo( "<td><a href=\"mailto:".$mail."\">".$mail."</a></td>\n" );
  echo( "</tr>\n" );
  echo( "</table>\n" );
  echo( "</center>\n" );
  echo( "<center><a href=\"../index.html\">i r f</a></center>" ); 
  echo( "</body>\n" );
  echo( "</html>\n" );
?>