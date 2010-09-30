{* Image - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-image">

        <div class="attribute-header">
            <h1>{$node.name|wash()}</h1>
        </div>

        {if is_unset( $versionview_mode )}
        <div class="content-navigator">
            {* NOTE: Remember to modify gallery.tpl and templates for classes listed in class_filter_array if filters / sort_by is changed! *}
            {def $node_id  = $node.node_id
                 $parent   = $node.parent
                 $siblings = fetch( 'content', 'list', hash( 'parent_node_id', $parent.node_id,
                                                             'as_object', false(),
                                                             'class_filter_type', 'include',
                                                             'class_filter_array', array( 'image', 'flash_player' ),
                                                             'sort_by', $parent.sort_array ) )
                 $prev_node_id = 0
                 $next_node_id = 0}

            {* Figgure out current position and hence prev and next as well *}
            {foreach $siblings as $index => $sibling}
                {if $sibling['node_id']|eq( $node_id )}
                     {if is_set( $siblings[ $index|inc ] )}
                         {set $next_node_id = $siblings[ $index|inc ]['node_id']}
                     {/if}
                    {break}
                {/if}
                {set $prev_node_id = $sibling['node_id']}
            {/foreach}

            {if $prev_node_id}
                {def $prev_node = fetch('content', 'node', hash( 'node_id', $prev_node_id ))}
                <div class="content-navigator-previous">
                    <div class="content-navigator-arrow">&laquo;&nbsp;</div><a href={$prev_node.url_alias|ezurl} title="{$prev_node.name|wash}">{'Previous image'|i18n( 'design/ezwebin/full/image' )}</a>
                </div>
                <div class="content-navigator-separator">|</div>
            {else}
                <div class="content-navigator-previous-disabled">
                    <div class="content-navigator-arrow">&laquo;&nbsp;</div>{'Previous image'|i18n( 'design/ezwebin/full/image' )}
                </div>
                <div class="content-navigator-separator-disabled">|</div>
            {/if}

            <div class="content-navigator-forum-link"><a href={$parent.url_alias|ezurl}>{$parent.name|wash}</a></div>

            {if $next_node_id}
                <div class="content-navigator-separator">|</div>
                {def $next_node = fetch('content', 'node', hash( 'node_id', $next_node_id ))}
                <div class="content-navigator-next">
                    <a href={$next_node.url_alias|ezurl} title="{$next_node.name|wash}">{'Next image'|i18n( 'design/ezwebin/full/image' )}</a><div class="content-navigator-arrow">&nbsp;&raquo;</div>
                </div>
            {else}
                <div class="content-navigator-separator-disabled">|</div>
                <div class="content-navigator-next-disabled">
                    {'Next image'|i18n( 'design/ezwebin/full/image' )}<div class="content-navigator-arrow">&nbsp;&raquo;</div>
                </div>
            {/if}
            {undef $siblings $parent $node_id $prev_node_id $next_node_id}
        </div>
        {/if}

        <div class="attribute-image">
            <p>{attribute_view_gui attribute=$node.data_map.image image_class=imagelarge}</p>
        </div>

        <div class="attribute-caption">
            {attribute_view_gui attribute=$node.data_map.caption}
        </div>

        {include uri='design:parts/image/related_content.tpl'}

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>