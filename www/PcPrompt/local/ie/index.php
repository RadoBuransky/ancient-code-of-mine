<? Header("Expires:".GMDate("D, d M Y H:i:s")." GMT");
   Header("Cache-Control: no-store, no-cache, must-revalidate");
   Header("Cache-Control: post-check=0, pre-check=0", false);
   Header("Pragma: no-cache"); ?>
   
<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>

<html>  
  <? require( "head.php" ); ?>
  <? $type=0; require( "addstat.php" ); ?>

  <body>
    <div align=center>
      <table width=700 height=380 cellspacing=0 cellpadding=0 class="alltable" border=0>
	    <tr height=100>
		  <td width=700>
		    <!-- TOP TABLE -->
			<table width=700 height=100 cellspacing=0 cellpadding=0 class="toptable" border=0>
			  <? require( "top.php" ); ?>
			</table>		    
		  </td>
		</tr>
		<tr height=280>
		  <td width=700 valign="top">
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