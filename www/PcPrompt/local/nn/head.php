<head>
  <meta http-equiv="content-type" content="text/html;charset=windows-1250">
  <meta http-equiv=Pragma content=no-cache>
  <title>Pc Prompt, s.r.o.</title>
  
  <script language='JavaScript'>
    ActiveMenu = '';
    ActiveMenuID = '';  
  
    function SetActiveMenu( Menu )
	{
	  if (ActiveMenuID == '')
	    ActiveMenu = Menu;
	
	  if (Menu == nosubmenu)
	    window.focus();
		
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
	  
	  if ((src.className == 'menuitem') ||
	  	  (src.className == 'tableitem'))
	    src.style.background = 'c00000';
	}
	
	function MouseOut()
	{
	  src = event.fromElement;
	  
	  if ((src.className == 'menuitem') ||
	  	  (src.className == 'tableitem'))
	    src.style.background = 'eb4040';  
	}
	
	function RunClick()
	{	  
	  if (src.className=='menuitem')
	    switch (src.id)
		{
		  case 'menu1' :
		    window.location='index.php?section=1&subsection=0';			
		    break;
			
		  case 'menu2' :
		    window.location='index.php?section=2&subsection=0';
		    break;
			
		  case 'submenu30' :
		    window.location='index.php?section=3&subsection=0';
		    break;
			
		  case 'submenu31' :
		    location.href='index.php?section=3&subsection=1';
		    break;		  
		}
		
	  if (src.className=='tableitem')
	    location.href='table.php?tabname='+src.id;
	}
	
    function LoadScripts()
	{
	  window.document.body.onmouseover=MouseOver;
	  window.document.body.onmouseout=MouseOut;
	  window.document.body.onclick=RunClick;
	}	
  </script>
</head>