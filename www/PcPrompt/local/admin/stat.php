<?
  $suma = 0;
  
  $po	= 0;
  $ut	= 0;
  $str	= 0;
  $stv	= 0;
  $pi	= 0;
  $so	= 0;
  $ne	= 0; 
  
  $ie	= 0;
  $nn	= 0;
  
  $search = 0;
  
  for ($i = 0; $i < 24; $i++)
    $hr[$i] = 0;
  
  $SQL = @MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
  if ($SQL != false)
  {
    MySQL_Select_DB( "pcprompt" );
	
	$Result = MySQL_Query( "SELECT * FROM stat ORDER BY COL0" , $SQL );
    if ($Result == 0)
	  exit;
	  
	$suma = MySQL_Result( $Result , 0 , 1 );
	
	$po	  = MySQL_Result( $Result , 1 , 1 );
  	$ut	  = MySQL_Result( $Result , 2 , 1 );
    $str  = MySQL_Result( $Result , 3 , 1 );
    $stv  = MySQL_Result( $Result , 4 , 1 );
    $pi	  = MySQL_Result( $Result , 5 , 1 );
    $so	  = MySQL_Result( $Result , 6 , 1 );
    $ne	  = MySQL_Result( $Result , 7 , 1 );
  
    $ie	  = MySQL_Result( $Result , 8 , 1 );
    $nn	  = MySQL_Result( $Result , 9 , 1 );
  
    $search = MySQL_Result( $Result , 10 , 1 );
	
	for ($i = 0; $i < 24; $i++)
	  $hr[$i] = MySQL_Result( $Result , 11+$i , 1 );
	
	MySQL_Close( $SQL );
  }
  
  $i = $po;
  if ($ut > $i)
    $i = $ut;
  if ($str > $i)
    $i = $str;
  if ($stv > $i)
    $i = $stv;
  if ($pi > $i)
    $i = $pi;
  if ($so > $i)
    $i = $so;
  if ($ne > $i)
    $i = $ne;
  
  $pow	= (200 / $i) * $po;
  $utw	= (200 / $i) * $ut;
  $strw	= (200 / $i) * $str;
  $stvw	= (200 / $i) * $stv;
  $piw	= (200 / $i) * $pi;
  $sow	= (200 / $i) * $so;
  $new	= (200 / $i) * $ne;
  
  $i = $ie;
  if ($nn > $i)
    $i = $nn;
	
  $iew = (200 / $i) * $ie;
  $nnw = (200 / $i) * $nn;
  
  $max = 1;
  for ($i = 0; $i < 24; $i++)
    if ($hr[$i] > $max)
	  $max = $hr[$i];
	  
  for ($i = 0; $i < 24; $i++)
    $hrw[$i] = (200 / $max) * $hr[$i]; 
?>

