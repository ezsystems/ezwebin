{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

{let hide_status=""}
{section show=$node.is_invisible}
{set hide_status=concat( '(', $node.hidden_status_string, ')' )}
{/section}

<h1 class="context-title"><a href={concat( '/class/view/', $node.object.contentclass_id )|ezurl} onclick="ezpopmenu_showTopLevel( event, 'ClassMenu', ez_createAArray( new Array( '%classID%', {$node.object.contentclass_id}, '%objectID%', {$node.contentobject_id}, '%nodeID%', {$node.node_id}, '%currentURL%', '{$node.url|wash( javascript )}' ) ), '{$node.class_name|wash(javascript)}', 20 ); return false;">{$node.class_identifier|class_icon( normal, $node.class_name )}</a>&nbsp;{$node.name|wash}&nbsp;[{$node.class_name|wash}]&nbsp;{$hide_status}</h1>

{/let}

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

<form method="post" action={'content/action'|ezurl}>
<div class="box-ml"><div class="box-mr">

<div class="context-information">
<p class="modified">{'Last modified'|i18n( 'design/admin/node/view/full' )}: {$node.object.modified|l10n(shortdatetime)}, <a href={$node.object.current.creator.main_node.url_alias|ezurl}>{$node.object.current.creator.name|wash}</a></p>
<p class="translation">{$node.object.current_language_object.locale_object.intl_language_name}&nbsp;<img src="{$node.object.current_language|flag_icon}" alt="{$language_code}" style="vertical-align: middle;" /></p>
<div class="break"></div>
</div>

{* Content preview in content window. *}
<div class="fixedsize">{* Fix for overflow bug in Opera *}
<div class="holdinplace">{* Fix for some width bugs in IE *}
    {node_view_gui content_node=$node view=admin_preview}
</div>
</div>

</div></div>

{* Buttonbar for content window. *}
<div class="controlbar">

{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">

<input type="hidden" name="TopLevelNode" value="{$node.object.main_node_id}" />
<input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
<input type="hidden" name="ContentObjectID" value="{$node.object.id}" />

<div class="block">

<div class="left">
{* Edit button. *}
{def $can_edit_languages   = $node.object.can_edit_languages
     $can_create_languages = $node.object.can_create_languages}
{section show=$node.can_edit}
    <input class="button" type="submit" name="EditButton" value="{'Edit'|i18n( 'design/admin/node/view/full' )}" title="{'Edit the contents of this item.'|i18n( 'design/admin/node/view/full' )}" />
{section-else}
    <select name="ContentObjectLanguageCode" disabled="disabled">
        <option value="">{'Not available'|i18n( 'design/admin/node/view/full')}</option>
    </select>
    <input class="button-disabled" type="submit" name="EditButton" value="{'Edit'|i18n( 'design/admin/node/view/full' )}" title="{'You do not have permissions to edit this item.'|i18n( 'design/admin/node/view/full' )}" disabled="disabled" />
{/section}
{undef $can_edit_languages $can_create_languages}

</div>

{* Custom content action buttons. *}
<div class="right">
{section var=ContentActions loop=$node.object.content_action_list}
    <input class="button" type="submit" name="{$ContentActions.item.action}" value="{$ContentActions.item.name}" />
{/section}
</div>

{* The preview button has been commented out. Might be absent until better preview functionality is implemented. *}
{* <input class="button" type="submit" name="ActionPreview" value="{'Preview'|i18n('design/admin/node/view/full')}" /> *}

<div class="break"></div>

</div>

{* DESIGN: Control bar END *}</div></div></div></div></div></div>

</div>

</form>

