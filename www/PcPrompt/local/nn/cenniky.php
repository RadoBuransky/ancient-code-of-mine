&nbsp;
<table width=670 height=250 cellspacing=0 cellpadding=5 border=0 style="color:#c00000">
  <tr height=10>
    <td width=150 valign="top">
	  <table width=150 cellspacing=0 cellpadding=5 border=0 style="color:#c00000">
	    <?
		  $SQL = @MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
    	  if ($SQL != false)
		  {
		  
		  MySQL_Select_DB( "pcprompt" );
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
	  </table>
	</td>
	<td width=520 align="center" valign="top">
	  <big><big><big><font color=#c00000>Vyberte si z našej ponuky vždy aktuálnych cenníkov !</font></big></big></big>
	</td>
  </tr>
</table>