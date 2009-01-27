{def $size = "original"
     $alternative_text = $object.data_map.name.content}

{if is_set( $object_parameters.size )}
    {set $size = $object_parameters.size}
{/if}

{if is_set( $object.data_map.image.content[$size].alternative_text )}
    {set $alternative_text = $object.data_map.image.content[$size].alternative_text}
{/if}

<div class="content-view-embed">
<div class="class-banner">
{if eq( $object.data_map.image_map.content, true() )}
    <img usemap="#banner_map" src={$object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$object.data_map.image.content[$size].width}" height="{$object.data_map.image.content[$size].height}" />
    {$object.data_map.image_map.content}
{else}
    {if $object.data_map.url.content}
        <a href={$object.data_map.url.content|ezurl}>
            <img src={$object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$object.data_map.image.content[$size].width}" height="{$object.data_map.image.content[$size].height}" />
        </a>
    {else}
        <img src={$object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" width="{$object.data_map.image.content[$size].width}" height="{$object.data_map.image.content[$size].height}" />
    {/if}
{/if}
</div>
</div>