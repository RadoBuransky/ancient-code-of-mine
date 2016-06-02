<head>
  <link rel=stylesheet href="style.css" type="text/css" title="style.css">
  <meta http-equiv="content-type" content="text/html;charset=windows-1250">
  
  <script language='JavaScript'>
    ActiveMenu = '';
    ActiveMenuID = '';  
  
    function SetActiveMenu( Menu )
	{
	  if (ActiveMenuID == '')
	    ActiveMenu = Menu;
		
	  if (ActiveMenuID != Menu.id)
	  {
	    ActiveMenu.className = 'offsubmenu';
		Menu.className = 'onsubmenu';
		ActiveMenuID = Menu.id;
		ActiveMenu = Menu;
	  }	  		
	}
	
	function MouseOver()
	{
	  src = event.toElement;
	  
	  switch (src.className)
	  {
	    case 'menuitem' :
		  src.style.background = 'c00000';
		  break;		  
	  }
	}
	
	function MouseOut()
	{
	  src = event.fromElement;
	  
	  switch (src.className)
	  {
	    case 'menuitem' :
		  src.style.background = 'eb4040';
		  break;
	  }	  
	}
	
	function RunClick()
	{
	  src=event.srcElement;
	  if (src.className=='menuitem')
	    switch (src.id)
		{
		  case 'menu0' :
		    window.location='aaa.html';
		    break;
			
		  case 'menu1' :
		    window.location='aaa.html';
		    break;
			
		  case 'menu2' :
		    window.location='aaa.html';
		    break;
			
		  case 'menu3' :
		    window.location='aaa.html';
		    break;
			
		  default :
		    window.location='index.php';
		    break;
		}
	}
	
    function LoadScripts()
	{
	  window.document.body.onmouseover=MouseOver;
	  window.document.body.onmouseout=MouseOut;
	  window.document.body.onclick=RunClick;
	}	    
  </script>
</head>