{ezscript_require( 'tools/ezjsselection.js' )}
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-history">

{switch match=$edit_warning}
{case match=1}
<div class="message-warning">
<h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {'Version not a draft'|i18n( 'design/ezwebin/content/history' )}</h2>
<ul>
    <li>{'Version %1 is not available for editing anymore. Only drafts can be edited.'|i18n( 'design/ezwebin/content/history',, array( $edit_version ) )}</li>
    <li>{'To edit this version, first create a copy of it.'|i18n( 'design/ezwebin/content/history' )}</li>
</ul>
</div>
{/case}
{case match=2}
<div class="message-warning">
<h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {'Version not yours'|i18n( 'design/ezwebin/content/history' )}</h2>
<ul>
    <li>{'Version %1 was not created by you. Only your own drafts can be edited.'|i18n( 'design/ezwebin/content/history',, array( $edit_version ) )}</li>
    <li>{'To edit this version, first create a copy of it.'|i18n( 'design/ezwebin/content/history' )}</li>
</ul>
</div>
{/case}
{case match=3}
<div class="message-warning">
<h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {'Unable to create new version'|i18n( 'design/ezwebin/content/history' )}</h2>
<ul>
    <li>{'Version history limit has been exceeded and no archived version can be removed by the system.'|i18n( 'design/ezwebin/content/history' )}</li>
    <li>{'You can either change your version history settings in content.ini, remove draft versions or edit existing drafts.'|i18n( 'design/ezwebin/content/history' )}</li>
</ul>
</div>
{/case}
{case}
{/case}
{/switch}


{def $page_limit   = 30
     $list_count   = fetch(content,version_count, hash(contentobject, $object))
     $current_user = fetch( 'user', 'current_user' )}


<form name="versionsform" action={concat( '/content/history/', $object.id, '/' )|ezurl} method="post">

<div class="attribute-header">
    <h1 class="long">{'Versions for <%object_name> [%version_count]'|i18n( 'design/ezwebin/content/history',, hash( '%object_name', $object.name, '%version_count', $list_count ) )|wash}</h1>
</div>

