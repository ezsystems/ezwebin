<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="class-silverlight">

    <div class="attribute-header">
        <h1>{$node.name|wash()}</h1>
    </div>

    <div class="attribute-long">
        {attribute_view_gui attribute=$node.data_map.description}
    </div>

    {def $attribute = $node.data_map.file
         $width = '1'
	 $height = '1'}

    {if $attribute.content.width|gt( 0 )}
        {set $width = $attribute.content.width}
    {/if}

    {if $attribute.content.height|gt( 0 )}
        {set $height = $attribute.content.height}
    {/if}

    {literal}
    <script type="text/javascript">
        function onErrorHandler(sender, args) { };

        function onLoadHandler(sender, args) { };

        function onResizeHandler(sender, args) {
            var slPlugin = sender.getHost();
            slPlugin.width = sender.content.actualWidth;
            slPlugin.height = sender.content.actualHeight; 
        };
    </script>
    {/literal}

    <div id="silverlightControlHost">
      <!-- Silverlight plug-in control -->
        <object data="data:application/x-silverlight," type="application/x-silverlight-2-b2" width="{$width}" height="{$height}">
            <param name="source" value="{concat( "content/download/", $attribute.contentobject_id, "/", $attribute.content.contentobject_attribute_id, "/", $attribute.content.original_filename)|ezurl( 'no' )}" />
            <param name="onError" value="onErrorHandler" />
            <param name="onLoad" value="onLoadHandler" />
            <param name="onResize" value="onResizeHandler" />
            <a href="http://go2.microsoft.com/fwlink/?LinkId=108181" style="text-decoration: none;">
                <img src="http://go2.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none;" />
            </a>
        </object>
        <iframe style="visibility: hidden; height: 0; width: 0; border: 0px;"></iframe>
    </div>

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
