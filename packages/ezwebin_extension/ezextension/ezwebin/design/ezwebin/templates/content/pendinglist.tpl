{def $page_limit=15
     $list_count=fetch( 'content', 'pending_count' )}
<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">

<div class="content-pendinglist">

<form name="pendinglistaction" action={concat("/content/pendinglist")|ezurl} method="post" >

<div class="attribute-header">
    <h1 class="long">{'My pending items [%pending_count]'|i18n( 'design/ezwebin/content/pendinglist',, hash( '%pending_count', $list_count ) )}</h1>
</div>

{if $list_count}

<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
    <th>{"Name"|i18n("design/ezwebin/content/pendinglist")}</th>
    <th>{"Class"|i18n("design/ezwebin/content/pendinglist")}</th>
    <th>{"Section"|i18n("design/ezwebin/content/pendinglist")}</th>
    <th>{"Version"|i18n("design/ezwebin/content/pendinglist")}</th>
    <th>{"Last modified"|i18n("design/ezwebin/content/pendinglist")}</th>
</tr>

{foreach fetch( 'content', 'pending_list', hash( 'limit', $page_limit,
                                                 'offset', $view_parameters.offset ) ) as $pending_item
         sequence array( 'bglight', 'bgdark' ) as $style}
<tr class="{$style}">
   <td>
        {$pending_item.contentobject.content_class.identifier|class_icon( small, $pending_item.contentobject.content_class.name )}&nbsp;<a href={concat( "/content/versionview/", $pending_item.contentobject.id, "/", $pending_item.version )|ezurl} title="{$pending_item.contentobject.name|wash}">{$pending_item.contentobject.name|wash}</a>
    </td>
    <td>
        {$pending_item.contentobject.content_class.name|wash}
    </td>
    <td>
        {def $section_object=fetch( 'section', 'object', hash( 'section_id', $pending_item.contentobject.section_id ) )}
        {if $section_object}
            {$section_object.name|wash}
        {else}
            <i>{'Unknown'|i18n( 'design/ezwebin/content/pendinglist' )}</i>
        {/if}
    </td>
    <td>
        {$pending_item.version}
    </td>
    <td>
        {$pending_item.modified|l10n( shortdatetime )}
    </td>
</tr>
{/foreach}
</table>

{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri='/content/pendinglist'
         item_count=$list_count
         view_parameters=$view_parameters
         item_limit=$page_limit}

{else}

<div class="feedback">
    <h2>{"Your pending list is empty"|i18n("design/ezwebin/content/pendinglist")}</h2>
</div>

{/if}

</form>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>