<?php 
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 1.1
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Augus 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

 
	$themeConfig = $this->config->get( 'themecontrol' );
	$themeName =  $this->config->get('config_template');
	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/development/libs/framework.php" );

	
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
	$helper->setDirection( $direction );
	/* Add scripts files */
	$helper->addScript( 'catalog/view/javascript/jquery/jquery-1.7.1.min.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/ui/external/jquery.cookie.js' );
	$helper->addScript( 'catalog/view/javascript/common.js' );
	$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/common.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/bootstrap/bootstrap.min.js' );
	
	$helper->addScriptList( $scripts );
	
	$helper->addCss( 'catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css' );	
	if( isset($themeConfig['customize_theme']) 
		&& file_exists(DIR_TEMPLATE.$themeName.'/stylesheet/customize/'.$themeConfig['customize_theme'].'.css') ) {  
		$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/customize/'.$themeConfig['customize_theme'].'.css'  );
	}

	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/animation.css' );	
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/font-awesome.min.css' );	
	$helper->addCssList( $styles );
	$layoutMode = $helper->getParam( 'layout' );
 	
?>
<!DOCTYPE html>
<html dir="<?php echo $helper->getDirection(); ?>" class="<?php echo $helper->getDirection(); ?>" lang="<?php echo $lang; ?>">
<head>
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
 <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<!-- Mobile viewport optimized: h5bp.com/viewport -->
