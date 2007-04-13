<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-{$node.object.class_identifier}">
    
    <div class="attribute-header">
        <h1>{$node.name|wash()}</h1>
    </div>

    {def $name_pattern = $node.object.content_class.contentobject_name|explode('>')|implode(',')
         $name_pattern_array = array('show_children', 'show_children_classes', 'show_children_pr_page', 'enable_comments')}
    {set $name_pattern  = $name_pattern|explode('|')|implode(',')}
    {set $name_pattern  = $name_pattern|explode('<')|implode(',')}
    {set $name_pattern  = $name_pattern|explode(',')}
    {foreach $name_pattern  as $name_pattern_string}
        {set $name_pattern_array = $name_pattern_array|append( $name_pattern_string|trim() )}
    {/foreach}

    {foreach $node.object.contentobject_attributes as $attribute}
        {if $name_pattern_array|contains($attribute.contentclass_attribute_identifier)|not()}
            <div class="attribute-{$attribute.contentclass_attribute_identifier}">
                {attribute_view_gui attribute=$attribute}
            </div>
        {/if}
    {/foreach}
    
    
    {* TODO: Show children and comments if attributes are present and enabled *}

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>