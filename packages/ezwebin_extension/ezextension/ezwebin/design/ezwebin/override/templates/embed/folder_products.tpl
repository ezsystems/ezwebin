<div class="content-view-embed">
    <div class="class-folder"> {def $children=fetch( content, tree, hash( parent_node_id, $object.main_node_id, 
                                                                          limit, 3, 
                                                                          sort_by, array( 'published' , false() ),
                                                                          class_filter_type, include,
                                                                          class_filter_array, array( 'product' ) ) )}
        <h2>{$object.name|wash()}</h2>
        <div class="split">
            <div class="three-left">
                <div class="split-content">
                    <!-- Content: START -->
                    {node_view_gui view=productitem content_node=$children.0}
                    <!-- Content: END -->
                </div>
            </div>
            <div class="three-right">
                <div class="split-content">
                    <!-- Content: START -->
                    {node_view_gui view=productitem content_node=$children.1}
                    <!-- Content: END -->
                </div>
            </div>
            <div class="three-center">
                <div class="split-content">
                    <!-- Content: START -->
                    {node_view_gui view=productitem content_node=$children.2}
                    <!-- Content: END -->
                </div>
            </div>
            <div class="break"></div>
        </div>
    </div>
</div>