{if $list_count}
<table class="list" cellspacing="0">
<tr>
    <th class="tight"><img src={'toggle-button-16x16.gif'|ezimage} alt="{'Toggle selection'|i18n( 'design/ezwebin/content/history' )}" onclick="ezjs_toggleCheckboxes( document.versionsform, 'DeleteIDArray[]' ); return false;" /></th>
    <th>{'Version'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Status'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Modified translation'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Creator'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Created'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Modified'|i18n( 'design/ezwebin/content/history' )}</th>
    <th class="tight">&nbsp;</th>
    <th class="tight">&nbsp;</th>
</tr>


{foreach fetch( content, version_list, hash( 'contentobject', $object,
                                             'limit', $page_limit,
                                             'offset', $view_parameters.offset ) ) as $version
         sequence array( bglight, bgdark ) as $seq
}

{def $initial_language = $version.initial_language}
<tr class="{$seq}">

    {* Remove. *}
    <td>
        {if and( $version.can_remove, array( 0, 3, 4, 5 )|contains( $version.status ) )}
            <input type="checkbox" name="DeleteIDArray[]" value="{$version.id}" title="{'Select version #%version_number for removal.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $version.version ) )}" />
        {else}
            <input type="checkbox" name="" value="" disabled="disabled" title="{'Version #%version_number cannot be removed because it is either the published version of the object or because you do not have permission to remove it.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $version.version ) )}" />
        {/if}
    </td>

    {* Version/view. *}
    <td><a href={concat( '/content/versionview/', $object.id, '/', $version.version, '/', $initial_language.locale )|ezurl} title="{'View the contents of version #%version_number. Translation: %translation.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $version.version, '%translation', $initial_language.name ) )}">{$version.version}</a></td>

    {* Status. *}
    <td>{$version.status|choose( 'Draft'|i18n( 'design/ezwebin/content/history' ), 'Published'|i18n( 'design/ezwebin/content/history' ), 'Pending'|i18n( 'design/ezwebin/content/history' ), 'Archived'|i18n( 'design/ezwebin/content/history' ), 'Rejected'|i18n( 'design/ezwebin/content/history' ), 'Untouched draft'|i18n( 'design/ezwebin/content/history' ) )}</td>

    {* Modified translation. *}
    <td>
        <img src="{$initial_language.locale|flag_icon}" alt="{$initial_language.locale}" />&nbsp;<a href={concat('/content/versionview/', $object.id, '/', $version.version, '/', $initial_language.locale, '/' )|ezurl} title="{'View the contents of version #%version_number. Translation: %translation.'|i18n( 'design/ezwebin/content/history',, hash( '%translation', $initial_language.name, '%version_number', $version.version ) )}" >{$initial_language.name|wash}</a>
    </td>

    {* Creator. *}
    <td>{$version.creator.name|wash}</td>

    {* Created. *}
    <td>{$version.created|l10n( shortdatetime )}</td>

    {* Modified. *}
    <td>{$version.modified|l10n( shortdatetime )}</td>

    {* Copy button. *}
    <td align="right" class="right">
    {def $can_edit_lang = 0}
    {foreach $object.can_edit_languages as $edit_language}
        {if eq( $edit_language.id, $initial_language.id )}
        {set $can_edit_lang = 1}
        {/if}
    {/foreach}

        {if and( $can_edit, $can_edit_lang )}
          {if eq( $version.status, 5 )}
            <input type="image" src={'copy-disabled.gif'|ezimage} name="" value="" disabled="disabled" title="{'There is no need to do a copies of untouched drafts.'|i18n( 'design/ezwebin/content/history' )}" />
          {else}
            <input type="hidden" name="CopyVersionLanguage[{$version.version}]" value="{$initial_language.locale}" />
            <input type="image" src={'copy.gif'|ezimage} name="HistoryCopyVersionButton[{$version.version}]" value="" title="{'Create a copy of version #%version_number.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $version.version ) )}" />
          {/if}
        {else}
            <input type="image" src={'copy-disabled.gif'|ezimage} name="" value="" disabled="disabled" title="{'You cannot make copies of versions because you do not have permission to edit the object.'|i18n( 'design/ezwebin/content/history' )}" />
        {/if}
    {undef $can_edit_lang}
    </td>

    {* Edit button. *}
    <td>
        {if and( array(0, 5)|contains($version.status), $version.creator_id|eq( $current_user.contentobject_id ), $can_edit ) }
            <input type="image" src={'edit.gif'|ezimage} name="HistoryEditButton[{$version.version}]" value="" title="{'Edit the contents of version #%version_number.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $version.version ) )}" />
        {else}
            <input type="image" src={'edit-disabled.gif'|ezimage} name="HistoryEditButton[{$version.version}]" value="" disabled="disabled" title="{'You cannot edit the contents of version #%version_number either because it is not a draft or because you do not have permission to edit the object.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $version.version ) )}" />
        {/if}
    </td>

</tr>
{undef $initial_language}
{/foreach}
</table>
{else}
<div class="block">
<p>{'This object does not have any versions.'|i18n( 'design/ezwebin/content/history' )}</p>
</div>
{/if}

<div class="context-toolbar">
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=concat( '/content/history/', $object.id, '///' )
         item_count=$list_count
         view_parameters=$view_parameters
         item_limit=$page_limit}
</div>

<div class="block context-controls">

<div class="left">
<input class="button" type="submit" name="RemoveButton" value="{'Remove selected'|i18n( 'design/ezwebin/content/history' )}" title="{'Remove the selected versions from the object.'|i18n( 'design/ezwebin/content/history' )}" />
<input type="hidden" name="DoNotEditAfterCopy" value="" />
</div>


</form>

{if $object.can_diff}
{def $languages=$object.languages}

<div class="right">

<form action={concat( $module.functions.history.uri, '/', $object.id, '/' )|ezurl} method="post">
        <select name="Language">
            {foreach $languages as $lang}
                <option value="{$lang.locale}">{$lang.name|wash}</option>
            {/foreach}
        </select>
        <select name="FromVersion">
            {foreach $object.versions as $ver}
                <option {if eq( $ver.version, $selectOldVersion)}selected="selected"{/if} value="{$ver.version}">{$ver.version|wash}</option>
            {/foreach}
        </select>
        <select name="ToVersion">
            {foreach $object.versions as $ver}
                <option {if eq( $ver.version, $selectNewVersion)}selected="selected"{/if} value="{$ver.version}">{$ver.version|wash}</option>
            {/foreach}
        </select>
    <input type="hidden" name="ObjectID" value="{$object.id}" />
    <input class="button" type="submit" name="DiffButton" value="{'Show differences'|i18n( 'design/ezwebin/content/history' )}" />
</form>

</div>

</div>

{/if}

<div class="break"></div>


<div class="block">
<div class="left">
<form name="versionsback" action={concat( '/content/history/', $object.id, '/' )|ezurl} method="post">
{if is_set( $redirect_uri )}
<input class="text" type="hidden" name="RedirectURI" value="{$redirect_uri}" />
{/if}
<input class="button" type="submit" name="BackButton" value="{'Back'|i18n( 'design/ezwebin/content/history' )}" />
</form>
</div>
</div>