<center>
  <table width=600 height=180 cellpadding=0 cellspacing=0 border=0>
    <tr height=0>
	  <td width=200></td>
	  <td width=200></td>
	  <td width=200></td>
    </tr>
    <tr height=25 bgcolor=#ffe5e5>
	  <td colspan=2><big>&nbsp;Celkový poèet návštev :</big></td>
	  <td align="right"><? echo( $suma ); ?>&nbsp;</td>
    </tr>
	<tr height=15>
	  <td></td>
	  <td></td>
	  <td></td>
    </tr>
    <tr height=20 bgcolor=#ffe5e5>
	  <td>&nbsp;Pondelok :</td>
	  <td><? echo( "<img src=\"images/tile.gif\" width=\"".$pow."\" height=\"20\" alt=\"\" border=\"0\">" ); ?></td>
	  <td align="right"><? echo( $po ); ?>&nbsp;</td>
    </tr>
	<tr height=20 bgcolor=#ffe5e5>
	  <td>&nbsp;Utorok :</td>
	  <td><? echo( "<img src=\"images/tile.gif\" width=\"".$utw."\" height=\"20\" alt=\"\" border=\"0\">" ); ?></td>
	  <td align="right"><? echo( $ut ); ?>&nbsp;</td>
    </tr>
	<tr height=20 bgcolor=#ffe5e5>
	  <td>&nbsp;Streda :</td>
	  <td><? echo( "<img src=\"images/tile.gif\" width=\"".$strw."\" height=\"20\" alt=\"\" border=\"0\">" ); ?></td>
	  <td align="right"><? echo( $str ); ?>&nbsp;</td>
    </tr>
	<tr height=20 bgcolor=#ffe5e5>
	  <td>&nbsp;Štvrtok :</td>
	  <td><? echo( "<img src=\"images/tile.gif\" width=\"".$stvw."\" height=\"20\" alt=\"\" border=\"0\">" ); ?></td>
	  <td align="right"><? echo( $stv ); ?>&nbsp;</td>
    </tr>
	<tr height=20 bgcolor=#ffe5e5>
	  <td>&nbsp;Piatok :</td>
	  <td><? echo( "<img src=\"images/tile.gif\" width=\"".$piw."\" height=\"20\" alt=\"\" border=\"0\">" ); ?></td>
	  <td align="right"><? echo( $pi ); ?>&nbsp;</td>
    </tr>
	<tr height=20 bgcolor=#ffe5e5>
	  <td>&nbsp;Sobota :</td>
	  <td><? echo( "<img src=\"images/tile.gif\" width=\"".$sow."\" height=\"20\" alt=\"\" border=\"0\">" ); ?></td>
	  <td align="right"><? echo( $so ); ?>&nbsp;</td>
    </tr>
	<tr height=20 bgcolor=#ffe5e5>
	  <td>&nbsp;Nede¾a :</td>
	  <td><? echo( "<img src=\"images/tile.gif\" width=\"".$new."\" height=\"20\" alt=\"\" border=\"0\">" ); ?></td>
	  <td align="right"><? echo( $ne ); ?>&nbsp;</td>
    </tr>
	<tr height=15>
	  <td></td>
	  <td></td>
	  <td></td>
    </tr>
	<tr height=25 bgcolor=#ffe5e5>
	  <td colspan=2>&nbsp;Poèet použitia vyh¾adávania :</td>
	  <td align="right"><? echo( $search ); ?>&nbsp;</td>
    </tr>
	<tr height=15>
	  <td></td>
	  <td></td>
	  <td></td>
    </tr>
	<tr height=20 bgcolor=#ffe5e5>
	  <td>&nbsp;Poèet užívate¾ov lepšej verzie :</td>
	  <td><? echo( "<img src=\"images/tile.gif\" width=\"".$iew."\" height=\"20\" alt=\"\" border=\"0\">" ); ?></td>
	  <td align="right"><? echo( $ie ); ?>&nbsp;</td>
    </tr>
	<tr height=20 bgcolor=#ffe5e5>
	  <td>&nbsp;Poèet užívate¾ov horšej verzie :</td>
	  <td><? echo( "<img src=\"images/tile.gif\" width=\"".$nnw."\" height=\"20\" alt=\"\" border=\"0\">" ); ?></td>
	  <td align="right"><? echo( $nn ); ?>&nbsp;</td>
    </tr>
	<tr height=15>
	  <td></td>
	  <td></td>
	  <td></td>
    </tr>
	<?
	  for ($i = 0; $i < 24; $i++)
	  { ?>
	<tr height=15 bgcolor=#ffe5e5>
	  <td>&nbsp;<? echo( $i.":00" ); ?></td>
	  <td><? echo( "<img src=\"images/tile.gif\" width=\"".$hrw[$i]."\" height=\"19\" alt=\"\" border=\"0\">" ); ?></td>
	  <td align="right"><? echo( $hr[$i] ); ?>&nbsp;</td>
    </tr>	  
	<?
	  }
	?>
  </table>
</center>
