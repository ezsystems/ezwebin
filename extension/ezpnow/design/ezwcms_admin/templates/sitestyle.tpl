

<form name="editform" id="editform" enctype="multipart/form-data" method="post" action={'ezpldesign/sitestyle'|ezurl}>

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">Sitestyle</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">
<div class="context-attributes">

<div class="block">
    {if is_set( ezhttp( 'CurrentSiteAccess', 'post' ) ) }
	    {def $current_siteaccess=ezhttp( 'CurrentSiteAccess', 'post' ) }
	{else}
        {def $current_siteaccess=ezini( 'SiteSettings', 'DefaultAccess', 'site.ini' ) }
    {/if}
    <select name="CurrentSiteAccess">
        {section name=SiteAccessList loop=ezini( 'SiteAccessSettings', 'AvailableSiteAccessList', 'site.ini' ) }
            {section show=eq( $current_siteaccess, $SiteAccessList:item )}
                <option selected="selected" value="{$SiteAccessList:item}">{$SiteAccessList:item}</option>
            {section-else}
                <option value="{$SiteAccessList:item}">{$SiteAccessList:item}</option>
	        {/section}
        {/section}
		</select>
    {undef}
</div>

</div>
{* DESIGN: Content END *}</div></div></div>

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">
    <input class="button" name="UpdateSiteAccess" type="submit" value="{'Change siteaccess'|i18n( 'design/admin/content/edit' )}" />
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

<br />

{default attribute_base=ContentObjectAttribute}
{let package_list=fetch( package, list,
                         hash( filter_array, array( array( type, 'sitestyle' ) ) ) )}

{if is_set( ezhttp( 'CurrentSiteAccess', 'post' ) ) }
    {def $current_siteaccess=ezhttp( 'CurrentSiteAccess', 'post' ) }
{else}
    {def $current_siteaccess=ezini( 'SiteSettings', 'DefaultAccess', 'site.ini' ) }
{/if}

{def $CurrentPageStyle=ezini( 'StylesheetSettings', 'PageStyle', 'design.ini', concat( 'settings/siteaccess/', $current_siteaccess ) ) }


{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
<h1 class="context-title">Sitestyle</h1>

{* DESIGN: subline *}<div class="header-subline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

<div class="block">
{section name=Package loop=$:package_list}
 <div class="package_element" align="bottom">
      <label for="{$:item.name|wash}"><img class="package-thumbnail" src={$:item|ezpackage( thumbnail )|ezroot} /></label>
      <br />
      <input type="radio" 
             id="{$:item.name|wash}" 
             name="PackageName" 
             value="{$:item.name|wash}"
             {section show=eq( $:item.name, $CurrentPageStyle )} checked{/section}
      <label for="{$:item.name|wash}">{$:item.summary|wash}:</label>
 </div>
{/section}

</div>
{* DESIGN: Content END *}</div></div></div>

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">
    <input class="button" type="submit" name="ChangeStyle" value="{'Change Style'|i18n('design/admin/settings')}" />
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>
</form>