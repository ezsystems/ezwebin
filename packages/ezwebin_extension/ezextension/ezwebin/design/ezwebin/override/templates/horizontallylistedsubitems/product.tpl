{* Product - Horizontally Listed Subitems view *}

<div class="content-view-horizontallylistedsubitems">
    <div class="class-product">

    {section show=$node.data_map.image.content}
        <div class="attribute-image">
            {attribute_view_gui alignment=right image_class=listitem attribute=$node.data_map.image}
        </div>
    {/section}
    
        <h2><a href={$node.url_alias|ezurl}>{$node.name|wash()}</a></h2>
    
        <div class="attribute-price">
          <p>
           {attribute_view_gui attribute=$node.object.data_map.price}
          </p>
        </div>

   </div>
</div>