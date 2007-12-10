{* Infobox - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-infobox">

        <div class="attribute-header">
            <h1>{attribute_view_gui attribute=$node.object.data_map.header}</h1>
        </div>
        
        <div class="attribute-image">
            {attribute_view_gui attribute=$node.object.data_map.image image_class='infoboximage'}
        </div>
        
        <div class="attribute-content">
            {attribute_view_gui attribute=$node.object.data_map.content}
        </div>
        
        <div class="attribute-link">
            {attribute_view_gui attribute=$node.object.data_map.url}
        </div>

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>