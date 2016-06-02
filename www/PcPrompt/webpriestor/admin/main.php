<table width=600 height=250 cellpadding=0 cellspacing=0 border=0>
  <tr height=10>
    <td></td>
  </tr>
  <tr height=20>
    <td>
	  <center><big><big><strong>
	    <?
		  if (!IsSet( $section ))
		    $section = 'cennik';
			
		  switch( $section )
		  {
		    case 'cennik' : echo( "Cenník" );
				 		  	break;
			case 'stat'   : echo( "Štatistika" );
				 		  	break;
			case 'akcie'  : echo( "Akcie" );
				 		  	break;
			case 'ok'	  : echo( "Výsledok aktualizácie" );
				 		  	break;
		  }
		?>
	  </strong></big></big></center>
	</td>
  </tr>
  <tr height=10>
    <td></td>
  </tr>
  <tr>
    <td valign="top">
	  <?
	    switch( $section )
		{
		  case 'cennik' : require( "cennik.php" );
				 		  break;
		  case 'stat'   : require( "stat.php" );
				 		  break;
		  case 'akcie'  : require( "akcie.php" );
				 		  break;
		  case 'ok'		: require( "result.php" );
		  	   			  break;
		}
	  ?>
	</td>
  </tr>
</table>