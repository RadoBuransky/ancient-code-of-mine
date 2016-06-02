<?
  $msg = "Aktualiz·cia ˙dajov prebehla ˙speöne.";

  if (!IsSet( $file ))
    return;
	
  function DeleteTables()
  {
    $SQL = @MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
  	if ($SQL != false)
  	{
      MySQL_Select_DB( "pcprompt" );
	
	  $Result = MySQL_Query( "SELECT * FROM cenniky" , $SQL );
	  if ($Result == 0)
	    return;
		
	  $j = MySQL_Num_Rows( $Result );
	  for ($i = 0; $i < $j; $i++)
	    $tabname[$i] = MySQL_Result( $Result , $i , 1 );
		
	  for ($i = 0; $i < $j; $i++)
	  {
	    MySQL_Query( "DROP TABLE ".$tabname[$i] , $SQL );
		MySQL_Query( "DELETE FROM cenniky WHERE col1='".$tabname[$i]."'" , $SQL );
	  }
		
	  MySQL_Close( $SQL );    
  	}
	else
	  $msg = "Nepodarilo sa pripojiù na MySQL server. Sk˙ste aktualiz·ciu zopakovaù.";
  }
  
  function CreateTable( $TabName, $ColsCount )
  {    
    $SQL = @MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
  	if ($SQL != false)
  	{
      MySQL_Select_DB( "pcprompt" );
	  
	  $cols = "";
	  for ($i = 0; $i < $ColsCount; $i++)
	  {
	    if ($i > 0)
		  $cols = $cols." ,";
		  
	    $cols = $cols."col".$i." TEXT";
	  }
	  
	  $s = "CREATE TABLE ".$TabName." (".$cols.")";
	  	  
	  MySQL_Query( $s , $SQL );
	  
	  MySQL_Close( $SQL );    
  	}
	else
	  $msg = "Nepodarilo sa pripojiù na MySQL server. Sk˙ste aktualiz·ciu zopakovaù.";
  }
  
  function AddToCenniky( $TName, $TTitle )
  {
    $SQL = @MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
  	if ($SQL != false)
  	{
      MySQL_Select_DB( "pcprompt" );	  
	  MySQL_Query( "INSERT INTO cenniky (col0,col1) VALUES ('".$TTitle."','".$TName."')" , $SQL );	  
	  MySQL_Close( $SQL );    
  	}
	else
	  $msg = "Nepodarilo sa pripojiù na MySQL server. Sk˙ste aktualiz·ciu zopakovaù.";
  }
  
  function AddDataToTable( $TName, $Data, $CNum )
  {
    $SQL = @MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
  	if ($SQL != false)
  	{
      MySQL_Select_DB( "pcprompt" );
	  
	  $s = " (";
	  for ($i = 0; $i < $CNum; $i++)
	  {
	    if ($i > 0)
		  $s = $s.",";
		
	    $s = $s."col".$i;
	  }
	  $s = $s.") VALUES (";
	  
	  for ($i = 0; $i < $CNum; $i++)
	  {
	    if ($i > 0)
		  $s = $s.",";
		
	    $s = $s."'".$Data[$i]."'";
	  }
	  $s = $s.")";
	  	  	  	  
	  MySQL_Query( "INSERT INTO ".$TName.$s , $SQL );	  
	  MySQL_Close( $SQL );    
  	}
	else
	  $msg = "Nepodarilo sa pripojiù na MySQL server. Sk˙ste aktualiz·ciu zopakovaù.";
  }
  
  function GetWord( $file, &$i )
  {
    $word = "";
	
	$i++;
	do
	{	  	  
	  $word = $word.$file[$i];
	  $i++;
	}
	while (($file[$i] != "|") && ($i < strlen( $file )));
	
	return $word;
  }
  
  function ParseData()
  {
    $file = $GLOBALS[ "file" ];
    $len  = strlen( $file );
	$i	  = 0;
	$tc	  = 0;
	
	while ($i < $len)
	{
	  if ($file[$i] != "@")
        break;
	
	  $TTitle = GetWord( $file , $i );
	  $CNum   = GetWord( $file , $i );
	  $RNum   = GetWord( $file , $i );
	  
	  $TName  = "Table".$tc;
	  
	  CreateTable( $TName , $CNum );
	  AddToCenniky( $TName , $TTitle );
	  
	  for ($j = 0; $j < $RNum; $j++)
	  {
	    for ($k = 0; $k < $CNum; $k++)
		  $col[$k] = GetWord( $file , $i );
		  
		AddDataToTable( $TName , $col , $CNum );
	  }
	  
	  $i++;
	  $tc++;
	}	
  }
  
  DeleteTables();
  ParseData();  
?>

<html>
  <head>
    <script language="JavaScript">
	  <?
        echo( "window.location='index.php?section=ok&msg=".$msg."'" );
	  ?>
	</script>
  </head>
  
  <body>
  </body>
</html>