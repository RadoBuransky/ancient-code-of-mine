<head>
  <link rel=stylesheet href="style.css" type="text/css" title="style.css">
  <meta http-equiv="content-type" content="text/html;charset=windows-1250">
  <title>PcPrompt - Administrator</title>
  
  <script language="JavaScript">
    function MouseOver()
	{
	  src = event.toElement;
	  
	  if (src.className == 'CButton')
	    src.style.background = 'c00000';
	}
	
	function MouseOut()
	{
	  src = event.fromElement;
	  
	  if (src.className == 'CButton')
	    src.style.background = 'eb4040';
	}
	
	function RunClick()
	{
	  if (src.className != 'CButton')
	    return;
		
	  switch (src.id)
	  {
	    case 'CennikBtn' : window.location='index.php?section=cennik';
			 			   break;
		case 'StatBtn'   : window.location='index.php?section=stat';
			 			   break;
		case 'AkcieBtn'  : window.location='index.php?section=akcie';
			 			   break;
	  }
	}
	
	function LoadScripts()
	{
	  window.document.body.onmouseover = MouseOver;
	  window.document.body.onmouseout  = MouseOut;
	  window.document.body.onclick     = RunClick;
	};
  </script>
</head>