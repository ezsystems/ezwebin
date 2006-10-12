

{def $content_object = $node.object
	 $can_edit_languages   = $content_object.can_edit_languages
     $can_create_languages = $content_object.can_create_languages
  	 $current_user=fetch( 'user', 'current_user' )
	 $classes=array( 'folder', 'gallery', 'frontpage', 'event_calender', 'documentation_page', 'forums', 'forum' )}

{if and( $current_user.is_logged_in, or( $current_user.groups|contains(13), $current_user.groups|contains(12) ) )}

{set-block variable=$isset_toolbar scope='root'}
    {true()}
{/set-block}

<div class="box-et {if eq( $node.class_identifier, 'frontpage' )}frontpage-et{/if}">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">

<div class="block">
<div class="left">
<form method="post" action={"content/action"|ezurl}>
<a href={"/ezinfo/about"|ezurl}><img src={"ez_toolbar.png"|ezimage} alt="eZ Publish" width="49" height="16" /></a>
{if and( $content_object.can_create,$classes|contains( $node.class_identifier ) )}
  <select name="ClassID">
  {foreach $content_object.can_create_class_list as $class}
	<option value="{$class.id}">{$class.name|wash}</option>
  {/foreach}
  </select>
  <input type="hidden" name="ContentLanguageCode" value="{$content_object.initial_language_code}" />
  <input class="button" type="submit" name="NewButton" value="{'Create'|i18n('design/standard/node/view')}" />
{/if}

{if $content_object.can_edit}
	<input type="hidden" name="ContentObjectLanguageCode" value="{$content_object.initial_language_code}" />
  <input class="button" type="submit" name="EditButton" value="{'Edit'|i18n('design/standard/node/view')}" />
{/if}

{if $content_object.can_move}
  <input class="button" type="submit" name="MoveNodeButton" value="{'Move'|i18n( 'design/standard/node/view' )}" />
{/if}

{if $content_object.can_remove}
   <input class="button" type="submit" name="ActionRemove" value="{'Remove'|i18n('design/standard/node/view')}" />
{/if}

  <input type="hidden" name="ContentObjectID" value="{$content_object.id}" />
  <input type="hidden" name="NodeID" value="{$node.node_id}" />
  <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
</form>
</div>

<div class="right">

{def $disable_oo=true()}

{if array( 'documentation_page', 'folder', 'article', 'event' )|contains( $node.class_identifier )}
	{set $disable_oo=false()}
{/if}

{if $disable_oo|not}
<img src={"oo_logo.gif"|ezimage} alt="OpenOffice Integration" width="49" height="18" />

{if and( $content_object.content_class.is_container, ne( $content_object.content_class.identifier, 'article' ) )}
{* Import OOo / OASIS document *}
<form method="post" action={"/oo/import/"|ezurl}>
  <input type="hidden" name="NodeID" value="{$node.node_id}" />
  <input type="hidden" name="ObjectID" value="{$content_object.id}" />
  <input class="button" type="submit" name="ImportAction" value="{'Import'|i18n('design/standard/node/view')}" />
</form>
{/if}
<form method="post" action={"/oo/export/"|ezurl}>
  <input type="hidden" name="NodeID" value="{$node.node_id}" />
  <input type="hidden" name="ObjectID" value="{$content_object.id}" />
  <input class="button" type="submit" name="ExportAction" value="{'Export'|i18n('design/standard/node/view')}" />
</form>
<form method="post" action={"/oo/import/"|ezurl}>
  <input type="hidden" name="ImportType" value="replace" />
  <input type="hidden" name="NodeID" value="{$node.node_id}" />
  <input type="hidden" name="ObjectID" value="{$content_object.id}" />
  <input class="button" type="submit" name="ReplaceAction" value="{'Replace'|i18n('design/standard/node/view')}" />
</form>
{/if}

<a href="http://ez.no/doc"><img src={"ezt_question_mark.gif"|ezimage} alt="Help" {if $disable_oo|not}class="oohelp"{else}class="help"{/if}/></a>

</div>
</div>

</div></div></div></div></div>
</div>

{else}
{set-block variable=$isset_toolbar scope='root'}
    {false()}
{/set-block}
{/if}