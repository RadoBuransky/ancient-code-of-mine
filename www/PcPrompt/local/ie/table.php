<? Header("Expires:".GMDate("D, d M Y H:i:s")." GMT");
   Header("Cache-Control: no-store, no-cache, must-revalidate");
   Header("Cache-Control: post-check=0, pre-check=0", false);
   Header("Pragma: no-cache"); ?>
   
<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>
   
<html>
  <? require( "head.php" ); ?>

  <body>
    <div align=center>
      <table width=700 height=380 cellspacing=0 cellpadding=0 class="alltable" border=0>
	    <tr height=100>
		  <td width=700>
		    <!-- TOP TABLE -->
			<table width=700 height=100 cellspacing=0 cellpadding=0 class="toptable">
			  <? require( "top.php" ); ?>
			</table>		    
		  </td>
		</tr>
		<tr height=280>
		  <td width=700 valign="top">
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
			  $Result = MySQL_Query( "SELECT * FROM ".$tabname." ORDER BY COL3" , $SQL );
			  
			  echo( "<table width=700 cellspacing=0 cellpadding=0 border=0>\n" );			  
			  echo( "<tr height=50><td colspan=5 align=\"center\"><big><big><big>".$Nazov."</big></big></big></td></tr>\n" );
			  echo( "<tr height=20 style=\"color:#ffffff\">\n" );
			  echo( "<td width=15 valign=\"top\" bgcolor=#eb4040><img src=\"images/lt.gif\" width=15 height=15 border=0></td>\n" );
			  echo( "<td bgcolor=#eb4040>Názov a popis produktu</td>\n" );
			  echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Cena bez DPH</td>\n" );
			  echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Záruèná doba</td>\n" );
			  echo( "<td width=15 valign=\"top\" bgcolor=#eb4040><img src=\"images/rt.gif\" width=15 height=15 border=0></td>\n" );
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
				
				echo( "<tr height=20 id=\"tablerow$i\" onmouseover=\"SetActiveRow( tablerow$i )\" onmouseout=\"SetInactiveRow( tablerow$i )\" style=\"cursor:default\">\n" );
				echo( "<td></td>\n" );
				echo( "<td>".$Nazov."</td>\n" );
				echo( "<td align=\"center\">".$Cena."</td>\n" );
				echo( "<td align=\"center\">".$Zaruka."</td>\n" );
				echo( "<td></td>\n" );
				echo( "</tr>\n" );
				
				if ($i < $j-1)
				{
				  echo( "<tr height=1 bgcolor=#c00000>\n" );
				  echo( "<td></td>\n" );
				  echo( "<td></td>\n" );
				  echo( "<td></td>\n" );
				  echo( "<td></td>\n" );
				  echo( "<td></td>\n" );
				  echo( "</tr>\n" );
				}						
			  }
			  
			  echo( "<tr height=20 style=\"color:#ffffff\">\n" );
			  echo( "<td width=15 valign=\"bottom\" bgcolor=#eb4040><img src=\"images/lb.gif\" width=15 height=15 border=0></td>\n" );
			  echo( "<td bgcolor=#eb4040>Názov a popis produktu</td>\n" );
			  echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Cena bez DPH</td>\n" );
			  echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Záruèná doba</td>\n" );
			  echo( "<td width=15 valign=\"bottom\" bgcolor=#eb4040><img src=\"images/rb.gif\" width=15 height=15 border=0></td>\n" );
			  echo( "</tr>\n" );  
			  
			  echo( "</table>\n" );
			  
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