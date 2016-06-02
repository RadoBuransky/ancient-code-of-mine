<? Header("Expires:".GMDate("D, d M Y H:i:s")." GMT");
   Header("Cache-Control: no-store, no-cache, must-revalidate");
   Header("Cache-Control: post-check=0, pre-check=0", false);
   Header("Pragma: no-cache"); ?>
   
<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>

<html>
  <? require( "head.php" ); ?>
  <? $type=2; require( "addstat.php" ); ?>

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
			  if ($search == '')
			    $search = ' ';
			
			  echo( "<table width=700 cellspacing=0 cellpadding=0 border=0>" );
			  echo( "<tr height=10><td></td></tr>" );
			  echo( "<tr><td width=700><center><big><big><big>V˝sledok vyhæad·vania kæ˙ËovÈho slova \"".$search."\"</big></big></big></center></td></tr>" );
			  echo( "</table>" );
			
			  $i = 0;
			  do
			  {
			    $SQL = @MySQL_Connect( "sultan.webpriestor.sk" , "pcpromptsk" , "6ep2h4te" );
				$i++;
			  } while (($SQL == false) && ($i < 5));
			  
			  if ($SQL != false)
			  {				
			  MySQL_Select_DB( "pcpromptsk" );
			  
			  // Find all tables
			  $Result = MySQL_Query( "SELECT * FROM cenniky ORDER BY COL0" , $SQL );
			  if ($Result == 0)
			    exit;
				
			  $EverFound = false;
			  $rowcounter = 0;
				
			  $j = MySQL_Num_Rows( $Result );
			  for ($i = 0; $i < $j; $i++)	
			  {
	  			$NazovTabulky = MySQL_Result( $Result , $i , 0 );
	  			$TabName = MySQL_Result( $Result , $i , 1 );
				
				$Result2 = MySQL_Query( "SELECT * FROM ".$TabName." ORDER BY COL3" , $SQL );
				if ($Result2 == 0)
				  break;
				  
				$k = MySQL_Num_Rows( $Result2 );				
				if ($k == 0)
				  continue;
				  
				$Items = Array();
				$Count = 0;
				
				$Found = false;  
				for ($l = 0; $l < $k; $l++)
			    {				
			      $Nazov = MySQL_Result( $Result2 , $l , 0 );
				  $Cena = MySQL_Result( $Result2 , $l , 1 );
				  $Zaruka = MySQL_Result( $Result2 , $l , 2 );
				  
				  if (($Cena == '') &&
				      ($Zaruka == ''))
				    continue;
				  
				  $pos = strpos( strtoupper( $Nazov ) , strtoupper( $search ) );
				  
				  if ($pos === false)
				  {
				  }
				  else
				  {
				    $Found = true;
					$EverFound = true;
					
					$Items[$Count][0] = $Nazov;
					$Items[$Count][1] = $Cena;
					$Items[$Count][2] = $Zaruka;
					
					$Count++;
				  }
			    }
				
				if (!$Found)
				  continue;
				
				echo( "<table width=700 cellspacing=0 cellpadding=0 border=0>" );
				echo( "<tr height=50><td colspan=5 align=\"center\"><big><big><big><div class=\"searchtable\" id=\"".$TabName."\" style=\"cursor:hand\" onmouseover=\"SetText( 'ZobrazÌ cennÌk ".$NazovTabulky."' );\" onmouseout=\"SetText( '' );\">".$NazovTabulky."</div></big></big></big></td></tr>" );
			    echo( "<tr height=20 style=\"color:#ffffff\">" );
			    echo( "<td width=15 valign=\"top\" bgcolor=#eb4040><img src=\"images/lt.gif\" width=15 height=15 border=0></td>" );
			    echo( "<td bgcolor=#eb4040>N·zov a popis produktu</td>" );
			    echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Cena bez DPH</td>" );
			    echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Z·ruËn· doba</td>" );
			    echo( "<td width=15 valign=\"top\" bgcolor=#eb4040><img src=\"images/rt.gif\" width=15 height=15 border=0></td>" );
			    echo( "</tr>" );
				
			    for ($l = 0; $l < $Count; $l++)
				{
				  echo( "<tr height=20 id=\"tablerow$rowcounter\" onmouseover=\"SetActiveRow( tablerow$rowcounter )\" onmouseout=\"SetInactiveRow( tablerow$rowcounter )\" style=\"cursor:default\">" );
				  echo( "<td></td>" );
				  echo( "<td>".$Items[$l][0]."</td>" );
				  echo( "<td align=\"center\">".$Items[$l][1]."</td>" );
				  echo( "<td align=\"center\">".$Items[$l][2]."</td>" );
				  echo( "<td></td>" );
				  echo( "</tr>" );
				  
				  if ($l < $Count-1)
				  {
				    echo( "<tr height=1 bgcolor=#c00000>\n" );
				    echo( "<td></td>\n" );
				    echo( "<td></td>\n" );
				    echo( "<td></td>\n" );
				    echo( "<td></td>\n" );
				    echo( "<td></td>\n" );
				    echo( "</tr>\n" );
				  }
				
				  $rowcounter++;		
			    }
			  
			    echo( "<tr height=20 style=\"color:#ffffff\">" );
			    echo( "<td width=15 valign=\"bottom\" bgcolor=#eb4040><img src=\"images/lb.gif\" width=15 height=15 border=0></td>" );
			    echo( "<td bgcolor=#eb4040>N·zov a popis produktu</td>" );
			    echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Cena bez DPH</td>" );
			    echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Z·ruËn· doba</td>" );
			    echo( "<td width=15 valign=\"bottom\" bgcolor=#eb4040><img src=\"images/rb.gif\" width=15 height=15 border=0></td>" );
			    echo( "</tr>" );  
			  
			    echo( "</table>" );	  
			  }
			  
			  if (!$EverFound)
			  {
			    echo( "<table width=700 cellspacing=0 cellpadding=0 border=0>" );
			    echo( "<tr height=10><td></td></tr>" );
			    echo( "<tr><td width=700><center>éiadna poloûka v naöom cennÌku nevyhovovala V·ömu kæ˙ËovÈmu slovu.</center></td></tr>" );
			    echo( "<tr><td width=700><center>Sk˙ste zadaù kratöie, alebo jednoduchöie kæ˙ËovÈ slovo.</center></td></tr>" );
			    echo( "</table>" );
			  }
			  
			  MySQL_Close( $SQL );
			  }
			  else
			  {
			    echo( "<table width=700 cellspacing=0 cellpadding=0 border=0>" );
			    echo( "<tr height=10><td></td></tr>" );
			    echo( "<tr><td width=700><center>éiadna poloûka v naöom cennÌku nevyhovovala V·ömu kæ˙ËovÈmu slovu.</center></td></tr>" );
			    echo( "<tr><td width=700><center>Sk˙ste zadaù kratöie, alebo jednoduchöie kæ˙ËovÈ slovo.</center></td></tr>" );
			    echo( "</table>" );
			  }
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