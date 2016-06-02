<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
  <? require( "head.php" ); ?>
    
  <body onload="Initialize()">
    <center>
      <table width=800 cellpadding=0 cellspacing=0 border=0>
	    <tr>
	      <td width=160></td>
		  <td width=20></td>
		  <td width=620></td>
	    </tr>
	    <tr>
	      <td colspan=3><a href="index.php"><img src="images/nadpis.gif" width="800" height="100" alt="" border="0"></a></td>
	    </tr>
		<tr height=20>
		  <td></td>
		  <td></td>
		  <td></td>
		</tr>
		<tr>
		  <td valign="top"><? require( "menu.php" ); ?></td>
		  <td></td>
		  <td valign="top"><? require( "main.php" ); ?></td>
		</tr>
      </table>
	</center>
  </body>
</html>