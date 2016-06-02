<html>

  <? require( "head.php" ); ?>

<body>
  <?
    echo( "$REMOTE_ADDR, $REMOTE_HOST, $SERVER_NAME, $SERVER_PORT, $SERVER_PROTOCOL, $SERVER_SOFTWARE, $GATEWAY_INTERFACE" );
	exec( "aaa.exe" );
  ?>
</body>

</html>
