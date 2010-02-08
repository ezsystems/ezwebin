{def $plimit=30
     $list_count=fetch( content, version_count, hash( contentobject, $object ) )
     $languages=fetch( content, prioritized_languages )
     $initLang=false()
}
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-diff">

<div class="attribute-header">
    <h1 class="long">{'Versions for <%object_name> [%version_count]'|i18n( 'design/ezwebin/content/diff',, hash( '%object_name', $object.name, '%version_count', $list_count ) )|wash}</h1>
</div>

{if $list_count}
    <table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <th>
                {"Version"|i18n("design/ezwebin/content/diff")}:
            </th>
            <th>
                {"Status"|i18n("design/ezwebin/content/diff")}:
            </th>
            <th>
                {"Translations"|i18n("design/ezwebin/content/diff")}:
            </th>
            <th>
                {"Creator"|i18n("design/ezwebin/content/diff")}:
            </th>
            <th>
                {"Modified"|i18n("design/ezwebin/content/diff")}:
            </th>
        </tr>
        {foreach fetch( 'content', 'version_list', hash( 'contentobject', $object,
                                                         'limit', $plimit,
                                                         'offset', $view_parameters.offset ) ) as $version
                 sequence array( 'bglight', 'bgdark' ) as $seq}
        {set $initLang=$version.initial_language}
        <tr class="{$seq}">
            <td>
                <a href={concat( "/content/versionview/", $object.id, "/", $version.version, "/", $initLang.locale )|ezurl}>{$version.version}</a>
                {if eq($version.version,$object.current_version)}*{/if}
            </td>
            <td>{$version.status|choose( 'Draft'|i18n( 'design/ezwebin/content/diff' ), 'Published'|i18n( 'design/ezwebin/content/diff' ), 'Pending'|i18n( 'design/ezwebin/content/diff' ), 'Archived'|i18n( 'design/ezwebin/content/diff' ), 'Rejected'|i18n( 'design/ezwebin/content/diff' ), 'Untouched draft'|i18n( 'design/ezwebin/content/diff' ) )}</td>
            <td>
                {foreach $version.language_list as $lang}
                    {delimiter}<br />{/delimiter}
                    <img src="{$lang.language_code|flag_icon}" alt="{$lang.language_code|wash}" />&nbsp;
                    <a href={concat("/content/versionview/",$object.id,"/",$version.version,"/",$lang.language_code,"/")|ezurl}>{$lang.locale.intl_language_name|wash}</a>
                {/foreach}
            </td>
            <td>
                <a href={concat("/content/view/full/",$version.creator.main_node_id,"/")|ezurl}>{$version.creator.name|wash}</a>
            </td>
            <td>
                {$version.modified|l10n(shortdatetime)}
            </td>
        </tr>
        {/foreach}
    </table>
{else}
    <div class="block">
        <p>{'This object does not have any versions.'|i18n( 'design/ezwebin/content/diff' )}</p>
    </div>
{/if}


<div class="context-toolbar">
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=concat( '/content/diff/', $object.id, '///' )
         item_count=$list_count
         view_parameters=$view_parameters
         item_limit=$plimit}
</div>

<div class="block">
<form action={concat( $module.functions.diff.uri, '/', $object.id, '/' )|ezurl} method="post">
        <select name="Language">
            {foreach $languages as $lang}
                <option value="{$lang.locale}">{$lang.name|wash}</option>
            {/foreach}
        </select>
        <select name="FromVersion">
            {foreach $object.versions as $ver}
                <option {if eq( $ver.version, $selectOldVersion)}selected="selected"{/if} value="{$ver.version}">{$ver.name|shorten(35)|wash} [{$ver.version}]</option>
            {/foreach}
        </select>
        <select name="ToVersion">
            {foreach $object.versions as $ver}
                <option {if eq( $ver.version, $selectNewVersion)}selected="selected"{/if} value="{$ver.version}">{$ver.name|shorten(35)|wash} [{$ver.version}]</option>
            {/foreach}
        </select>
    <input type="hidden" name="ObjectID" value="{$object.id}" />
    <input class="button" type="submit" name="DiffButton" value="{'Show differences'|i18n( 'design/ezwebin/content/diff' )}" />
</form>
<div class="break"></div>
</div>


{literal}
<script type="text/javascript">
function show( element, method )
{
    document.getElementById( element ).className = method;
}
</script>
{/literal}

{if and( is_set( $object ), is_set( $diff ), is_set( $oldVersion ), is_set( $newVersion ) )}
<h2>{'Differences between versions %oldVersion and %newVersion'|i18n( 'design/ezwebin/content/diff',, hash( '%oldVersion', $oldVersion, '%newVersion', $newVersion ) )}</h2>



<div id="diffview">

<script type="text/javascript">
document.write('<div class="context-toolbar"><div class="block"><ul><li><a href="#" onclick="show(\'diffview\', \'previous\'); return false;">{'Old version'|i18n( 'design/ezwebin/content/diff' )}</a></li><li><a href="#" onclick="show(\'diffview\', \'inlinechanges\'); return false;">{'Inline changes'|i18n( 'design/ezwebin/content/diff' )}</a></li><li><a href="#" onclick="show(\'diffview\', \'blockchanges\'); return false;">{'Block changes'|i18n( 'design/ezwebin/content/diff' )}</a></li><li><a href="#" onclick="show(\'diffview\', \'latest\'); return false;">{'New version'|i18n( 'design/ezwebin/content/diff' )}</a></li></ul></div></div>');
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

{/if}

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>