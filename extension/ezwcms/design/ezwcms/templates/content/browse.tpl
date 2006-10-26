<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

{let item_type=ezpreference( 'admin_list_limit' )
     number_of_items=min( $item_type, 3)|choose( 10, 10, 25, 50 )
     browse_list_count=fetch( content, list_count, hash( parent_node_id, $node_id, depth, 1))
     node_array=fetch( content, list, hash( parent_node_id, $node_id, depth, 1, offset, $view_parameters.offset, limit, $number_of_items, sort_by, $main_node.sort_array ) )
     select_name='SelectedObjectIDArray'
     select_type='checkbox'
     select_attribute='contentobject_id'}

{section show=eq($browse.return_type,'NodeID')}
    {set select_name='SelectedNodeIDArray'}
    {set select_attribute='node_id'}
{/section}
{section show=eq($browse.selection,'single')}
    {set select_type='radio'}
{/section}

<form action={concat($browse.from_page)|ezurl} method="post">

{section show=$browse.description_template}
    {include name=Description uri=$browse.description_template browse=$browse main_node=$main_node}
{section-else}
    <div class="attribute-header">
    <h1 class="long">{"Browse"|i18n("design/standard/content/browse")} - {$main_node.name|wash}</h1>
    </div>

    <p>{'To select objects, choose the appropriate radiobutton or checkbox(es), and click the "Select" button.'|i18n("design/standard/content/browse")}</p>
    <p>{'To select an object that is a child of one of the displayed objects, click the object name and you will get a list of the children of the object.'|i18n("design/standard/content/browse")}</p>
{/section}

{let current_node=fetch( content, node, hash( node_id, $browse.start_node ) )}
{section show=$browse.start_node|gt( 1 )}
    <h2 class="context-title">
    <a href={concat( '/content/browse/', $main_node.parent_node_id, '/' )|ezurl}><img src={'back-button-16x16.gif'|ezimage} alt="{'Back'|i18n( 'design/admin/content/browse' )}" /></a>
    {$current_node.name|wash}&nbsp;[{$current_node.children_count}]</h2>
{section-else}
    <h2 class="context-title"><img src={'back-button-16x16.gif'|ezimage} alt="Back" />&nbsp;{'Top level'|i18n( 'design/admin/content/browse' )}&nbsp;[{$current_node.children_count}]</h2>
{/section}
{/let}

{include uri='design:content/browse_mode_list.tpl'}

{include name=Navigator
         uri='design:navigator/google.tpl'
         page_uri=concat('/content/browse/',$main_node.node_id)
         item_count=$browse_list_count
         view_parameters=$view_parameters
         item_limit=$page_limit}


{section name=Persistent show=$browse.persistent_data loop=$browse.persistent_data}
    <input type="hidden" name="{$:key|wash}" value="{$:item|wash}" />
{/section}

<input type="hidden" name="BrowseActionName" value="{$browse.action_name}" />
{section show=$browse.browse_custom_action}
<input type="hidden" name="{$browse.browse_custom_action.name}" value="{$browse.browse_custom_action.value}" />
{/section}

        <input class="button" type="submit" name="SelectButton" value="{'Select'|i18n('design/standard/content/browse')}" />


{section show=$cancel_action}
<input type="hidden" name="BrowseCancelURI" value="{$cancel_action}" />
{/section}
 <input class="button" type="submit" name="BrowseCancelButton" value="{'Cancel'|i18n( 'design/standard/content/browse' )}" />
</form>

{/let}
</div></div></div></div></div>
</div>
