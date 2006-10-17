<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
{cache-block keys=$uri_string}
{include uri='design:page_head.tpl'}
{/cache-block}
<style type="text/css">
    @import url({"stylesheets/core.css"|ezdesign(no)});
    @import url({"stylesheets/pagelayout.css"|ezdesign(no)});
    @import url({"stylesheets/content.css"|ezdesign(no)});
	@import url({ezini('StylesheetSettings','ClassesCSS','design.ini')|ezroot(no)});
	@import url({ezini('StylesheetSettings','SiteCSS','design.ini')|ezroot(no)});
    {foreach ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ) as $css_file}
    @import url({concat( 'stylesheets/', $css_file )|ezdesign});
    {/foreach}
</style>
<!-- Print stylesheet must be in this format as IE does not recognize alternative media stylesheets with the @import statement -->
<link rel="stylesheet" type="text/css" href={"stylesheets/print.css"|ezdesign} media="print" />
<!-- IE conditional comments; for bug fixes for different IE versions -->
<!--[if IE 5]>     <style type="text/css"> @import url({"stylesheets/browsers/ie5.css"|ezdesign(no)});    </style> <![endif]-->
<!--[if lte IE 7]> <style type="text/css"> @import url({"stylesheets/browsers/ie7lte.css"|ezdesign(no)}); </style> <![endif]-->
<!--[if !IE]> -->
<!-- Can be used to set styles and content IE should not get -->
<!-- <![endif]-->
<!-- Height resize script; used for resizing columns to equal heights -->
<!-- <script type="text/javascript" src={"javascript/heightresize.js"|ezdesign}></script> -->
</head>
<body>
<!-- Complete page area: START -->

{if is_unset( $current_user )}
    {def $current_user=fetch( 'user', 'current_user' )}
{/if}

{cache-block keys=array($uri_string, $current_user.role_id_list|implode( ',' ), $current_user.limited_assignment_value_list|implode( ',' ))}
{def $pagestyle='nosidemenu noextrainfo'
	 $infobox_count=fetch( 'content', 'list_count', hash( 'parent_node_id', $module_result.node_id,
	 													  'class_filter_type', 'include',
														  'class_filter_array', array( 'infobox' ) ) )
	 $pagedesign=fetch_alias( 'by_identifier', hash( 'attr_id', 'sitestyle_identifier' ) )
	 $locales=fetch( 'content', 'translation_list' )}

{if and( is_set( $module_result.path[1] ), is_set( $module_result.node_id ) )}
	{if ne( $infobox_count , 0 ) }
		{set $pagestyle='sidemenu extrainfo'}
	{else}
		{set $pagestyle='sidemenu noextrainfo'}
	{/if}
{/if}

{if eq( $module_result.content_info.class_identifier, 'frontpage' )}
	{set $pagestyle='nosidemenu noextrainfo'}
{/if}

