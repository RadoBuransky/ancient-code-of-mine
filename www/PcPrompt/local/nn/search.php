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
			  if ($search == '')
			    $search = ' ';
			
			  echo( "<table width=700 cellspacing=0 cellpadding=0 border=0>" );
			  echo( "<tr height=10><td></td></tr>" );
			  echo( "<tr><td width=700><center><big><big><big>V˝sledok vyhæad·vania kæ˙ËovÈho slova \"".$search."\"</big></big></big></center></td></tr>" );
			  echo( "</table>" );
			
			  //$SQL = MySQL_Connect( "db.host.sk" , "pcprompt" , "evjlls" );
			  $SQL = MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
			  if ($SQL == false)
			    exit;
				
			  MySQL_Select_DB( "pcprompt" );
			  
			  // Find all tables
			  $Result = MySQL_Query( "SELECT * FROM cenniky ORDER BY COL0" , $SQL );
			  if ($Result == 0)
			    exit;
				
			  $EverFound = false;
				
			  $j = MySQL_Num_Rows( $Result );
			  for ($i = 0; $i < $j; $i++)	
			  {
	  			$NazovTabulky = MySQL_Result( $Result , $i , 0 );
	  			$TabName = MySQL_Result( $Result , $i , 1 );
				
				$Result2 = MySQL_Query( "SELECT * FROM ".$TabName , $SQL );
				if ($Result2 == 0)
				  break;
				  
				$k = MySQL_Num_Rows( $Result2 );				
				if ($k == 0)
				  break;
				  
				$Items = Array();
				$Count = 0;
				
				$Found = false;  
				for ($l = 0; $l < $k; $l++)
			    {				
			      $Nazov = MySQL_Result( $Result2 , $l , 0 );
				  $Cena = MySQL_Result( $Result2 , $l , 1 );
				  $Zaruka = MySQL_Result( $Result2 , $l , 2 );
				  
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
				
				for ($l = 0; $l < $Count; $l++)
				  for ($k = $l+1; $k < $Count; $k++)
				  {
					if (strcmp( strtoupper( $Items[$l][0] ) , strtoupper( $Items[$k][0] ) ) > 0)
					{
					  $z = $Items[$k];
					  $Items[$k] = $Items[$l];
					  $Items[$l] = $z; 
					}
				  }
				
				if (!$Found)
				  continue;
				
				echo( "<table width=700 cellspacing=0 cellpadding=0 border=0>" );
				echo( "<tr height=50><td colspan=5 align=\"center\"><big><big><big>".$NazovTabulky."</big></big></big></td></tr>" );
			    echo( "<tr height=20 style=\"color:#ffffff\">" );
			    echo( "<td width=15 valign=\"top\" bgcolor=#eb4040><img src=\"../images/lt.gif\" width=15 height=15 border=0></td>" );
			    echo( "<td bgcolor=#eb4040>N·zov a popis produktu</td>" );
			    echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Cena</td>" );
			    echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Z·ruËn· doba</td>" );
			    echo( "<td width=15 valign=\"top\" bgcolor=#eb4040><img src=\"../images/rt.gif\" width=15 height=15 border=0></td>" );
			    echo( "</tr>" );
				
			    for ($l = 0; $l < $Count; $l++)
				{
				  echo( "<tr height=20>" );
				  echo( "<td></td>" );
				  echo( "<td>".$Items[$l][0]."</td>" );
				  echo( "<td align=\"center\">".$Items[$l][1]."</td>" );
				  echo( "<td align=\"center\">".$Items[$l][2]."</td>" );
				  echo( "</tr>" );		
			    }
			  
			    echo( "<tr height=20 style=\"color:#ffffff\">" );
			    echo( "<td width=15 valign=\"bottom\" bgcolor=#eb4040><img src=\"../images/lb.gif\" width=15 height=15 border=0></td>" );
			    echo( "<td bgcolor=#eb4040>N·zov a popis produktu</td>" );
			    echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Cena</td>" );
			    echo( "<td width=100 bgcolor=#eb4040 align=\"center\">Z·ruËn· doba</td>" );
			    echo( "<td width=15 valign=\"bottom\" bgcolor=#eb4040><img src=\"../images/rb.gif\" width=15 height=15 border=0></td>" );
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