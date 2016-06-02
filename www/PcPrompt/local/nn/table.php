<html>
  <? require( "head.php" ); ?>

  <body text=#c00000>
    <div align=center>
      <table width=680 height=100 cellspacing=0 cellpadding=0 class="alltable" border=0>
	    <tr height=100>
		  <td width=700>
		    <!-- TOP TABLE -->
			<table width=680 height=100 cellspacing=0 cellpadding=0 class="toptable" border=0>
			  <? require( "top.php" ); ?>
			</table>		    
		  </td>
		</tr>
		<tr height=280>
		  <td width=700 valign="top">
		    &nbsp;
		    <!-- TABLE -->
			<?
			  //$SQL = MySQL_Connect( "db.host.sk" , "pcprompt" , "evjlls" );
			  $SQL = MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
			  if ($SQL == false)
			    exit;
				
			  MySQL_Select_DB( "pcprompt" );
			  $Result = MySQL_Query( "SELECT * FROM cenniky WHERE COL1='".$tabname."'" , $SQL );
			  $j = MySQL_Num_Rows( $Result );
			  if ($j == 0)
			    $Nazov = 'neznáma tabu¾ka';
			  else
			    $Nazov = MySQL_Result( $Result , 0 , 0 );			  
			  $Result = MySQL_Query( "SELECT * FROM ".$tabname." ORDER BY COL0" , $SQL );
			  
			  echo( "<table width=680 cellspacing=0 cellpadding=0 border=0>" );			  
			  echo( "<tr height=50><td colspan=5 align=\"center\"><big><big><big>".$Nazov."</big></big></big></td></tr>" );
			  echo( "<tr height=20 style=\"color:#ffffff\">" );
			  echo( "<td width=15 valign=\"top\" bgcolor=#eb4040><img src=\"images/lt.gif\" width=15 height=15 border=0></td>" );
			  echo( "<td width=450 bgcolor=#eb4040><font color=#ffffff>Názov a popis produktu</font></td>" );
			  echo( "<td width=100 bgcolor=#eb4040 align=\"center\"><font color=#ffffff>Cena</font></td>" );
			  echo( "<td width=100 bgcolor=#eb4040 align=\"center\"><font color=#ffffff>Záruèná doba</font></td>" );
			  echo( "<td width=15 valign=\"top\" align=\"right\" bgcolor=#eb4040><img src=\"images/rt.gif\" width=15 height=15 border=0></td>" );
			  echo( "</tr>" );			  
			  
			  if ($Result == 0)
			    $j = 0;
			  else
			    $j = MySQL_Num_Rows( $Result );
			  for ($i = 0; $i < $j; $i++)
			  {
			    $Nazov = MySQL_Result( $Result , $i , 0 );
				$Cena = MySQL_Result( $Result , $i , 1 );
				$Zaruka = MySQL_Result( $Result , $i , 2 );
				
				echo( "<tr height=20>" );
				echo( "<td></td>" );
				echo( "<td>".$Nazov."</td>" );
				echo( "<td align=\"center\">".$Cena."</td>" );
				echo( "<td align=\"center\">".$Zaruka."</td>" );
				echo( "</tr>" );							
			  }
			  
			  echo( "<tr height=20 style=\"color:#ffffff\">" );
			  echo( "<td width=15 valign=\"bottom\" bgcolor=#eb4040><img src=\"images/lb.gif\" width=15 height=15 border=0></td>" );
			  echo( "<td bgcolor=#eb4040><font color=#ffffff>Názov a popis produktu</font></td>" );
			  echo( "<td width=100 bgcolor=#eb4040 align=\"center\"><font color=#ffffff>Cena</font></td>" );
			  echo( "<td width=100 bgcolor=#eb4040 align=\"center\"><font color=#ffffff>Záruèná doba</font></td>" );
			  echo( "<td width=15 valign=\"bottom\" align=\"right\" bgcolor=#eb4040><img src=\"images/rb.gif\" width=15 height=15 border=0></td>" );
			  echo( "</tr>" );  
			  
			  echo( "</table>" );
			  
			  MySQL_Close( $SQL );
			?>		    			
		  </td>
		</tr>
	  </table>
	</div>	
	<script language='JavaScript'>
      LoadScripts();
    </script>
  </body>  
   
</html>