<div id="page" class="{$pagestyle}">
{/cache-block}
  <!-- Change between "sidemenu"/"nosidemenu" and "extrainfo"/"noextrainfo" to switch display of side columns on or off  -->
  {cache-block keys=array($uri_string, $current_user.role_id_list|implode( ',' ), $current_user.limited_assignment_value_list|implode( ',' ))}
  <!-- Header area: START -->
  <div id="header" class="float-break">
  <div id="usermenu">
	<div id="languages">
		<ul> 
		{if $locales|count|gt( 1 )}
		{foreach $pagedesign.data_map.language_settings.content.rows.sequential as $row}
   			<li><a href={concat( "/",
                     $row.columns[0], "/",
                     $DesignKeys:used.url_alias
                     )|ezroot}>{$row.columns[1]}</a>
			</li>
		{/foreach}
		{/if}
		</ul>
    </div>
    <div id="links">
		<ul>
			{if $pagedesign.data_map.site_map_url.has_content}
    		<li><a href={$pagedesign.data_map.site_map_url.content|ezurl} title="{$pagedesign.data_map.site_map_url.data_text|wash}">{$pagedesign.data_map.site_map_url.data_text|wash}</a></li>
			{/if}
			{def $basket=fetch( shop, basket )
         		 $basket_items=$basket.items}
    		{if $basket_items|count}
    	    <li><a href={"/shop/basket/"|ezurl} title="{$pagedesign.data_map.shopping_basket_label.data_text|wash}">{$pagedesign.data_map.shopping_basket_label.data_text|wash}</a></li>
			{/if}
    	{if $current_user.is_logged_in}
			{if $pagedesign.data_map.my_profile_label.has_content}
    	    <li><a href={concat( "/user/edit/", $current_user.contentobject_id )|ezurl} title="{$pagedesign.data_map.my_profile_label.data_text|wash}">{$pagedesign.data_map.my_profile_label.data_text|wash}</a></li>
			{/if}
			{if $pagedesign.data_map.logout_label.has_content}
    		<li><a href={"/user/logout"|ezurl} title="{$pagedesign.data_map.logout_label.data_text|wash}">{$pagedesign.data_map.logout_label.data_text|wash}</a></li>
			{/if}
    	{else}
			{if $pagedesign.data_map.register_user_label.has_content}
    	    <li><a href={"/user/register"|ezurl} title="{$pagedesign.data_map.register_user_label.data_text|wash}">{$pagedesign.data_map.register_user_label.data_text|wash}</a></li>
			{/if}
			{if $pagedesign.data_map.login_label.has_content}
    		<li><a href={"/user/login"|ezurl} title="{$pagedesign.data_map.login_label.data_text|wash}">{$pagedesign.data_map.login_label.data_text|wash}</a></li>
			{/if}
    	{/if}

    	{if eq( $current_user.contentobject_id, 14 )}
			{if $pagedesign.data_map.site_settings_label.has_content}
    		<li><a href={concat( "/content/edit/", $pagedesign.id, "/f/", $pagedesign.current_language )|ezurl} title="{$pagedesign.data_map.site_settings_label.data_text|wash}">{$pagedesign.data_map.site_settings_label.data_text|wash}</a></li>
			{else}
			<li><a href={concat( "/content/edit/", $pagedesign.id, "/f/", $pagedesign.current_language )|ezurl} title="Site settings">Site settings</a></li>
			{/if}
    	{/if}
		</ul>
    </div>
	</div>
    <div id="logo">
    {if $pagedesign.data_map.image.content.is_valid|not()}
		<h1><a href={"/"|ezurl}>{ezini('SiteSettings','SiteName')}</a></h1>
    {else}
        <a href={"/"|ezurl}><img src={$pagedesign.data_map.image.content[logo].full_path|ezroot} alt="{$pagedesign.data_map.image.content[logo].text}" /></a>
    {/if}
    </div>
    <div id="searchbox">
      <form action={"/content/search"|ezurl}>
        <label for="searchtext" class="hide">Search text:</label>
        <input id="searchtext" name="SearchText" type="text" size="12" />
        <input id="searchbutton" class="button" type="submit" value="Search" />
      </form>
    </div>
    <p class="hide"><a href="#main">Skip to main content</a></p>
  </div>
  <!-- Header area: END -->
  {/cache-block}
  <hr class="hide" />
  {cache-block keys=array($uri_string, $current_user.role_id_list|implode( ',' ), $current_user.limited_assignment_value_list|implode( ',' ))}
  <!-- Top menu area: START -->
  <div id="topmenu" class="float-break">
    {include uri='design:menu/flat_top.tpl'}
  </div>
  <!-- Top menu area: END -->
  {/cache-block}
  {cache-block keys=$uri_string}
  {if or( ne( $module_result.content_info.class_identifier, 'frontpage' ), 
  				eq( $module_result.content_info.viewmode, 'sitemap' ) )}
  <hr class="hide" />
  <!-- Path area: START -->
  <div id="path">
    {include uri='design:parts/path.tpl'}
  </div>
  <!-- Path area: END -->
  {/if}
  {/cache-block}
  <hr class="hide" />
  <!-- Columns area: START -->
  <div id="columns" class="float-break">
  {cache-block keys=array($uri_string, $current_user.role_id_list|implode( ',' ), $current_user.limited_assignment_value_list|implode( ',' ), $isset_toolbar)}
    <!-- Side menu area: START -->
    <div id="sidemenu-position">
	  <div id="sidemenu" {if eq( $isset_toolbar, '1' )}style="margin-top: 40px"{/if}>
	    <div id="heightresize-sidemenu">
          <!-- Used only for height resize script -->
          {if gt($module_result.path|count, 1)}
          {include uri='design:menu/flat_left.tpl'}
          {/if}
        </div>
	  </div>
    </div>
    <!-- Side menu area: END -->
	{/cache-block}
    <hr class="hide" />
    <!-- Main area: START -->
    <div id="main-position">
      <div id="main" class="float-break">
        <div class="overflow-fix">
          <!-- Fix for IE 5&6 -->
          <div id="heightresize-main">
            <!-- Used only for height resize script -->
            <!-- Main area content: START -->
          {$module_result.content}
            <!-- Main area content: END -->
          </div>
          <!-- Used only for height resize script -->
        </div>
      </div>
    </div>
    <!-- Main area: END -->
    <hr class="hide" />
	{cache-block keys=array($uri_string, $current_user.role_id_list|implode( ',' ), $current_user.limited_assignment_value_list|implode( ',' ), $isset_toolbar)}
    <!-- Extra area: START -->
    <div id="extrainfo-position">
      <div id="extrainfo" {if eq( $isset_toolbar, '1' )}style="margin-top: 40px"{/if}>
        <div id="heightresize-extrainfo">
          <!-- Used only for height resize script -->
          <!-- Extra content: START -->
			{include uri='design:parts/extra_info.tpl'}
          <!-- Extra content: END -->
        </div>
        <!-- Used only for height resize script -->
      </div>
    </div>
    <!-- Extra area: END -->
	{/cache-block}
  </div>
  <!-- Columns area: END -->
  <hr class="hide" />
  {cache-block keys=$uri_string}
  <!-- Footer area: START -->
  <div id="footer">
    <address>
    Copyright &#169; 2006 eZ systems AS. All rights reserved. <br />
	{if $pagedesign.data_map.hide_powered_by.data_int|not}
	Powered by <a href={"/ezinfo/about"|ezurl}>eZ publish&#8482;</a> Content Management System.
	{/if}
    </address>
  </div>
  <!-- Footer area: END -->
  {/cache-block}
</div>
<!-- Complete page area: END -->

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>