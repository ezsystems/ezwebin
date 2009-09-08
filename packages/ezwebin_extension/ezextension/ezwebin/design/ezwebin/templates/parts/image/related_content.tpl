{def $related_content = $node.data_map.tags.content.related_objects}

{if $related_content}
    {include uri='design:parts/image/display_related_content.tpl'}
{/if}

{undef $related_content}