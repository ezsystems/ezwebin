<div class="view-embed">
    <div class="content-media">
    {let attribute=$object.data_map.file}
        <object width="{$attribute.content.width}" height="{$attribute.content.height}">
        <param name="movie" value={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl} />
        <param name="controller" value="{cond( $attribute.content.has_controller, 'true', 'false' )}" />
        <param name="autostart" value="{cond( $attribute.content.is_autoplay, 'true', 'false' )}" />
        <param name="loop" value="{cond( $attribute.content.is_loop, 'true', 'false' )}" />
        <embed src={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl}
               pluginspage="{$attribute.content.pluginspage}"
               width="{$attribute.content.width}" height="{$attribute.content.height}" play="{section show=$attribute.content.is_autoplay}true{/section}"
               loop="{section show=$attribute.content.is_loop}true{/section}" controller="{section show=$attribute.content.has_controller}true{/section}" >
        </embed>
        </object>
    {/let}
    </div>
</div>
