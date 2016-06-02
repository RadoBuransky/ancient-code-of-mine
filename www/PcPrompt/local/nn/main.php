    <?
      if (!IsSet( $section ))
	    require( "default.php" );
	  else
	  {
	    $s = $section.".php";
		require( $s );	  
	  }
    ?>