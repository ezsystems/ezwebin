{def $size = "billboard"
     $alternative_text = $object.data_map.name.content}

{if is_set( $object.data_map.image.content[$size].alternative_text )}
    {set $alternative_text = $object.data_map.image.content[$size].alternative_text}
{/if}

{if is_set( $object.data_map.image )}
    {if and( is_set( $object.data_map.url ), $object.data_map.url.content )}
        <a href={$object.data_map.url.content|ezurl}>
            <img src={$object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$object.data_map.image.content[$size].width}" height="{$object.data_map.image.content[$size].height}" />
        </a>
    {else}
        <img src={$object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$object.data_map.image.content[$size].width}" height="{$object.data_map.image.content[$size].height}" />
    {/if}
{else}
    {content_view_gui content_object=$object view=embed}
{/if}