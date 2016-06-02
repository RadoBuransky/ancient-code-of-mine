<?
  $SQL = @MySQL_Connect( "sultan.webpriestor.sk" , "pcpromptsk" , "6ep2h4te" );
  if ($SQL != false)
  {
    MySQL_Select_DB( "pcpromptsk" );
	
	$count = -1;
	
	$Result = MySQL_Query( "SELECT * FROM akcie" , $SQL );
    if ($Result != 0)
	  $count = MySQL_Num_Rows( $Result );
	  
	if ($count > 0)
	{
	  $i = rand( 0 , $count-1 );
?>
<tr>
  <td colspan=3>
    <table width=700 height=20 cellpadding=0 cellspacing=0 border=0>
	  <tr>
	    <td width=10><img src="images/l.gif" width="10" height="20" alt="" border="0"></td>
		<td bgcolor=#ffe5e5>		      
		  <MARQUEE STYLE="height: 20px; border: 0pt solid; width: 680px" DIRECTION="Left">
		    <b><? echo( MySQL_Result( $Result , $i , 0 ) ); ?></b>
		  </marquee>
		</td>
		<td width=10><img src="images/r.gif" width="10" height="20" alt="" border="0"></td>
	  </tr>
	</table>
  </td>
</tr>
<tr height=10>
  <td colspan=3></td>
</tr>
<?
    }
		
	MySQL_Close( $SQL );
  }
?>

