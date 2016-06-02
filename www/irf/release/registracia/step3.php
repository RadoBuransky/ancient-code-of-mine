<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<meta http-equiv="content-type" content="text/html;charset=windows-1250">
    <link rel=stylesheet href="../style.css" type="text/css" title="style.css">	
	<title>intelignetné riešenie pre firmy - registrácia nového člena</title>
</head>

<body>
  <center>
    <img src="../images/logo-big.gif" width="373" height="185" alt="" border="0">
  </center>
  <div align="center">
    <?
      echo( "<form action=\"../scripts/finish.php?name=".$GLOBALS["name"]."\" method=\"post\"> ");
	?>
    <table width=500 cellspacing=0 cellpadding=0 border=0>
      <tr height=20>
	    <td width=10></td>
		<td width=50></td>
		<td width=100></td>
		<td width=280></td>
		<td width=50></td>
		<td width=10></td>		
	  </tr>
	  <tr height=20 bgcolor=#660000>
	    <td colspan=2><img src="images/3of3.gif" width="50" height="20" alt="" border="0"></td>
		<td></td>
		<td></td>
		<td colspan=2></td>		
	  </tr>
	  <tr height=20 bgcolor=#ffcfa5>
	    <td colspan=6></td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=3><strong>zvoľte vzhľad vašej stránky</strong></td>
		<td></td>
		<td></td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=5>
		    <input name="style" type="radio" value="0" checked>
			<img src="images/style0.gif" width="100" height="75" alt="" border="0">
		</td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=5>
		    <input name="style" type="radio" value="1">
			<img src="images/style1.gif" width="100" height="75" alt="" border="0">
		</td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=5>
		    <input name="style" type="radio" value="2">
			<img src="images/style2.gif" width="100" height="75" alt="" border="0">
		</td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=5>
		    <input name="style" type="radio" value="3">
			<img src="images/style3.gif" width="100" height="75" alt="" border="0">
		</td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td colspan=6><center><input type="submit" value="dokončiť"></center></td>
	  </tr>
	  <tr height=20 bgcolor=#ffcfa5>
	    <td colspan=6></td>
	  </tr>
	  <tr height=20 bgcolor=#660000>
	    <td colspan=4></td>
		<td colspan=2><img src="../images/logo-small.gif" width="50" height="20" alt="" border="0" align="right"></td>
	  </tr>
	  <tr height=20>
	    <td></td>
	  </tr>
    </table>
	</form>
  </div>
</body>

</html>