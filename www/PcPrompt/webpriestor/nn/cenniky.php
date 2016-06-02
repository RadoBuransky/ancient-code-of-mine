&nbsp;
<table width=670 cellspacing=0 cellpadding=5 border=0 style="color:#c00000">
  <tr height=10>
    <td width=150 valign="top">
	  <table width=150 cellspacing=0 cellpadding=5 border=0 style="color:#c00000">
	    <?
		  $i = 0;			  
	      do
		  {
	        $SQL = @MySQL_Connect( "sultan.webpriestor.sk" , "pcpromptsk" , "6ep2h4te" );
		    $i++;
		  } while (($SQL == false) && ($i < 5));
		  
    	  if ($SQL != false)
		  {		  
		    MySQL_Select_DB( "pcpromptsk" );
		    $Result = @MySQL_Query( "SELECT * FROM cenniky ORDER BY COL0" , $SQL );
	
		    $j = MySQL_Num_Rows( $Result );
		    for ($i = 0; $i < $j; $i++)	
		    {
	  		  $Nazov = MySQL_Result( $Result , $i , 0 );
	  		  $TabName = MySQL_Result( $Result , $i , 1 );	  
		
	  		  echo( "<tr bgcolor=#eb4040>\n" );
  	          echo( "<td align=\"center\"><a href=\"table.php?tabname=".$TabName."\"><font color=#ffffff>".$Nazov."</font></a></td>\n" );
			  echo( "</tr>\n" );	  
		    } 
	    
		    MySQL_Close( $SQL );
		  }
  		?>
	  <tr bgcolor=#eb4040>
  	    <td align="center"><a href="zostavy.xls"><font color=#ffffff>Naše zostavy</font></a></td>
	  </tr>
	  </table>
	</td>
	<td width=520 align="center" valign="top">
	  <big><big><big><font color=#c00000>Vyberte si z našej ponuky vždy aktuálnych cenníkov !</font></big></big></big>
	</td>
  </tr>
</table>