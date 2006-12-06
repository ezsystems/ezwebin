<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$site.http_equiv.Content-language|wash}" lang="{$site.http_equiv.Content-language|wash}">
<head>
{def $basket_is_empty   = cond($current_user.is_logged_in, fetch( shop, basket ).is_empty, 1)
     $current_node_id   = first_set($module_result.node_id, 0)
     $user_hash         = concat($current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ))}

{cache-block keys=array($uri_string, $basket_is_empty, $user_hash)}
{def $pagestyle       = 'nosidemenu noextrainfo'
     $infobox_count   = 0
     $locales         = fetch( 'content', 'translation_list' )
     $pagerootdepth   = ezini( 'SiteSettings', 'RootNodeDepth', 'site.ini' )
     $indexpage       = 2
     $path_normalized = ''
     $pagedesign      = fetch( 'content', 'object', hash( 'object_id', '54' ) )
}
{include uri='design:page_head.tpl'}
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
<link rel="stylesheet" type="text/css" href={"stylesheets/print.css"|ezdesign} media="print" />
<!-- IE conditional comments; for bug fixes for different IE versions -->
<!--[if IE 5]>     <style type="text/css"> @import url({"stylesheets/browsers/ie5.css"|ezdesign(no)});    </style> <![endif]-->
<!--[if lte IE 7]> <style type="text/css"> @import url({"stylesheets/browsers/ie7lte.css"|ezdesign(no)}); </style> <![endif]-->
{foreach ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ) as $script}
    <script language="javascript" type="text/javascript" src={concat( 'javascript/', $script )|ezdesign}></script>
{/foreach}
</head>
<body>
<!-- Complete page area: START -->

{if $pagerootdepth|not}
    {set $pagerootdepth = 1}
{/if}
{if $current_node_id}
	{set $infobox_count = fetch( 'content', 'list_count', hash(
	                                        'parent_node_id', $current_node_id,
                                            'class_filter_type', 'include',
                                            'class_filter_array', array( 'infobox' ) ) )}
	{if $module_result.path|count|gt($pagerootdepth|dec)}
	    {if is_set( $module_result.path[$pagerootdepth|dec].node_id )}	
		{set $indexpage = $module_result.path[$pagerootdepth|dec].node_id}
	    {/if}
	{/if}

	{if is_set( $module_result.path[1] )}
	    {if ne( $infobox_count , 0 ) }
	        {set $pagestyle = 'sidemenu extrainfo'}
	    {else}
	        {set $pagestyle = 'sidemenu noextrainfo'}
	    {/if}
	{/if}
	{if and( is_set( $module_result.content_info.class_identifier ), eq( $module_result.content_info.class_identifier, 'frontpage' ) )}
	    {set $pagestyle = 'nosidemenu noextrainfo'}
	{/if}
{/if}

{if is_set($module_result.section_id)}
{set $pagestyle = concat($pagestyle, " section_id_", $module_result.section_id)}
{/if}

