<html>
  <? require( "head.php" ); ?>
  <? $type = 1; require( "../ie/addstat.php" ); ?>

  <body text=#c00000>
    <div align=center>
      <table width=680 height=380 cellspacing=0 cellpadding=0 class="alltable" border=0>
	    <tr height=100>
		  <td width=700>
		    <!-- TOP TABLE -->
			<table width=680 height=100 cellspacing=0 cellpadding=0 class="toptable" border=0>
			  <? require( "top.php" ); ?>
			</table>		    
		  </td>
		</tr>
		<tr height=280>
		  <td width=680 valign="top">
		    <!-- MAIN TABLE -->
		    <? require( "main.php" ); ?>			
		  </td>
		</tr>
	  </table>
	</div>	
	<script language='JavaScript'>
      LoadScripts();
    </script>
  </body>  
   
</html>