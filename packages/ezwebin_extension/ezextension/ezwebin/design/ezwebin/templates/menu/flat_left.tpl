<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">
{def $left_menu_depth = $pagedata.current_menu|eq('LeftOnly')|choose( 1, 0 )
     $left_menu_root_url = cond( $pagedata.path_array[$left_menu_depth].url_alias, $pagedata.path_array[$left_menu_depth].url_alias, $requested_uri_string )}

    <h4><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $pagedata.path_array[$left_menu_depth].node_id)|ezurl}{else}{$left_menu_root_url|ezurl}{/if}>{$pagedata.path_array[$left_menu_depth].text}</a></h4>

{if ne( $pagedata.class_identifier, 'documentation_page' )}
    {def $root_node=fetch( 'content', 'node', hash( 'node_id', $pagedata.path_array[$left_menu_depth].node_id ) )
         $left_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                                            'sort_by', $root_node.sort_array,
                                                            'load_data_map', false(),
                                                            'class_filter_type', 'include',
                                                            'class_filter_array', ezini( 'MenuContentSettings', 'LeftIdentifierList', 'menu.ini' ) ) )
         $left_menu_items_count = $left_menu_items|count()
         $li_class = array()
         $a_class = array()
         $current_node_in_path_2 = first_set( $pagedata.path_array[$left_menu_depth|inc].node_id,  0 )
         $current_node_in_path_3 = first_set( $pagedata.path_array[$left_menu_depth|sum(2)].node_id,  0 )}

    {if $left_menu_items_count}
        <ul class="menu-list">
        {foreach $left_menu_items as $key => $item}
            {set $a_class = cond($current_node_in_path_2|eq($item.node_id), array("selected"), array())
                 $li_class = cond( $key|eq(0), array("firstli"), array() )}

            {if $left_menu_items_count|eq( $key|inc )}
                {set $li_class = $li_class|append("lastli")}
            {/if}
            {if $item.node_id|eq( $current_node_id )}
                {set $a_class = $a_class|append("current")}
            {/if}
            {if eq( $item.class_identifier, 'link')}
                <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><div class="second_level_menu"><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $item.node_id)|ezurl}{else}href={$item.data_map.location.content|ezurl}{if and( is_set( $item.data_map.open_in_new_window ), $item.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if} title="{$item.data_map.location.data_text|wash}" class="menu-item-link" rel={$item.url_alias|ezurl}>{if $item.data_map.location.data_text}{$item.data_map.location.data_text|wash()}{else}{$item.name|wash()}{/if}</a></div>
            {else}
                <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><div class="second_level_menu"><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{$item.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>{$item.name|wash()}</a></div>
            {/if}

            {if eq( $current_node_in_path_2, $item.node_id )}
                {def $sub_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $item.node_id,
                                                                      'sort_by', $item.sort_array,
                                                                      'load_data_map', false(),
                                                                      'class_filter_type', 'include',
                                                                      'class_filter_array', ezini( 'MenuContentSettings', 'LeftIdentifierList', 'menu.ini' ) ) )
                     $sub_menu_items_count = $sub_menu_items|count}
                {if $sub_menu_items_count}
                <ul class="submenu-list">
                    {foreach $sub_menu_items as $subkey => $subitem}
                       {set $a_class = cond($current_node_in_path_3|eq($subitem.node_id), array("selected"), array())
                         $li_class = cond( $subkey|eq(0), array("firstli"), array() )}
                    {if $sub_menu_items_count|eq( $subkey|inc )}
                        {set $li_class = $li_class|append("lastli")}
                    {/if}
                    {if $subitem.node_id|eq( $current_node_id )}
                        {set $a_class = $a_class|append("current")}
                    {/if}
                    {if eq( $subitem.class_identifier, 'link')}
                        <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><div class="third_level_menu"><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $subitem.node_id)|ezurl}{else}href={$subitem.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if} title="{$subitem.data_map.location.data_text|wash}" class="menu-item-link" rel={$subitem.url_alias|ezurl}>{if $subitem.data_map.location.data_text}{$subitem.data_map.location.data_text|wash()}{else}{$subitem.name|wash()}{/if}</a></div></li>
                    {else}
                        <li{if $li_class} class="{$li_class|implode(" ")}"{/if}><div class="third_level_menu"><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $a_class} class="{$a_class|implode(" ")}"{/if}>{$subitem.name|wash()}</a></div></li>
                    {/if}
                    {/foreach}
                </ul>
                {/if}
            {undef $sub_menu_items $sub_menu_items_count}
            {/if}
            </li>
        {/foreach}
        </ul>
    {/if}
    {undef $root_node $left_menu_items $left_menu_items_count $a_class $li_class $current_node_in_path_2 $current_node_in_path_3}
{else}

    <div class="contentstructure">
    {def $current_node         = fetch( content, node, hash( node_id, $current_node_id ) )
         $chapter_container    = fetch( content, node, hash( node_id, $current_node.path_array[$left_menu_depth|inc] ) )
         $class_filter         = ezini( 'TreeMenu', 'ShowClasses', 'contentstructuremenu.ini' )
         $depth                = is_set( $current_node.path_array[$left_menu_depth|sum(2)] )|choose( $left_menu_depth|sum(3), 0 )
         $node_to_unfold       = is_set( $current_node.path_array[$left_menu_depth|sum(2)] )|choose(0 , $current_node.path_array[$left_menu_depth|sum(2)] )
         $contentStructureTree = content_structure_tree( $chapter_container.node_id, $class_filter, $depth, 0, 'false', false(), $node_to_unfold )}

    {include uri='design:simplified_treemenu/show_simplified_menu.tpl' contentStructureTree=$contentStructureTree is_root_node=true() skip_self_node=true() current_node_id=$current_node_id unfold_node=$node_to_unfold chapter_level=0}

    {undef $current_node $chapter_container $class_filter $depth $node_to_unfold $contentStructureTree}
    </div>
{/if}

{undef $left_menu_root_url $left_menu_depth}

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
