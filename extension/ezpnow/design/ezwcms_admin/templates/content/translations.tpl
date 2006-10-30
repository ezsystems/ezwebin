
{section show=eq( $error, 'priority' )}
<div class="message-error">
<h2>{'Wrong numbers for priority update'|i18n( 'design/admin/' )}</h2>
</div>
{/section}

<form name="languageform" action={$module.functions.translations.uri|ezurl} method="post" >

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


<div class="context-block">
{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">
<h1 class="context-title">{'Available languages for translation of content [%translations_count]'|i18n( 'design/admin/content/translations',, hash( '%translations_count', $available_translations|count ) )}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

<table class="list" cellspacing="0">
<tr>
    <th class="tight"><img src={'toggle-button-16x16.gif'|ezimage} alt="{'Invert selection.'|i18n( 'design/admin/content/translations' )}" title="{'Invert selection.'|i18n( 'design/admin/content/translations' )}" onclick="ezjs_toggleCheckboxes( document.languageform, 'DeleteIDArray[]' ); return false;"/></th>
    <th>{'Language'|i18n( 'design/admin/content/translations' )}</th>
	<th>{'Country'|i18n( 'design/admin/content/translations' )}</th>
	<th>{'Locale'|i18n( 'design/admin/content/translations' )}</th>
	<th>{'Priority'|i18n( 'design/admin/content/translations' )}</th>
	<th class="tight">{'Translations'|i18n( 'design/admin/content/translations' )}</th>
</tr>

{def $counter=1}
{section var=Translations loop=$available_translations sequence=array( bglight, bgdark )}
{def $object_count=$Translations.item.object_count}
<tr class="{$Translations.sequence}">
    {* Remove. *}
	<td>
    {if $object_count}
        <input type="checkbox" name="DeleteIDArray[]" value="" title="{'The language can not be removed because it is in use.'|i18n( 'design/admin/content/translations' )}" disabled="disabled" />
    {else}
        <input type="checkbox" name="DeleteIDArray[]" value="{$Translations.item.translation.id}" title="{'Select language for removal.'|i18n( 'design/admin/content/translations' )}" />
    {/if}
    </td>

    {* Language. *}
	<td>
    <img src="{$Translations.item.translation.locale_object.locale_code|flag_icon}" alt="{$Translations.item.translation.locale_object.intl_language_name}" /> 
    <a href={concat( '/content/translations/', $Translations.item.translation.id )|ezurl}>
    {section show=$Translations.item.translation.name|wash}
        {$Translations.item.translation.name|wash}
    {section-else}
        {$Translations.item.translation.locale_object.intl_language_name|wash}
    {/section}</a>
    </td>

    {* Country. *}
	<td>{$Translations.item.translation.locale_object.country_name|wash}</td>

    {* Locale. *}
	<td>{$Translations.item.translation.locale_object.locale_code|wash}</td>

    {* Locale. *}
	<td><input type="text" name="Priority[]" size="3" value={$counter} /></td>
	
    {* Object count *}
	<td class="number" align="right">{$object_count}</td>
</tr>
{set $counter=inc( $counter )}
{undef $object_count}
{/section}
{undef $counter}
</table>

{* DESIGN: Content END *}</div></div></div>

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">
<input class="button" type="submit" name="RemoveButton" value="{'Remove selected'|i18n( 'design/admin/content/translations' )}" title="{'Remove selected languages.'|i18n( 'design/admin/content/translations' )}" />
<input class="button" type="submit" name="NewButton"    value="{'Add language'|i18n( 'design/admin/content/translations' )}" title="{'Add a new language. The new language can then be used when translating content.'|i18n( 'design/admin/content/translations' )}" />
<input class="button" type="submit" name="UpdatePriority"    value="{'Update priority'|i18n( 'design/admin/content/translations' )}" title="{'Add a new language. The new language can then be used when translating content.'|i18n( 'design/admin/content/translations' )}" />
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</div>

</form>