<div class="break"></div>

<br />
{if and( is_set( $object ), is_set( $diff ), is_set( $oldVersion ), is_set( $newVersion ) )|not}

<div class="attribute-header">
    <h1 class="long">{'Published version'|i18n( 'design/ezwebin/content/history' )}</h1>
</div>

<table class="list" cellspacing="0">
<tr>
    <th>{'Version'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{"Translations"|i18n("design/ezwebin/content/history")}</th>
    <th>{'Creator'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Created'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Modified'|i18n( 'design/ezwebin/content/history' )}</th>
    <th class="tight">&nbsp;</th>
    <th class="tight">&nbsp;</th>
</tr>

{def $published_item=$object.current
     $initial_language = $published_item.initial_language}
<tr class="bglight">

    {* Version/view. *}
    <td><a href={concat( '/content/versionview/', $object.id, '/', $published_item.version, '/', $initial_language.locale )|ezurl} title="{'View the contents of version #%version_number. Translation: %translation.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $published_item.version, '%translation', $initial_language.name ) )}">{$published_item.version}</a></td>

    {* Translations *}
    <td>
        {foreach $published_item.language_list as $lang}
            {delimiter}<br />{/delimiter}
            <img src="{$lang.language_code|flag_icon}" alt="{$lang.language_code|wash}" />&nbsp;
            <a href={concat("/content/versionview/",$object.id,"/",$published_item.version,"/",$lang.language_code,"/")|ezurl}>{$lang.locale.intl_language_name|wash}</a>
        {/foreach}
    </td>

    {* Creator. *}
    <td>{$published_item.creator.name|wash}</td>

    {* Created. *}
    <td>{$published_item.created|l10n( shortdatetime )}</td>

    {* Modified. *}
    <td>{$published_item.modified|l10n( shortdatetime )}</td>

    {* Copy translation list. *}
    <td align="right" class="right">
        <select name="CopyVersionLanguage[{$published_item.version}]">
            {foreach $published_item.language_list as $lang_list}
                <option value="{$lang_list.language_code}"{if $lang_list.language_code|eq($published_item.initial_language.locale)} selected="selected"{/if}>{$lang_list.locale.intl_language_name|wash}</option>
            {/foreach}
        </select>
    </td>

    {* Copy button *}
    <td>
        {def $can_edit_lang = 0}
        {foreach $object.can_edit_languages as $edit_language}
            {if eq( $edit_language.id, $initial_language.id )}
            {set $can_edit_lang = 1}
            {/if}
        {/foreach}

        {if and( $can_edit, $can_edit_lang )}
            <input type="image" src={'copy.gif'|ezimage} name="HistoryCopyVersionButton[{$published_item.version}]" value="" title="{'Create a copy of version #%version_number.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $published_item.version ) )}" />
        {else}
            <input type="image" src={'copy-disabled.gif'|ezimage} name="" value="" disabled="disabled" title="{'You cannot make copies of versions because you do not have permission to edit the object.'|i18n( 'design/ezwebin/content/history' )}" />
        {/if}
        {undef $can_edit_lang}
    </td>

</tr>
{undef $initial_language}
</table>

<div class="attribute-header">
    <h1 class="long">{'New drafts [%newerDraftCount]'|i18n( 'design/ezwebin/content/history',, hash( '%newerDraftCount', $newerDraftVersionListCount ) )}</h1>
</div>

{if $newerDraftVersionList|count|ge(1)}
<table class="list" cellspacing="0">
<tr>
    <th>{'Version'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Modified translation'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Creator'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Created'|i18n( 'design/ezwebin/content/history' )}</th>
    <th>{'Modified'|i18n( 'design/ezwebin/content/history' )}</th>
    <th class="tight">&nbsp;</th>
    <th class="tight">&nbsp;</th>
</tr>

{foreach $newerDraftVersionList as $draft_version
    sequence array( bglight, bgdark ) as $seq}
{def $initial_language = $draft_version.initial_language}
<tr class="{$seq}">

    {* Version/view. *}
    <td><a href={concat( '/content/versionview/', $object.id, '/', $draft_version.version, '/', $initial_language.locale )|ezurl} title="{'View the contents of version #%version_number. Translation: %translation.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $draft_version.version, '%translation', $initial_language.name ) )}">{$draft_version.version}</a></td>

    {* Modified translation. *}
    <td>
        <img src="{$initial_language.locale|flag_icon}" alt="{$initial_language.locale}" />&nbsp;<a href={concat('/content/versionview/', $object.id, '/', $draft_version.version, '/', $initial_language.locale, '/' )|ezurl} title="{'View the contents of version #%version_number. Translation: %translation.'|i18n( 'design/ezwebin/content/history',, hash( '%translation', $initial_language.name, '%version_number', $draft_version.version ) )}" >{$initial_language.name|wash}</a>
    </td>

    {* Creator. *}
    <td>{$draft_version.creator.name|wash}</td>

    {* Created. *}
    <td>{$draft_version.created|l10n( shortdatetime )}</td>

    {* Modified. *}
    <td>{$draft_version.modified|l10n( shortdatetime )}</td>

    {* Copy button. *}
    <td align="right" class="right">
    {def $can_edit_lang = 0}
    {foreach $object.can_edit_languages as $edit_language}
        {if eq( $edit_language.id, $initial_language.id )}
        {set $can_edit_lang = 1}
        {/if}
    {/foreach}

        {if and( $can_edit, $can_edit_lang )}
            <input type="hidden" name="CopyVersionLanguage[{$draft_version.version}]" value="{$initial_language.locale}" />
            <input type="image" src={'copy.gif'|ezimage} name="HistoryCopyVersionButton[{$draft_version.version}]" value="" title="{'Create a copy of version #%version_number.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $draft_version.version ) )}" />
        {else}
            <input type="image" src={'copy-disabled.gif'|ezimage} name="" value="" disabled="disabled" title="{'You cannot make copies of versions because you do not have permission to edit the object.'|i18n( 'design/ezwebin/content/history' )}" />
        {/if}
    {undef $can_edit_lang}
    </td>

    {* Edit button. *}
    <td>
        {if and( array(0, 5)|contains($draft_version.status), $draft_version.creator_id|eq( $current_user.contentobject_id ), $can_edit ) }
            <input type="image" src={'edit.gif'|ezimage} name="HistoryEditButton[{$draft_version.version}]" value="" title="{'Edit the contents of version #%version_number.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $draft_version.version ) )}" />
        {else}
            <input type="image" src={'edit-disabled.gif'|ezimage} name="HistoryEditButton[{$draft_version.version}]" disabled="disabled" value="" title="{'You cannot edit the contents of version #%version_number either because it is not a draft or because you do not have permission to edit the object.'|i18n( 'design/ezwebin/content/history',, hash( '%version_number', $draft_version.version ) )}" />
        {/if}
    </td>

</tr>
{undef $initial_language}
{/foreach}
</table>
{else}
<div class="block">
<p>{'This object does not have any drafts.'|i18n( 'design/ezwebin/content/history' )}</p>
</div>
{/if}

{elseif and( is_set( $object ), is_set( $diff ), is_set( $oldVersion ), is_set( $newVersion ) )}
{literal}
<script type="text/javascript">
function show( element, method )
{
    document.getElementById( element ).className = method;
}
</script>
{/literal}

<div class="attribute-header">
    <h1 class="long">{'Differences between versions %oldVersion and %newVersion'|i18n( 'design/ezwebin/content/history',, hash( '%oldVersion', $oldVersion, '%newVersion', $newVersion ) )}</h1>
</div>

<div id="diffview">

<script type="text/javascript">
document.write('<div class="context-toolbar"><div class="block"><ul><li><a href="#" onclick="show(\'diffview\', \'previous\'); return false;">{'Old version'|i18n( 'design/ezwebin/content/history' )}</a></li><li><a href="#" onclick="show(\'diffview\', \'inlinechanges\'); return false;">{'Inline changes'|i18n( 'design/ezwebin/content/history' )}</a></li><li><a href="#" onclick="show(\'diffview\', \'blockchanges\'); return false;">{'Block changes'|i18n( 'design/ezwebin/content/history' )}</a></li><li><a href="#" onclick="show(\'diffview\', \'latest\'); return false;">{'New version'|i18n( 'design/ezwebin/content/history' )}</a></li></ul></div></div>');
</script>

{foreach $object.data_map as $attr}
<div class="block">
<label>{$attr.contentclass_attribute.name}:</label>
<div class="attribute-view-diff">
        {attribute_diff_gui view=diff attribute=$attr old=$oldVersion new=$newVersion diff=$diff[$attr.contentclassattribute_id]}
</div>
</div>
{/foreach}

</div>


<div class="block">
<div class="left">
<form action={concat( '/content/history/', $object.id, '/' )|ezurl} method="post">
<input class="button" type="submit" value="{'Back to history'|i18n( 'design/ezwebin/content/history' )}" />
</form>
</div>
</div>
{/if}

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>