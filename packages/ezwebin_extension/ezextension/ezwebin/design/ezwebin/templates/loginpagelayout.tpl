<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
{cache-block keys=$uri_string}
{include uri='design:page_head.tpl'}
<style type="text/css">
    @import url({"stylesheets/core.css"|ezdesign(no)});
    @import url({"stylesheets/pagelayout.css"|ezdesign(no)});
    @import url({"stylesheets/content.css"|ezdesign(no)});
</style>
<!-- Print stylesheet must be in this format as IE does not recognize alternative media stylesheets with the @import statement -->
<link rel="stylesheet" type="text/css" href={"stylesheets/print.css"|ezdesign} media="print" />
<!-- IE conditional comments; for bug fixes for different IE versions -->
<!--[if IE 5]>     <style type="text/css"> @import url({"stylesheets/browsers/ie5.css"|ezdesign(no)});    </style> <![endif]-->
<!--[if lte IE 6]> <style type="text/css"> @import url({"stylesheets/browsers/ie6lte.css"|ezdesign(no)}); </style> <![endif]-->
<!--[if !IE]> -->
<!-- Can be used to set styles and content IE should not get -->
<!-- <![endif]-->
<!--[if IE]>        <style type="text/css"> @import url({"stylesheets/browsers/ie.css"|ezdesign(no)});      </style> <![endif]-->
<!-- Height resize script; used for resizing columns to equal heights -->
<script type="text/javascript" src={"javascript/heightresize.js"|ezdesign}></script>
</head>
<body>

{def $pagedesign=fetch_alias( 'by_identifier', hash( 'attr_id', 'sitestyle_identifier' ) )}

<div id="page" class="nosidemenu noextrainfo">
  <!-- Change between "sidemenu"/"nosidemenu" and "extrainfo"/"noextrainfo" to switch display of side columns on or off  -->
  <!-- Header area: START -->
  <div id="header" class="float-break">
  <div id="usermenu">
    <div id="languages">
        <ul>
        {def $locales=fetch( 'content', 'translation_list' )}
        {if $locales|count|gt( 1 )}
        {foreach $locales as $locale}
               <li><a href={concat( "/",
                     $locale.country_code|downcase(), "/",
                     $DesignKeys:used.url_alias
                     )|ezroot}>
                   {$locale.intl_language_name}
               </a></li>
        {/foreach}
        {/if}
        </ul>
    </div>
    <div id="links">
        <ul>
            <li><a href={$pagedesign.data_map.site_map_url.content|ezurl} title="{$pagedesign.data_map.site_map_url.data_text|wash}">{$pagedesign.data_map.site_map_url.data_text|wash}</a></li>
        {if $pagedesign.data_map.hide_login_label.data_int|not}
        {if $current_user.is_logged_in}
            <li><a href={concat( "/user/edit/", $current_user.contentobject_id )|ezurl} title="{$pagedesign.data_map.my_profile_label.data_text|wash}">{$pagedesign.data_map.my_profile_label.data_text|wash}</a></li>
            <li><a href={"/user/logout"|ezurl} title="{$pagedesign.data_map.logout_label.data_text|wash}">{$pagedesign.data_map.logout_label.data_text|wash}</a></li>
        {else}
            {if ezmodule( 'user/register' )}
                <li><a href={"/user/register"|ezurl} title="{$pagedesign.data_map.register_user_label.data_text|wash}">{$pagedesign.data_map.register_user_label.data_text|wash}</a></li>
            {/if}
            <li><a href={"/user/login"|ezurl} title="{$pagedesign.data_map.login_label.data_text|wash}">{$pagedesign.data_map.login_label.data_text|wash}</a></li>
        {/if}
        {/if}

        {if eq( $current_user.contentobject_id, 14 )}
            <li><a href={concat( "/content/edit/", $pagedesign.id, "/f/", $pagedesign.current_language )|ezurl} title="{$pagedesign.data_map.site_settings_label.data_text|wash}">{$pagedesign.data_map.site_settings_label.data_text|wash}</a></li>
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
  <hr class="hide" />
  <!-- Top menu area: START -->
  <div id="topmenu" class="float-break">
    <h2 class="hide">Top menu</h2>
    <div class="topmenu-design">
    <!-- Top menu content: START -->
    <ul>
      <li class="selected"><a href={"/"|ezurl}>{ezini('SiteSettings','SiteName')}</a></li>
    </ul>
    <!-- Top menu content: END -->
    </div>
  </div>
  {/cache-block}
  
  <!-- Top menu area: END -->
  {if or( ne( $module_result.content_info.class_identifier, 'frontpage' ), 
                  eq( $module_result.content_info.viewmode, 'sitemap' ) )}
  <hr class="hide" />
  <!-- Path area: START -->
  <div id="path">
    <h2 class="hide">Path</h2>
    {include uri='design:parts/path.tpl'}
  </div>
  <!-- Path area: END -->
  {/if}
  <hr class="hide" />
  <!-- Columns area: START -->
  <div id="columns" class="float-break">
    <!-- Side menu area: START -->
    <div id="sidemenu-position">
      <div id="sidemenu" {if eq( $isset_toolbar, '1' )}style="margin-top: 46px"{/if}>
        <div id="heightresize-sidemenu">
          <!-- Used only for height resize script -->
          <h2 class="hide">Side menu</h2>
          {if gt($module_result.path|count, 1)}
          {include uri='design:menu/flat_left.tpl'}
          {/if}
        </div>
      </div>
    </div>
    <!-- Side menu area: END -->
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
    <!-- Extra area: START -->
    <div id="extrainfo-position">
      <div id="extrainfo" {if eq( $isset_toolbar, '1' )}style="margin-top: 46px"{/if}>
        <div id="heightresize-extrainfo">
          <!-- Used only for height resize script -->
          <h2 class="hide">Extra info</h2>
          <!-- Extra content: START -->
            {include uri='design:parts/extra_info.tpl'}
          <!-- Extra content: END -->
        </div>
        <!-- Used only for height resize script -->
      </div>
    </div>
    <!-- Extra area: END -->
  </div>
  <!-- Columns area: END -->
  <hr class="hide" />
  <!-- Footer area: START -->
  <div id="footer">
    <address>
    Copyright &#169; 2006 eZ systems AS. All rights reserved. <br />
    Powered by <a href={"/ezinfo/about"|ezurl}>eZ publish&#8482;</a> Content Management System.
    </address>
  </div>
  <!-- Footer area: END -->
</div>
<!-- Complete page area: END -->

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>