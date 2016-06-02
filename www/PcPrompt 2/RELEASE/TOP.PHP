<?
  function NapisDatum()
  {
    $SKDni = array( "Nede¾a" , "Pondelok" , "Utorok" , "Streda" , "Štvrtok" , "Piatok" , "Sobota" );
	
	$Den = date( "d" );
	if ($Den[0] == "0")
	  $Den = $Den[1];
	
	$Vysledok = $SKDni[jddayofweek( date( "w" ) , 0 )].", ".$Den.Date( ".n.Y" );
	
	echo( "<strong><font face='arial' size='3'>$Vysledok</font></strong>" );
  }  
?>

<tr>
  <td width=100><img src="images/logo.gif" width="100" height="100" alt="" border="0"></td>
  <td width=20></td>
  <td width=600><img src="IMAGES/reklama.gif" width="585" height="100" alt="" border="0"></td>    
</tr>