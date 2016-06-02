<?
  $SQL = @MySQL_Connect( "r6a4t8" , "rburansky" , "evjlls" );
  if ($SQL != false)
  {
    MySQL_Select_DB( "pcprompt" );
	
	$Result = MySQL_Query( "SELECT * FROM stat ORDER BY col0" , $SQL );
    if ($Result == 0)
	  exit;
	  
	$suma = MySQL_Result( $Result , 0 , 1 );
	
	$po	  = MySQL_Result( $Result , 1 , 1 );
  	$ut	  = MySQL_Result( $Result , 2 , 1 );
    $str  = MySQL_Result( $Result , 3 , 1 );
    $stv  = MySQL_Result( $Result , 4 , 1 );
    $pi	  = MySQL_Result( $Result , 5 , 1 );
    $so	  = MySQL_Result( $Result , 6 , 1 );
    $ne	  = MySQL_Result( $Result , 7 , 1 );
  
    $ie	  = MySQL_Result( $Result , 8 , 1 );
    $nn	  = MySQL_Result( $Result , 9 , 1 );
  
    $srch = MySQL_Result( $Result , 10 , 1 );
	
	if (IsSet( $type ))
	{
	  switch( $type )
	  {
	    case 0 : $ie++;
			   	 break;
		case 1 : $nn++;
			   	 break;
		case 2 : $srch++;
			   	 break;
	  }
	}
	else
	{
	  $suma++;
	  	
	  $today = getdate();
	
	  switch( $today['wday'] )
	  {
	    case 1 : $po++; break;
	    case 2 : $ut++; break;
	    case 3 : $str++; break;
	    case 4 : $stv++; break;
	    case 5 : $pi++; break;
	    case 6 : $so++; break;
	    case 0 : $ne++; break;	  
	  }
	  
	  $hr        = $today['hours']+11;
	  $hourvalue = MySQL_Result( $Result , $hr , 1 );
	  $hourvalue++;
	  MySQL_Query( "UPDATE stat SET col1=".$hourvalue." WHERE col0='".$hr."'" , $SQL );
	}
	
	MySQL_Query( "UPDATE stat SET col1=".$suma." WHERE col0='0'" , $SQL );
	
	MySQL_Query( "UPDATE stat SET col1=".$po." WHERE col0='1'" , $SQL );
	MySQL_Query( "UPDATE stat SET col1=".$ut." WHERE col0='2'" , $SQL );
	MySQL_Query( "UPDATE stat SET col1=".$str." WHERE col0='3'" , $SQL );
	MySQL_Query( "UPDATE stat SET col1=".$stv." WHERE col0='4'" , $SQL );
	MySQL_Query( "UPDATE stat SET col1=".$pi." WHERE col0='5'" , $SQL );
	MySQL_Query( "UPDATE stat SET col1=".$so." WHERE col0='6'" , $SQL );
	MySQL_Query( "UPDATE stat SET col1=".$ne." WHERE col0='7'" , $SQL );
	
	MySQL_Query( "UPDATE stat SET col1=".$ie." WHERE col0='8'" , $SQL );
	MySQL_Query( "UPDATE stat SET col1=".$nn." WHERE col0='9'" , $SQL );
	
	MySQL_Query( "UPDATE stat SET col1=".$srch." WHERE col0='10'" , $SQL );
		
	MySQL_Close( $SQL );
  }
?>