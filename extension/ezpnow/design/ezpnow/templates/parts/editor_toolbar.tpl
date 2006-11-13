{def $current_node = fetch( 'content', 'node', hash( 'node_id', $module_result.node_id ) )
	 $content_object = $current_node.object
	 $can_edit_languages   = $content_object.can_edit_languages
     $can_create_languages = $content_object.can_create_languages
	 $available_for_classes = ezini( 'EditorToolbarSettings', 'AvailableForClasses', 'editortoolbar.ini' )
	 $containers = ezini( 'EditorToolbarSettings', 'Containers', 'editortoolbar.ini' )}

{if and( $current_user.is_logged_in, or( $current_user.groups|contains(13), $current_user.groups|contains(12) ), $available_for_classes|contains( $current_node.class_identifier ) )}

<div class="box-et {if eq( $current_node.class_identifier, 'frontpage' )}frontpage-et{/if}">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">


<div class="block">
<div class="left">
<form method="post" action={"content/action"|ezurl}>
<a href={"/ezinfo/about"|ezurl}><img src={"ez_toolbar.png"|ezimage} alt="eZ publish Now" width="49" height="16" /></a>
{if and( $content_object.can_create,$containers|contains( $current_node.class_identifier ) )}
  <select name="ClassID">
  {foreach $content_object.can_create_class_list as $class}
	<option value="{$class.id}">{$class.name|wash}</option>
  {/foreach}
  </select>
  <input type="hidden" name="ContentLanguageCode" value="{$content_object.initial_language_code}" />
  <input class="button" type="submit" name="NewButton" value="{'Create'|i18n('design/standard/node/view')}" />
{/if}

{if $content_object.can_edit}
	<input type="hidden" name="ContentObjectLanguageCode" value="{ezini( 'RegionalSettings', 'Locale' , 'site.ini')}" />
  <input class="button" type="submit" name="EditButton" value="{'Edit'|i18n('design/standard/node/view')}" />
{/if}

{if $content_object.can_move}
  <input class="button" type="submit" name="MoveNodeButton" value="{'Move'|i18n('design/admin/node/view/full')}" />
{/if}

{if $content_object.can_remove}
   <input class="button" type="submit" name="ActionRemove" value="{'Remove'|i18n('design/standard/node/view')}" />
{/if}

  <input type="hidden" name="ContentObjectID" value="{$content_object.id}" />
  <input type="hidden" name="NodeID" value="{$current_node.node_id}" />
  <input type="hidden" name="ContentNodeID" value="{$current_node.node_id}" />
</form>
</div>

<div class="right">

{def $disable_oo=true()}

{if array( 'documentation_page', 'folder', 'article', 'event' )|contains( $current_node.class_identifier )}
	{set $disable_oo=false()}
{/if}

{if $disable_oo|not}
<img src={"oo_logo.gif"|ezimage} alt="OpenOffice Integration" width="49" height="18" />

{if and( $content_object.content_class.is_container, ne( $content_object.content_class.identifier, 'article' ) )}
{* Import OOo / OASIS document *}
<form method="post" action={"/oo/import/"|ezurl}>
  <input type="hidden" name="NodeID" value="{$current_node.node_id}" />
  <input type="hidden" name="ObjectID" value="{$content_object.id}" />
  <input class="button" type="submit" name="ImportAction" value="{'Import'|i18n('extension/ezodf')}" />
</form>
{/if}
<form method="post" action={"/oo/export/"|ezurl}>
  <input type="hidden" name="NodeID" value="{$current_node.node_id}" />
  <input type="hidden" name="ObjectID" value="{$content_object.id}" />
  <input class="button" type="submit" name="ExportAction" value="{'Export'|i18n('extension/ezodf')}" />
</form>
<form method="post" action={"/oo/import/"|ezurl}>
  <input type="hidden" name="ImportType" value="replace" />
  <input type="hidden" name="NodeID" value="{$current_node.node_id}" />
  <input type="hidden" name="ObjectID" value="{$content_object.id}" />
  <input class="button" type="submit" name="ReplaceAction" value="{'Replace'|i18n('extension/ezodf')}" />
</form>
{/if}

<a href="http://ez.no/doc" title="Documentation"><img src={"ezt_question_mark.gif"|ezimage} alt="Help" {if $disable_oo|not}class="oohelp"{else}class="help"{/if} /></a>

</div>
</div>

</div></div></div></div></div>
</div>

{/if}