<meta name="viewport" content="width=device-width">
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($helper->getCssLinks() as $link) { ?>

<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>

	<?php if( $themeConfig['theme_width'] &&  $themeConfig['theme_width'] != 'auto' ) { ?>
			<style> #page-container .container{max-width:<?php echo $themeConfig['theme_width'];?>; width:auto}</style>
	<?php } ?>
	
	<?php if( isset($themeConfig['use_custombg']) && $themeConfig['use_custombg'] ) {	?>
	<style> 
		body{
			background:url( "image/<?php echo $themeConfig['bg_image'];?>") <?php echo $themeConfig['bg_repeat'];?>  <?php echo $themeConfig['bg_position'];?> !important;
		}</style>
	<?php } ?>
<?php 
	if( isset($themeConfig['enable_customfont']) && $themeConfig['enable_customfont'] ){
	$css=array();
	$link = array();
	for( $i=1; $i<=3; $i++ ){
		if( trim($themeConfig['google_url'.$i]) && $themeConfig['type_fonts'.$i] == 'google' ){
			$link[] = '<link rel="stylesheet" type="text/css" href="'.trim($themeConfig['google_url'.$i]) .'"/>';
			$themeConfig['normal_fonts'.$i] = $themeConfig['google_family'.$i];
		}
		if( trim($themeConfig['body_selector'.$i]) && trim($themeConfig['normal_fonts'.$i]) ){
			$css[]= trim($themeConfig['body_selector'.$i])." {font-family:".str_replace("'",'"',htmlspecialchars_decode(trim($themeConfig['normal_fonts'.$i])))."}\r\n"	;
		}
	}
	echo implode( "\r\n",$link );
?>
<style>
	<?php echo implode("\r\n",$css);?>
</style>
<?php } else { ?>
<link href='http://fonts.googleapis.com/css?family=Roboto:400,700,500italic,500,400italic,300italic,300,100italic' rel='stylesheet' type='text/css'>
<?php } ?>
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<?php foreach( $helper->getScriptFiles() as $script )  { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>


<?php if( isset($themeConfig['custom_javascript'])  && !empty($themeConfig['custom_javascript']) ){ ?>
	<script type="text/javascript"><!--
		$(document).ready(function() {
			<?php echo html_entity_decode(trim( $themeConfig['custom_javascript']) ); ?>
		});
//--></script>
<?php }	?>

<!--[if lt IE 9]>
<?php if( isset($themeConfig['load_live_html5'])  && $themeConfig['load_live_html5'] ) { ?>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<?php } else { ?>
<script src="catalog/view/javascript/html5.js"></script>
<?php } ?>
<script src="catalog/view/javascript/respond.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/ie8.css" />
<![endif]-->

<?php if ( isset($stores) && $stores ) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>
<?php echo $google_analytics; ?>
</head>
<body id="offcanvas-container" class="offcanvas-container layout-<?php echo $layoutMode; ?> fs<?php echo $themeConfig['fontsize'];?> <?php echo $helper->getPageClass();?> <?php echo $helper->getParam('body_pattern','');?> lang-<?php echo $lang; ?>">
<section id="page" class="offcanvas-pusher" role="main">
<section id="header">
		<section id="topbar">
			<div class="container"><div class="topbar"><div class="row">
				<div class="pull-left">
					<ul class="links pull-left">
						<!--<li><a class="first" href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>-->
						<li><a class="account" href="<?php echo $account; ?>">
							<span class="fa fa-user"></span>
							<span class="text-link"><?php echo $text_account; ?></span></a>
						</li>
						<li><a class="wishlist" href="<?php echo $wishlist; ?>" id="wishlist-total">
							<span class="fa fa-heart"></span>
							<span class="text-link"><?php echo $text_wishlist; ?></span></a>
						</li>
						<li><a class="shoppingcart" href="<?php echo $shopping_cart; ?>">
							<span class="fa fa-shopping-cart"></span>
							<span class="text-link"><?php echo $text_shopping_cart; ?></span></a>
						</li>
						<li><a class="last checkout" href="<?php echo $checkout; ?>">
							<span class="fa fa-file"></span>
							<span class="text-link"><?php echo $text_checkout; ?></span></a>
						</li> 
					</ul>
					<div class="login pull-left  hidden-xs hidden-sm">
						<?php if (!$logged) { ?>
						<?php echo $text_welcome; ?>
						<?php } else { ?>
						<?php echo $text_logged; ?>
						<?php } ?> 
					</div>
				</div>
				<div class="pull-right center-sm">
						<div class="currency pull-right">
							<?php echo $currency; ?>
						</div> 
						<div class="language pull-right">
							<?php echo $language; ?>
						</div> 
				</div>
			</div></div></div>
		</section>
		<section id="header-main">
			<div class="container">
				<div class="row header-wrap">
					<div class="col-lg-7 col-md-6 col-sm-4 col-xs-4 inner">
					  <?php if ($logo) { ?>
					  <div id="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
					  <?php } ?>
					
					</div>

					<div class="header-right col-lg-5 col-md-6 col-sm-8 col-xs-8 inner">
						<?php
							$LANGUAGE_ID = $this->config->get( 'config_language_id' );  
					 		if( isset($themeConfig['widget_delivery_data'][$LANGUAGE_ID]) ) { ?>
							<?php echo html_entity_decode( $themeConfig['widget_delivery_data'][$LANGUAGE_ID], ENT_QUOTES, 'UTF-8' ); ?>
					 	<?php } ?>

						<?php echo $cart; ?>
					</div>
				</div>
			</div>
	</section>
</section>

<section id="pav-mainnav">
	<div class="container">
		<div class="mainnav-wrap">
			<div class="row">
				<div class="col-lg-10 col-md-10 col-sm-6 col-xs-12">
				 	<div class="navbar navbar-inverse"> 
						<nav id="mainmenutop" role="navigation">
							<div class="pav-megamenu">
						<?php 
						/**
						 * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
						 */
						$modules = $helper->getModulesByPosition( 'mainmenu' ); 
						if( count($modules) && !empty($modules) ){ 

						?>

							<?php foreach ($modules as $module) { ?>
								<?php echo $module; ?>
							<?php } ?>

						<?php } elseif ($categories) {  ?>
					
							 
							<div class="navbar-header">
								<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								</button>
							</div>

						  <div class="collapse navbar-collapse navbar-ex1-collapse">
									  <ul class="nav navbar-nav">
								  	<li><a href="<?php echo $home; ?>" title="<?php echo $this->language->get('text_home');?>"><?php echo $this->language->get('text_home');?></a></li>
									<?php foreach ($categories as $category) { ?>
									
									<?php if ($category['children']) { ?>			
									<li class="parent dropdown deeper "><a href="<?php echo $category['href'];?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?>
									<b class="caret"></b>
									</a>
									<?php } else { ?>
									<li ><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
									<?php } ?>
									<?php if ($category['children']) { ?>
									  <ul class="dropdown-menu">
										<?php for ($i = 0; $i < count($category['children']);) { ?>
										
										  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
										  <?php for (; $i < $j; $i++) { ?>
										  <?php if (isset($category['children'][$i])) { ?>
										  <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
										  <?php } ?>
										  <?php } ?>
										
										<?php } ?>
									</ul>
									  <?php } ?>
									</li>
									<?php } ?>
								  </ul>
							</div>	   
						<?php } ?>
						</div>
						</nav>
				  	</div>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
					<div id="search" class="pull-right">
						<input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
						<span class="button-search"></span>
		  			</div>
		  		</div>
			</div>
		</div>
	</div>		
</section>
<section id="sys-notification">
	<div class="container">
		<?php if ($error) { ?>    
    		<div class="warning"><?php echo $error ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
    	<?php } ?>

		<div id="notification"></div>
	</div>
</section>
<?php
	$LANGUAGE_ID = $this->config->get( 'config_language_id' );  
		if( isset($themeConfig['widget_bannertop_data'][$LANGUAGE_ID]) ) { ?>
	<section id="banner-top">
		<div class="container">
			<?php echo html_entity_decode( $themeConfig['widget_bannertop_data'][$LANGUAGE_ID], ENT_QUOTES, 'UTF-8' ); ?>
		</div>
	</section>
<?php } ?>


<?php
/**
 * Slideshow modules
 */
$modules = $helper->getModulesByPosition( 'slideshow' );
$ospans = array(1=>8, 2=>4); 
if( $modules ){
$cols = isset($config['block_slideshow'])&& $config['block_slideshow']?(int)$config['block_slideshow']:count($modules);	
$class = $helper->calculateSpans( $ospans, $cols );
?>
<section id="pav-slideshow" class="pav-slideshow hidden-xs hidden-sm">
	<div class="container">
		<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
			<?php if(  $i++%$cols == 0 || count($modules)==1  ){  $j=1;?><div class="row"><?php } ?>	
			<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
	<?php  $j++;  } ?>
	</div>
</section>
<?php } ?>

<?php
/**
 * Promotion modules
 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
 */
$modules = $helper->getModulesByPosition( 'showcase' ); 
$ospans = array();

if( count($modules) ){
$cols = isset($config['block_showcase'])&& $config['block_showcase']?(int)$config['block_showcase']:count($modules);	
$class = $helper->calculateSpans( $ospans, $cols );
?>
<section class="pav-showcase" id="pavo-showcase">
	<div class="container">
	<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
			<?php if(  $i++%$cols == 0 || count($modules)==1  ){  $j=1;?><div class="row"><?php } ?>	
			<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
	<?php  $j++;  } ?>	
	</div>
</section>
<?php } ?>
<?php
/**
 * Promotion modules
 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
 */
