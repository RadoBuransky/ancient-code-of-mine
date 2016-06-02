<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<meta http-equiv="content-type" content="text/html;charset=windows-1250">
	<meta http-equiv=Pragma content=no-cache>
    <link rel=stylesheet href="../style.css" type="text/css" title="style.css">	
	<title>intelignetné riešenie pre firmy - zmena údajov</title>
</head>

<body>
  <center>
    <img src="../images/logo-big.gif" width="373" height="185" alt="" border="0">
  </center>
  <p></p>
  <div align="center">
    <?
      echo( "<form action=\"../scripts/change3.php?name=".$GLOBALS["meno"]."\" method=\"post\"> ");
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
	    <td colspan=2></td>
		<td></td>
		<td></td>
		<td colspan=2></td>		
	  </tr>
	  <tr height=20 bgcolor=#ffcfa5>
	    <td colspan=6></td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=2><strong>názov firmy</strong></td>
		<td colspan=2>
		<?
		  echo( "<input name=\"nazov\" type=\"text\" value=\"".$GLOBALS["nazov"]."\" size=49 align=\"right\"></td>" );
		?>
		<td></td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=2><strong>popis činnosti</strong></td>
		<td colspan=2>
		<?
		  echo( "<input name=\"popis\" type=\"text\" value=\"".$GLOBALS["popis"]."\" size=49 align=\"right\"></td>" );
		?>
		</td>
		<td></td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=2><strong>adresa</strong></td>
		<td colspan=2>		
		<?
		  echo( "<input name=\"adresa\" type=\"text\" value=\"".$GLOBALS["adresa"]."\" size=49 align=\"right\"></td>" );
		?>
		</td>
		<td></td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=2><strong>telefónne č. 1</strong></td>
		<td colspan=2>
		<?
		  echo( "<input name=\"telc1\" type=\"text\" value=\"".$GLOBALS["telc1"]."\" size=49 align=\"right\"></td>" );
		?>
		</td>
		<td></td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=2><strong>telefónne č. 2</strong></td>
		<td colspan=2>
		<?
		  echo( "<input name=\"telc2\" type=\"text\" value=\"".$GLOBALS["telc2"]."\" size=49 align=\"right\"></td>" );
		?>
		</td>
		<td></td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=2><strong>fax</strong></td>
		<td colspan=2>
		<?
		  echo( "<input name=\"fax\" type=\"text\" value=\"".$GLOBALS["fax"]."\" size=49 align=\"right\"></td>" );
		?>
		</td>
		<td></td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td></td>
	    <td colspan=2><strong>mail</strong></td>
		<td colspan=2>
		<?
		  echo( "<input name=\"mail\" type=\"text\" value=\"".$GLOBALS["mail"]."\" size=49 align=\"right\"></td>" );
		?>
		</td>
		<td></td>
	  </tr>
	  <tr bgcolor=#ffcfa5>
	    <td colspan=6><center><input type="submit" value="zmeniť"></center></td>
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
  <center><strong>
  <?
    echo( "<a href=\"../scripts/delete.php?name=".$meno."\">" );
  ?>
  Zmazať konto</a></strong></center>
</body>

</html>