<tr height=100>
  <td width=100><a href="../"><img src="images/logo.gif" width="100" height="100" alt="Návrat na hlavnú stránku" border="0"></a></td>
  <td width=20></td>  
  <td width=580>
    <table width=580 height=100 cellpadding=0 cellspacing=0 border=0>
	  <tr height=15>
	    <td width=15><img src="images/lt.gif" width="15" height="15" alt="" border="0"></td>
		<td colspan=7 rowspan=2 width=550><img src="images/reklama.gif" width="550" height="80" alt="" border="0"></td>  
		<td width=15><img src="images/rt.gif" width="15" height="15" alt="" border="0"></td>		
	  </tr>
	  <tr height=65>
	    <td bgcolor=#eb4040></td>
		<td bgcolor=#eb4040></td>
	  </tr>
	  <tr height=5>
	    <td bgcolor=#eb4040></td>
	    <td width=142 rowspan=2 class="menuitem" id="menu0" style="cursor:hand" onmouseover="SetActiveMenu( submenu0 ); SetText( 'Aktuálny cenník' );" onmouseout="SetActiveMenu( nosubmenu ); SetText( '' );">Cenník</td>
		<td width=4 rowspan=2 style="background-color:#eb4040; color:#ffffff">|</td>
		<td width=142 rowspan=2 class="menuitem" id="menu1" style="cursor:hand" onmouseover="SetText( 'Kúpna zmluva' );" onmouseout="SetText( '' );">Kúpna zmluva</td>
		<td width=4 rowspan=2 style="background-color:#eb4040; color:#ffffff">|</td>
		<td width=142 rowspan=2 class="menuitem" id="menu2" style="cursor:hand" onmouseover="SetText( 'Reklamaèné podmienky' );" onmouseout="SetText( '' );">Reklamácie</td>
		<td width=4 rowspan=2 style="background-color:#eb4040; color:#ffffff">|</td>
		<td width=142 rowspan=2 class="menuitem" id="menu3" style="cursor:hand" onmouseover="SetActiveMenu( submenu3 ); SetText( 'Kontakt na nás' );" onmouseout="SetActiveMenu( nosubmenu ); SetText( '' );">Kontakt</td>
		<td bgcolor=#eb4040></td>
	  </tr>
	  <tr height=15>
	    <td><img src="images/lb.gif" width="15" height="15" alt="" border="0"></td>
		<td><img src="images/rb.gif" width="15" height="15" alt="" border="0"></td>
	  </tr>
	  <tr>
	    <td>
		<td>		  
          <div id="submenu0" class="offsubmenu" onmouseout="SetActiveMenu( nosubmenu )" onmouseover="SetActiveMenu( submenu0 )">
            <table width=190 cellspacing=0 cellpadding=0 class="submenu" style="position:absolute">
			  <tr>
			    <td width=15></td>
				<td width=160></td>
				<td width=15></td>
			  </tr>
			  <?
			    $i = 0;
				do
				{
			      $SQL = @MySQL_Connect( "sultan.webpriestor.sk" , "pcpromptsk" , "6ep2h4te" );
				  $i++;
				} while (($SQL == false) && ($i < 5));
				
    			if ($SQL != false)
    			{  
    			MySQL_Select_DB( "pcpromptsk" , $SQL );
				$Result = @MySQL_Query( "SELECT * FROM cenniky ORDER BY COL0" , $SQL );
	
				$j = MySQL_Num_Rows( $Result );
				for ($i = 0; $i < $j; $i++)	
				{
	  			  $Nazov = MySQL_Result( $Result , $i , 0 );
	  			  $TabName = MySQL_Result( $Result , $i , 1 );	  
		
	  			  echo( "<tr height=20>\n" );
  	              echo( "<td align=\"center\" colspan=3 class=\"tableitem\" id=\"".$TabName."\" style=\"cursor:hand;color:#ffffff\" onmouseover=\"SetText( 'Zobrazí cenník ".$Nazov."' );\" onmouseout=\"SetText( '' );\">".$Nazov."</td>\n" );
				  echo( "</tr>\n" );	  
				} 
	    
    			MySQL_Close( $SQL );
				}
  			  ?>
			  <tr height=20>
  	            <td align="center" colspan=3 class="tableitem" id="komplet" style="cursor:hand;color:#ffffff" onmouseover="SetText( 'Stiahnutie cenníka' );" onmouseout="SetText( '' );">Kompletný cenník (zip)</td>
			  </tr>
			  <tr height=20>
  	            <td align="center" colspan=3 class="tableitem" id="zostava" style="cursor:hand;color:#ffffff" onmouseover="SetText( 'Zobrazí naše zostavy' );" onmouseout="SetText( '' );">Naše zostavy</td>
			  </tr>
			  <tr height=15>
			    <form action="search.php" method="post"><td align="center" colspan=3 style="color:#ffffff"><input name="search" type="text" value="" size=22 onmouseover="SetText( 'Vyh¾adávanie v aktuálnych cenníkoch' );" onmouseout="SetText( '' );"></td></form>
			  </tr>
			  <tr height=15>
	            <td><img src="images/lb.gif" width="15" height="15" alt="" border="0"></td>
				<td></td>
				<td><img src="images/rb.gif" width="15" height="15" alt="" border="0"></td>
              </tr>
            </table>
          </div>
        </td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td>
          <div id="submenu3" class="offsubmenu" onmouseout="SetActiveMenu( nosubmenu )" onmouseover="SetActiveMenu( submenu3 )">
            <table width=135 cellspacing=0 cellpadding=0 class="submenu" style="position:absolute">
			  <tr>
			    <td width=15></td>
				<td width=105></td>
				<td width=15></td>
			  </tr>
              <tr height=20>
  	            <td colspan=3 class="menuitem" id="submenu30" style="cursor:hand" onmouseover="SetText( 'Bratislavské sídlo firmy' );" onmouseout="SetText( '' );">Bratislava</td>
	          </tr>
	          <tr height=20>
  	            <td colspan=3 class="menuitem" id="submenu31" style="cursor:hand" onmouseover="SetText( 'Trenèianske sídlo firmy' );" onmouseout="SetText( '' );">Trenèín</td>
	          </tr>	  
	          <tr height=15>
	            <td><img src="images/lb.gif" width="15" height="15" alt="" border="0"></td>
				<td></td>
				<td><img src="images/rb.gif" width="15" height="15" alt="" border="0"></td>
              </tr>
            </table>
          </div>
        </td>
        <td><div id="nosubmenu" class="offsubmenu"></div></td>
		</td>
	  </tr>	      
	</table>
  </td>      
</tr>