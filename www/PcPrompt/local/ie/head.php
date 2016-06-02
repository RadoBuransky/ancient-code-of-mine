<head>    
  <link rel=stylesheet href="style.css" type="text/css" title="style.css">  
  <meta http-equiv="content-type" content="text/html;charset=windows-1250">
  <meta name="Keywords" content="pcprompt, pc, prompt, pocitac, pocitace, hardware, predaj, 
  servis, oprava, monitory, tlaciarne, elektronika, bratislava, trencin">
  <title>Pc Prompt, s.r.o.</title>
  
  <script language="JavaScript">
    ActiveMenu = '';
    ActiveMenuID = '';
	plugin = 0;  
  
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
	
	function SetActiveRow( Row )
	{
	  Row.style.background = 'ffe5e5';
	}
	
	function SetInactiveRow( Row )
	{
	  Row.style.background = 'ffffff';
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
		    window.location='index.php?section=zmluvy';			
		    break;
			
		  case 'menu2' :
		    window.location='index.php?section=reklamacie';
		    break;
			
		  case 'submenu30' :
		    window.location='index.php?section=kontakt_ba';
		    break;
			
		  case 'submenu31' :
		    location.href='index.php?section=kontakt_tn';
		    break;		  
		}
		
	  if (src.id == 'zostava')
	    location.href = 'zostava.xls';
	  else
	    if ((src.className == 'tableitem') ||
	  	    (src.className == 'searchtable'))
	      location.href = 'table.php?tabname='+src.id;		
	}
	
    function LoadScripts()
	{
	  window.document.body.onmouseover=MouseOver;
	  window.document.body.onmouseout=MouseOut;
	  window.document.body.onclick=RunClick;
	}
	
	function SetText( text )
	{
	  window.status = text;
	}
	
	function DetectFlash()
	{
	  plugin = (navigator.mimeTypes && navigator.mimeTypes["application/x-shockwave-flash"]) ? navigator.mimeTypes["application/x-shockwave-flash"].enabledPlugin : 0;
	  if (plugin)
	    plugin = parseInt(plugin.description.substring(plugin.description.indexOf(".")-1)) >= 4;
	}
		
	DetectFlash();	
  </script>
</head>