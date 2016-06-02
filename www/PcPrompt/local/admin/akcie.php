<?
  $SQL = @MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
  if ($SQL != false)
  {
    MySQL_Select_DB( "pcprompt" );
	
	$Result = MySQL_Query( "SELECT * FROM akcie ORDER BY col0" , $SQL );
	if ($Result != 0)
	{	
	  $count = MySQL_Num_Rows( $Result );
	  for ($i = 0; $i < $count; $i++)
	    $akcie[$i] = MySQL_Result( $Result , $i , 0 ); 
	
	  MySQL_Close( $SQL );
	}
  }
?>

<script language="JavaScript">
  function SetDelItem()
  {
    var i;
	
	i = document.forms[0].elements['list'].selectedIndex; 
	document.forms[0].elements['delete'].value = document.forms[0].elements['list'].options[i].text;
  }
</script>

<form action="actiondata.php" method="post" name="myform">
<table width=600 height=250 cellpadding=0 cellspacing=0 border=0>
  <tr height=25>
    <td><center><big>Zoznam aktuálnych akcií :</big></center></td>
  </tr>
  <tr height=170>
    <td valign="top">
	  <center>
        <select name="list" size=10 onchange="SetDelItem();">
		  <?
		    for ($i = 0; $i < $count; $i++)
			  echo( "<option>".$akcie[$i] );		    
		  ?>
		  <option> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  		   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
        </select>
	  </center>
	  <center>
	    <input name="delete" type="text" value="" size=68>
	  </center>
	</td>
  </tr>  
  <tr height=25>
    <td>
	  <center>
	    <input name="delaction" type="submit" value="Zmaza akciu">
	    <input name="delallaction" type="submit" value="Zmaza všetky akcie">
	  </center>
	</td>
  </tr>
  <tr height=15>
    <td></td>
  </tr>
  <tr>
    <td>
	  <center>
	    <input name="newaction" type="text" value="" size=54><input name="addaction" type="submit" value="Prida akciu">
	  </center>
	</td>
  </tr>
</table>
</form>