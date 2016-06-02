<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>Kompas - komunitná pomoc a starostlivost</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="css/default.css">
    <link rel="stylesheet" type="text/css" href="css/menu.css">
    <link rel="icon" HREF="img/favico.png" type="image/png">
  </head>
  <body>
  	<!-- HEADER -->
  	<div class="Top">
  		<img src="img/logo-only-g.gif" alt="K" class="LogoOnly" />
  		<img src="img/logo-only.gif" alt="O" class="LogoOnly" />
  		<img src="img/logo-only-g.gif" alt="M" class="LogoOnly" />
  		<img src="img/logo-only-g.gif" alt="P" class="LogoOnly" />
  		<img src="img/logo-only-g.gif" alt="A" class="LogoOnly" />
  		<img src="img/logo-only-g.gif" alt="S" class="LogoOnly" />
  		<img src="img/logo.jpg" alt="Kompas n.o." class="Logo" />
  	</div>
  	<div class="BrownStripe"></div>
  	
  	<!-- MENU -->
  	<div class="GreenStripe">
  	<div id="MainMenu">
	  	<ul>
	  		<li><a href="#">About us<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=vznik">Introduction</a></li>
	  				<li><a href="?p=organy">Our NGO’s structure</a></li>
	  				<li><a href="docs/statut.pdf" target="_blank">Statute</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="#">Our objectives<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=oblasti">Key areas of our interest</a></li>
	  				<li><a href="?p=formy">How to achieve our objectives</a></li>
	  				<li><a href="?p=vychadzame">Our core values and principles</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="#">Projects<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=tetralog">“Four corners” Project</a></li>
	  				<li><a href="?p=pripravujeme">Our plans for the future</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="#">Care<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=siet">An integrated network of care for persons with mental illness</a></li>
	  				<li><a href="?p=pojmy">Key terms</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="#">Links<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=partneri">Our partners</a></li>
	  				<li><a href="?p=linky">Links</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="#">Support us<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=dar">Help us with your donation</a></li>
	  				<li><a href="?p=spolupraca">By working with us</a></li>
	  				<li><a href="?p=dobrovolnici">With your volunteering</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="?p=kontakt">Contact</a></li>
	  	</ul>
	  	<a href="/sk/"><img src="img/sk.jpg" style="border: solid 1px black; margin-top: 5px; margin-left: 13px" /></a>
	  </div>
	  </div>
  	
  	<!-- CONTENT -->
  	<div class="Container">
  		<?php  		
				if (isset($_GET['p']) && $_GET['p'] != "")
					$p = $_GET['p'];
				else
					$p = "";
				
				if (!file_exists('pages/'.$p.'.php'))
					$p = "vznik";
					
				@include('pages/'.$p.'.php');
			?>
  	</div>
  	
  	<!-- FOOTER -->
  	
  	<script type="text/javascript">
			var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
			document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
		</script>
		<script type="text/javascript">
			try {
				var pageTracker = _gat._getTracker("UA-6248997-3");
				pageTracker._trackPageview();
			} catch(err) {}
		</script>
	</body>
</html>