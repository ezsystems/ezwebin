{* Link - Line view *}

<div class="content-view-line">
    <div class="class-link">

    <h2>{$node.name|wash}</h2>

    {if $node.data_map.description.has_content}
        <div class="attribute-long">
            {attribute_view_gui attribute=$node.data_map.description}
        </div>
    {/if}

    {if $node.data_map.location.has_content}
        <div class="attribute-link">
            <p><a href="{$node.data_map.location.content}" target="_blank">{if $node.data_map.location.data_text|count|gt( 0 )}{$node.data_map.location.data_text|wash}{else}{$node.data_map.location.content|wash}{/if}</a></p>
        </div>
    {/if}

    {if or( $node.object.can_edit, $node.object.can_remove)}
    <div class="controls">
        <form action={"/content/action"|ezurl} method="post">
        {if $node.object.can_edit}
            <input type="image" name="EditButton" src={"edit.gif"|ezimage} alt="Edit" />
            <input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}" />
        {/if}
                 
        {if $node.object.can_remove}
            <input type="image" name="ActionRemove" src={"trash.gif"|ezimage} alt="Remove" />
        {/if}
            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
              <input type="hidden" name="NodeID" value="{$node.node_id}" />
              <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
        </form>
    </div>
    {/if}

    </div>
</div>