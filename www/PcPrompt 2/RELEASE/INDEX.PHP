<html>
  <? require( "head.php" ); ?>

  <body>  
    <div align=center>
      <table width=700 cellspacing=0 cellpadding=0 class="alltable">
	    <tr height=100>
		  <td colspan=3 width=700>
		    <!-- TOP TABLE -->
			<table width=700 height=100 cellspacing=0 class="toptable">
			  <? require( "top.php" ); ?>
			</table>		    
		  </td>
		</tr>
		<tr height=10>
		  <td colspan=3></td>
		</tr>
		<tr>
		  <td width=100>  
		    <!-- MENU TABLE -->
		    <table width=100 cellspacing=0 cellpadding=0 class="menutable">
			  <? require( "menu.php" ); ?>			  		  
		    </table>			
		  </td>
		  <td width=15>
		  </td>
		  <td width=585 valign=top>
		    <!-- MAIN TABLE -->
		    <table width=585 cellspacing=0 cellpadding=0 class="maintable">
			  <? require( "main.php" ); ?>			  
			</table>		   
		  </td>
		</tr>		
	  </table>
	</div>	
	<script language='JavaScript'>
      LoadScripts();
    </script>
  </body>  
   
</html>