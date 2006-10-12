{* Flash - Full view *}

{include uri='design:parts/editor_toolbar.tpl'}

<div class="box-mc">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-view-full">
    <div class="class-flash">

	<div class="attribute-header">
    	<h1>{$node.name|wash()}</h1>
	<div>

    <div class="attribute-short">
        {attribute_view_gui attribute=$node.data_map.description}
    </div>

    <div class="content-media">
    {def $attribute=$node.data_map.file}
        <object codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0"
                {section show=$attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/section} {section show=$attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/section} id="objectid{$node.object.id}">

        <param name="movie" value={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl} />
        <param name="quality" value="{$attribute.content.quality}" />
        <param name="play" value="{section show=$attribute.content.is_autoplay}true{/section}" />
        <param name="loop" value="{section show=$attribute.content.is_loop}true{/section}" />
        <embed src={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl}
               type="application/x-shockwave-flash"
               quality="{$attribute.content.quality}" pluginspage="{$attribute.content.pluginspage}"
               {section show=$attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/section} {section show=$attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/section} play="{section show=$attribute.content.is_autoplay}true{/section}"
               loop="{section show=$attribute.content.is_loop}true{/section}" name="objectid{$node.object.id}">
        </embed>
        </object>
    </div>

    </div>
</div>

</div></div></div></div></div>
</div>