$modules = $helper->getModulesByPosition( 'promotion' ); 
$ospans = array();

if( count($modules) ){
$cols = isset($config['block_promotion'])&& $config['block_promotion']?(int)$config['block_promotion']:count($modules);	
$class = $helper->calculateSpans( $ospans, $cols );
?>
<section class="pav-promotion" id="pav-promotion">
	<div class="container">
	<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
			<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>	
			<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
	<?php  $j++;  } ?>	
	</div>
</section>
<?php } ?>

	<?php if( isset($themeConfig['enable_offsidebars']) && $themeConfig['enable_offsidebars'] ) { ?>
	<section id="columns" class="offcanvas-siderbars"><div class="container">
	<div class="row visible-xs"><div class="container"> 
		<div class="offcanvas-sidebars-buttons">
			<button type="button" data-for="column-left" class="pull-left btn btn-danger"><i class="glyphicon glyphicon-indent-left"></i> <?php echo $this->language->get('text_sidebar_left'); ?></button>
			
			<button type="button" data-for="column-right" class="pull-right btn btn-danger"><?php echo $this->language->get('text_sidebar_right'); ?> <i class="glyphicon glyphicon-indent-right"></i></button>
		</div>
	</div></div>
	<?php }else { ?>
	<section id="columns"><div class="container">
	<?php } ?>
	<div class="row">