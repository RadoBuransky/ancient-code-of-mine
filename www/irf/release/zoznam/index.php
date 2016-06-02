<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=windows-1250">
	<meta http-equiv=Pragma content=no-cache>	
    <link rel=stylesheet href="../style.css" type="text/css" title="style.css">	
	<title>intelignetné riešenie pre firmy - zoznam firiem</title>	
</head>

<body>
  <center>
    <img src="../images/logo-big.gif" width="373" height="185" alt="" border="0">
  </center>
  <center>
  <table width=700 cellpadding=0 cellspacing=0 border=0>
  <tr height=20>
    <td width=10></td>
    <td width=200></td>
	<td></td>
	<td width=10></td>
  </tr>
  <tr height=25 bgcolor=#660000 style="color:#ffffff">
    <td></td>
    <td><strong>Názov firmy</strong></td>
	<td><strong>Popis činnosti</strong></td>
	<td></td>
  </tr>
  <?
    $SQL = MySQL_Connect( "db.host.sk" , "radob" , "evjlls" );
    if ($SQL == false)
    {
      echo( "<body onload=\"window.location.href='index.html';\"></body>" );
	  echo( "</html>" );
      exit;
    }
  
    MySQL_Select_DB( "radob" );
	$Result = MySQL_Query( "SELECT * FROM users ORDER BY nazov" , $SQL );
	
	$j = MySQL_Num_Rows( $Result );
	for ($i = 0; $i < $j; $i++)	
	{
	  $Url = MySQL_Result( $Result , $i , 2 );
	  $Nazov = MySQL_Result( $Result , $i , 3 );
	  $Popis = MySQL_Result( $Result , $i , 4 );	  
		
	  echo( "<tr height=25><td></td>" );
	  echo( "<td><a href=\"".$Url."\">".$Nazov."</a></td>" );
	  echo( "<td>".$Popis."</td>" );
	  echo( "<td></td></tr>" );	  
	} 
	    
    MySQL_Close( $SQL );
  ?>
  <tr height=25 bgcolor=#660000 style="color:#ffffff">
    <td></td>
    <td><strong>Názov firmy</strong></td>
	<td><strong>Popis činnosti</strong></td>
	<td></td>
  </tr>
  </table>
  </center>    
</body>

</html>
