<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$site.http_equiv.Content-language|wash}" lang="{$site.http_equiv.Content-language|wash}">
<head>
{def $basket_is_empty   = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
     $user_hash         = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id )}
{def $pagedata         = ezpagedata()
     $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $pagedesign       = $pagedata.template_look
     $current_node_id  = $pagedata.node_id
}

{include uri='design:page_head.tpl'}             

<style type="text/css">
    @import url({"stylesheets/core.css"|ezdesign(no)});
    @import url({"stylesheets/debug.css"|ezdesign(no)});
    @import url({"stylesheets/pagelayout.css"|ezdesign(no)});
    @import url({"stylesheets/content.css"|ezdesign(no)});
    @import url({"stylesheets/websitetoolbar.css"|ezdesign(no)});
    {foreach ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ) as $css_file}
    @import url({concat( 'stylesheets/', $css_file )|ezdesign});
    {/foreach}
    @import url({ezini('StylesheetSettings','ClassesCSS','design.ini')|ezroot(no)});
    @import url({ezini('StylesheetSettings','SiteCSS','design.ini')|ezroot(no)});
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

<!-- Change between "sidemenu"/"nosidemenu" and "extrainfo"/"noextrainfo" to switch display of side columns on or off  -->
<div id="page" class="{$pagestyle}">

  <!-- Header area: START -->
  <div id="header" class="float-break">
  <div id="usermenu">
    <div id="languages">
        {if $locales|count|gt( 1 )}
        <ul>
        {foreach $pagedesign.data_map.language_settings.content.rows.sequential as $row}
        {def $site_url = $row.columns[0]
             $language = $row.columns[2]}
        {if $row.columns[0]}
            {set $site_url = $site_url|append( "/" )}
            <li{if $row.columns[1]|downcase()|eq($access_type.name)} class="current_siteaccess"{/if}>
            {if is_set($DesignKeys:used.url_alias)}
                <a href="{concat( "http://", $site_url,
                         $DesignKeys:used.url_alias
                         )}">{$language}</a>
            {else}
                <a href="{concat( "http://", $site_url,
                         $uri_string
                         )}">{$language}</a>
            {/if}
            </li>
        {/if}
        {undef $site_url $language}
        {/foreach}
        </ul>
        {/if}
    </div>
    <div id="links">
        <ul>
            {if $pagedesign.data_map.tag_cloud_url.data_text|ne('')}
                {if $pagedesign.data_map.tag_cloud_url.content|eq('')}
                <li id="tagcloud"><a href={concat("/content/view/tagcloud/", $pagedata.root_node)|ezurl} title="{$pagedesign.data_map.tag_cloud_url.data_text|wash}">{$pagedesign.data_map.tag_cloud_url.data_text|wash}</a></li>
                {else}
                <li id="tagcloud"><a href={$pagedesign.data_map.tag_cloud_url.content|ezurl} title="{$pagedesign.data_map.tag_cloud_url.data_text|wash}">{$pagedesign.data_map.tag_cloud_url.data_text|wash}</a></li>
                {/if}
            {/if}
            {if $pagedesign.data_map.site_map_url.data_text|ne('')}
                {if $pagedesign.data_map.site_map_url.content|eq('')}
                <li id="sitemap"><a href={concat("/content/view/sitemap/", $pagedata.root_node)|ezurl} title="{$pagedesign.data_map.site_map_url.data_text|wash}">{$pagedesign.data_map.site_map_url.data_text|wash}</a></li>
                {else}
                <li id="sitemap"><a href={$pagedesign.data_map.site_map_url.content|ezurl} title="{$pagedesign.data_map.site_map_url.data_text|wash}">{$pagedesign.data_map.site_map_url.data_text|wash}</a></li>
                {/if}
            {/if}
            {if $basket_is_empty|not()}
            <li id="shoppingbasket"><a href={"/shop/basket/"|ezurl} title="{$pagedesign.data_map.shopping_basket_label.data_text|wash}">{$pagedesign.data_map.shopping_basket_label.data_text|wash}</a></li>
           {/if}
        {if $current_user.is_logged_in}
            {if $pagedesign.data_map.my_profile_label.has_content}
            <li id="myprofile"><a href={concat( "/user/edit/", $current_user.contentobject_id )|ezurl} title="{$pagedesign.data_map.my_profile_label.data_text|wash}">{$pagedesign.data_map.my_profile_label.data_text|wash}</a></li>
            {/if}
            {if $pagedesign.data_map.logout_label.has_content}
            <li id="logout"><a href={"/user/logout"|ezurl} title="{$pagedesign.data_map.logout_label.data_text|wash}">{$pagedesign.data_map.logout_label.data_text|wash} ( {$current_user.contentobject.name|wash} )</a></li>
            {/if}
        {else}
            {if $pagedesign.data_map.register_user_label.has_content}
            <li id="registeruser"><a href={"/user/register"|ezurl} title="{$pagedesign.data_map.register_user_label.data_text|wash}">{$pagedesign.data_map.register_user_label.data_text|wash}</a></li>
            {/if}
            {if $pagedesign.data_map.login_label.has_content}
            <li id="login"><a href={"/user/login"|ezurl} title="{$pagedesign.data_map.login_label.data_text|wash}">{$pagedesign.data_map.login_label.data_text|wash}</a></li>
            {/if}
        {/if}

        {if $pagedesign.can_edit}
            <li id="sitesettings"><a href={concat( "/content/edit/", $pagedesign.id, "/a" )|ezurl} title="{$pagedesign.data_map.site_settings_label.data_text|wash}">{$pagedesign.data_map.site_settings_label.data_text|wash}</a></li>
        {/if}
        </ul>
    </div>
    </div>
  {cache-block keys=array( $module_result.uri, $user_hash )}
    <div id="logo">
    {if $pagedesign.data_map.image.content.is_valid|not()}
        <h1><a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}">{ezini('SiteSettings','SiteName')}</a></h1>
    {else}
        <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}"><img src={$pagedesign.data_map.image.content[original].full_path|ezroot} alt="{$pagedesign.data_map.image.content[original].text}" width="{$pagedesign.data_map.image.content[original].width}" height="{$pagedesign.data_map.image.content[original].height}" /></a>
    {/if}
    </div>
    <div id="searchbox">
      <form action={"/content/search"|ezurl}>
        <label for="searchtext" class="hide">Search text:</label>
        {if $pagedata.is_edit}
        <input id="searchtext" name="SearchText" type="text" value="" size="12" disabled="disabled" />
        <input id="searchbutton" class="button-disabled" type="submit" value="{'Search'|i18n('design/ezwebin/pagelayout')}" alt="Submit" disabled="disabled" />
        {else}
        <input id="searchtext" name="SearchText" type="text" value="" size="12" />
        <input id="searchbutton" class="button" type="submit" value="{'Search'|i18n('design/ezwebin/pagelayout')}" alt="Submit" />
            {if eq( $ui_context, 'browse' )}
             <input name="Mode" type="hidden" value="browse" />
            {/if}
        {/if}
      </form>
    </div>
    <p class="hide"><a href="#main">Skip to main content</a></p>
  </div>
  <!-- Header area: END -->


  <!-- Top menu area: START -->
  <div id="topmenu" class="float-break">
  {if $pagedata.top_menu}
    {include uri=concat('design:menu/', $pagedata.top_menu, '.tpl')}
  {/if}
  </div>
  <!-- Top menu area: END -->

  {if $pagedata.show_path}
  <!-- Path area: START -->
  <div id="path">
    {include uri='design:parts/path.tpl'}
  </div>
  <!-- Path area: END -->
  {/if}

  <!-- Toolbar area: START -->
  <div id="toolbar">
  {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
  {include uri='design:parts/website_toolbar.tpl'}
  {/if}
  </div>
  <!-- Toolbar area: END -->

  <!-- Columns area: START -->
  <div id="columns" class="float-break">
  {if $pagedata.left_menu}
    <!-- Side menu area: START -->
    <div id="sidemenu-position">
      <div id="sidemenu">
        {if is_array( $pagedata.left_menu )}
            {foreach $pagedata.left_menu as $left_menu}
                {include uri=concat('design:menu/', $left_menu, '.tpl')}
                {delimiter}<div class="hr"></div>{/delimiter}
            {/foreach}
        {else}
            {include uri=concat('design:menu/', $pagedata.left_menu, '.tpl')}
        {/if}
       </div>
    </div>
    <!-- Side menu area: END -->
  {/if}
  {/cache-block}
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
{cache-block keys=array($module_result.uri, $user_hash, $access_type.name)}

  {if is_unset($pagedesign)}
    {def $pagedata   = ezpagedata()
         $pagedesign = $pagedata.template_look}
  {/if}
  {if $pagedata.extra_menu}
    <!-- Extra area: START -->
    <div id="extrainfo-position">
      <div id="extrainfo">
        {if is_array( $pagedata.extra_menu )}
            {foreach $pagedata.extra_menu as $extra_menu}
                {include uri=concat('design:parts/', $extra_menu, '.tpl')}
                {delimiter}<div class="hr"></div>{/delimiter}
            {/foreach}
        {else}
            {include uri=concat('design:parts/', $pagedata.extra_menu, '.tpl')}
        {/if}
      </div>
    </div>
    <!-- Extra area: END -->
    {/if}

  </div>
  <!-- Columns area: END -->

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

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
{/cache-block}
</body>
</html>