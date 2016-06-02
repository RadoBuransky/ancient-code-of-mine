<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="sk" lang="sk">
  <head>
    <title>Kompas - komunitná pomoc a starostlivosť</title>
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
	  		<li><a href="#">Kto sme?<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=vznik">Vznik</a></li>
	  				<li><a href="?p=organy">Orgány</a></li>
	  				<li><a href="docs/statut.pdf" target="_blank">Štatút</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="#">Naše ciele<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=oblasti">Prioritné oblasti našej činnosti</a></li>
	  				<li><a href="?p=formy">Formy realizácie našich cieľov</a></li>
	  				<li><a href="?p=vychadzame">Z čoho vychádzame?</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="?p=novinky">Novinky</a></li>
	  		<li><a href="#">Projekty<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=tetralog">Program "TETRALÓG"</a></li>
	  				<li><a href="?p=dusazdrava">Kampaň za duševné zdravie</a></li>
	  				<li><a href="?p=pripravujeme">Pripravujeme</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="#">Starostlivosť<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=siet">Komplexná sieť starostlivosti o ľudí s duševnými ochoreniami</a></li>
	  				<li><a href="?p=pojmy">Základné pojmy</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="#">Odkazy<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=partneri">Partneri</a></li>
	  				<li><a href="?p=linky">Linky</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="#">Podporte nás<!--[if IE 7]><!--></a><!--<![endif]--><!--[if lte IE 6]><table><tr><td><![endif]-->
	  			<ul>
	  				<li><a href="?p=dar">Finančným darom</a></li>
	  				<li><a href="?p=spolupraca">Spoluprácou s nami</a></li>
	  				<li><a href="?p=dobrovolnici">Dobrovoľníckou činnosťou</a></li>
	  			</ul>
	  			<!--[if lte IE 6]></td></tr></table></a><![endif]-->
	  		</li>
	  		<li><a href="?p=kontakt">Kontakt</a></li>
	  	</ul>
	  	<a href="/en/"><img src="img/en.jpg" style="border: solid 1px black; margin-top: 5px; margin-left: 13px" /></a>
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