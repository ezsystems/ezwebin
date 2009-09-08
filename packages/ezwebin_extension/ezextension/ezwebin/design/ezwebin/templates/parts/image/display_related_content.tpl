<div class="attribute-relatedcontent">
    <h1>{"Related content"|i18n("design/ezwebin/full/image")}</h1>
    {def $filters = ezini( 'gallerythumbnail', 'Filters', 'image.ini' )}
    
     {foreach $filters as $filter}
        {if or($filter|contains( "geometry/scale" ), $filter|contains( "geometry/scaledownonly" ), $filter|contains( "geometry/crop" ) )}
           {def $image_style = $filter|explode("=").1}
           {set $image_style = concat("width:", $image_style|explode(";").0, "px ;", "height:", $image_style|explode(";").1, "px")}
           {break}
        {/if}
     {/foreach}

    {foreach $related_content|reverse() as $related_object max 7}
        {node_view_gui view=galleryline content_node=$related_object.object.main_node}
    {/foreach}
</div>