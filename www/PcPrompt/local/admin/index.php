<?  
  Header("Expires:".GMDate("D, d M Y H:i:s")." GMT");
  Header("Cache-Control: no-store, no-cache, must-revalidate");
  Header("Cache-Control: post-check=0, pre-check=0", false);
  Header("Pragma: no-cache");
?>

<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>

<html>

<?
  require( "head.php" );
?>

<body onload="LoadScripts();">
  <div align="center">
    <table width=600 height=100 cellpadding=0 cellspacing=0 border=0>
	  <tr height=100>
	    <td width=100><img src="images/logo.gif" width="100" height="100" alt="" border="0"></td>
		<td><strong><font size="+5"><center>A d m i n i s t r a t o r</center></font></strong></td>
	  </tr>
	  <tr height=10>
	    <td></td>
		<td></td>
	  </tr>
	  <tr>
	    <td width=100 colspan=2>
  		  <center>
		    <table width=600 height=30 cellpadding=0 cellspacing=0 border=0>
		      <tr>
			    <td width=15 valign="top"><img src="images/lt.gif" width="15" height="15" alt="" border="0"></td>
			    <td width=190 class="CButton" id="CennikBtn" rowspan=2>Cenník</td>
			    <td width=190 class="CButton" id="StatBtn" rowspan=2>Štatistika</td>
			    <td width=190 class="CButton" id="AkcieBtn" rowspan=2>Akcie</td>
				<td width=15 valign="top"><img src="images/rt.gif" width="15" height="15" alt="" border="0"></td>
			  </tr>
			  <tr>
			    <td width=15 valign="top"><img src="images/lb.gif" width="15" height="15" alt="" border="0"></td>
				<td width=15 valign="top"><img src="images/rb.gif" width="15" height="15" alt="" border="0"></td>			    
			  </tr>
		    </table>
		  </center>
		</td>
	  </tr>
	  <tr>
	    <td colspan=2>
		  <? require( "main.php" ); ?>
		</td>
	  </tr>
	</table>
  </div>
</body>

</html>