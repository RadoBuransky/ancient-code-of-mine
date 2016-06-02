<?
  if (!IsSet( $page ))
    require( "default.php" );
  else
    require( $page.".php" );
?>