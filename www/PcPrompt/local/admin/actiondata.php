<?
  $SQL = @MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
  if ($SQL != false)
  {
    MySQL_Select_DB( "pcprompt" );
	
    if (IsSet( $addaction ))
    {
	  MySQL_Query( "INSERT INTO akcie (col0) VALUES ('".$newaction."')" , $SQL );    
    }
    else
      if (IsSet( $delaction ))
	  {
	    MySQL_Query( "DELETE FROM akcie WHERE col0='".$delete."'" , $SQL );	    
	  }
	  else
	    if (IsSet( $delallaction ))
	    {
	      MySQL_Query( "DELETE FROM akcie WHERE 1" , $SQL );	    
	    }
	  
	MySQL_Close( $SQL );
  }    
?>
<script language="JavaScript">
  window.location='index.php?section=akcie';
</script>