{foreach $module_result.path as $key => $path}
{if is_set($path.node_id)}
    {set $path_normalized = $path_normalized|append( concat('subtree_level_', $key, '_node_id_', $path.node_id, ' ' ))}
{/if}
{/foreach}
<!-- Change between "sidemenu"/"nosidemenu" and "extrainfo"/"noextrainfo" to switch display of side columns on or off  -->
<div id="page" class="{$pagestyle} {$path_normalized|trim()} current_node_id_{$current_node_id}">

  <!-- Header area: START -->
  <div id="header" class="float-break">
  <div id="usermenu">
    <div id="languages">
        {if $locales|count|gt( 1 )}
        <ul>
        {foreach $pagedesign.data_map.language_settings.content.rows.sequential as $row}
        {def $site_url = $row.columns[0]
             $site_access = $row.columns[1]
             $language = $row.columns[2]}
        {if $row.columns[0]}
            {set $site_url = $site_url|append( "/" )}
        {/if}
        {if $row.columns[1]}
            {set $site_access = $site_access|append( "/" )}
        {/if}
        {if $row.columns[0]}
	        <li{if $row.columns[1]|downcase()|eq($access_type.name)} class="current_siteaccess"{/if}>
	        {if is_set($DesignKeys:used.url_alias)}
	            <a href={concat( "http://", $site_url,
	                     $site_access,
	                     $DesignKeys:used.url_alias
	                     )}>{$language}</a>
	        {else}
	            <a href={concat( "http://", $site_url,
	                     $site_access,
	                     $uri_string
                         )}>{$language}</a>
            {/if}
            </li>
        {/if}
        {undef $site_url $site_access $language}
        {/foreach}
        </ul>
        {/if}
    </div>
    <div id="links">
        <ul>
            {if $pagedesign.data_map.site_map_url.data_text|ne('')}
                {if $pagedesign.data_map.site_map_url.content|eq('')}
                <li><a href={concat("/content/view/sitemap/", $indexpage)|ezurl} title="{$pagedesign.data_map.site_map_url.data_text|wash}">{$pagedesign.data_map.site_map_url.data_text|wash}</a></li>
                {else}
                <li><a href={$pagedesign.data_map.site_map_url.content|ezurl} title="{$pagedesign.data_map.site_map_url.data_text|wash}">{$pagedesign.data_map.site_map_url.data_text|wash}</a></li>
                {/if}
            {/if}
            {if $basket_is_empty|not()}
            <li><a href={"/shop/basket/"|ezurl} title="{$pagedesign.data_map.shopping_basket_label.data_text|wash}">{$pagedesign.data_map.shopping_basket_label.data_text|wash}</a></li>
           {/if}
        {if $current_user.is_logged_in}
            {if $pagedesign.data_map.my_profile_label.has_content}
            <li><a href={concat( "/user/edit/", $current_user.contentobject_id )|ezurl} title="{$pagedesign.data_map.my_profile_label.data_text|wash}">{$pagedesign.data_map.my_profile_label.data_text|wash}</a></li>
            {/if}
            {if $pagedesign.data_map.logout_label.has_content}
            <li><a href={"/user/logout"|ezurl} title="{$pagedesign.data_map.logout_label.data_text|wash}">{$pagedesign.data_map.logout_label.data_text|wash} ( {$current_user.contentobject.name|wash} )</a></li>
            {/if}
        {else}
            {if $pagedesign.data_map.register_user_label.has_content}
            <li><a href={"/user/register"|ezurl} title="{$pagedesign.data_map.register_user_label.data_text|wash}">{$pagedesign.data_map.register_user_label.data_text|wash}</a></li>
            {/if}
            {if $pagedesign.data_map.login_label.has_content}
            <li><a href={"/user/login"|ezurl} title="{$pagedesign.data_map.login_label.data_text|wash}">{$pagedesign.data_map.login_label.data_text|wash}</a></li>
            {/if}
        {/if}

        {if $pagedesign.can_edit}
            <li><a href={concat( "/content/edit/", $pagedesign.id, "/f/", ezini( 'RegionalSettings', 'Locale' , 'site.ini'), "/", $pagedesign.initial_language_code )|ezurl} title="{$pagedesign.data_map.site_settings_label.data_text|wash}">{$pagedesign.data_map.site_settings_label.data_text|wash}</a></li>
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
        <input id="searchbutton" class="button" type="submit" value="{'Search'|i18n('design/ezwebin/pagelayout')}" />
      </form>
    </div>
    <p class="hide"><a href="#main">Skip to main content</a></p>
  </div>
  <!-- Header area: END -->

  
  <!-- Top menu area: START -->
  <div id="topmenu" class="float-break">
    {include uri='design:menu/flat_top.tpl'}
  </div>
  <!-- Top menu area: END -->
  {if not( and( is_set( $module_result.content_info.class_identifier ),
                eq( $module_result.content_info.class_identifier, 'frontpage' ),
	        and( is_set( $module_result.content_info.viewmode ), ne( $module_result.content_info.viewmode, 'sitemap' ) )
	      )
         )}

  <!-- Path area: START -->
  <div id="path">
    {include uri='design:parts/path.tpl'}
  </div>
  <!-- Path area: END -->
  {/if}

  
  <!-- Toolbar area: START -->
  <div id="toolbar">
  {if and( $current_node_id, and( is_set( $module_result.content_info.viewmode ), ne( $module_result.content_info.viewmode, 'sitemap' ) ) ) }
  {include uri='design:parts/website_toolbar.tpl'}
  {/if}
  </div>
  <!-- Toolbar area: END -->

  
  <!-- Columns area: START -->
  <div id="columns" class="float-break">
    <!-- Side menu area: START -->
    <div id="sidemenu-position">
      <div id="sidemenu">
          <!-- Used only for height resize script -->
          {if and($current_node_id, gt($module_result.path|count, $pagerootdepth))}
          {include uri='design:menu/flat_left.tpl'}
          {/if}
       </div>
    </div>
    <!-- Side menu area: END -->
    
    <!-- Extra area: START -->
    <div id="extrainfo-position">
      <div id="extrainfo">
          <!-- Extra content: START -->
          {if $infobox_count}
            {include uri='design:parts/extra_info.tpl'}
          {/if}
          <!-- Extra content: END -->
      </div>
    </div>
    <!-- Extra area: END -->
{/cache-block}
    <!-- Main area: START -->
    <div id="main-position">
      <div id="main" class="float-break">
        <div class="overflow-fix">
          <!-- Main area content: START -->
          {$module_result.content}
          <!-- Main area content: END -->
        </div>
      </div>
    </div>
    <!-- Main area: END -->
  </div>
  <!-- Columns area: END -->
  
{cache-block keys=$access_type.name}
  {if is_unset($pagedesign)}
   {def $pagedesign = fetch( 'content', 'object', hash( 'object_id', '54' ) )}
  {/if}
  
{include uri='design:page_footer.tpl'} 

</div>
<!-- Complete page area: END -->

{if $pagedesign.data_map.footer_script.has_content}
<script language="javascript" type="text/javascript">
<!--

{$pagedesign.data_map.footer_script.content}

-->
</script>
{/if}
{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>