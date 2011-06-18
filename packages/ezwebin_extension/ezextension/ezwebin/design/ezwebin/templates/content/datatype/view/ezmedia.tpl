{if $attribute.content.filename}

    {switch name=mediaType match=$attribute.contentclass_attribute.data_text1}
    {case match=flash}
    <script type="text/javascript">
        insertMedia( '<object type="application/x-shockwave-flash" data={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl} {if $attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/if} {if $attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/if}>', '<param name="movie" value={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl} />', '<param name="loop" value="{if $attribute.content.is_loop}true{/if}" />', '<param name="play" value="{if $attribute.content.is_autoplay}true{/if}" />', '<param name="quality" value="{$attribute.content.quality}" />', '<p>No <a href="http://www.macromedia.com/go/getflashplayer">Flash player<\/a> avaliable!<\/p>', '<\/object>' );
    </script>
    <noscript>
    <object type="application/x-shockwave-flash" data={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl} {if $attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/if} {if $attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/if}>
        <param name="movie" value={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl} />
        <param name="quality" value="{$attribute.content.quality}" />
        <param name="play" value="{if $attribute.content.is_autoplay}true{/if}" />
        <param name="loop" value="{if $attribute.content.is_loop}true{/if}" />
        <p>{'No %link_startFlash player%link_end avaliable!'|i18n( 'design/ezwebin/view/ezmedia', , hash( '%link_start', '<a href="http://www.macromedia.com/go/getflashplayer">', '%link_end', '</a>' ) )}</p>
    </object>
    </noscript>
    {/case}

    {case match=quick_time}
    <object
        {if $attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/if}
        {if $attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/if}>
        <param name="movie" value={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl} />
        <param name="controller" value="{if $attribute.content.has_controller}true{/if}" />
        <param name="play" value="{if $attribute.content.is_autoplay}true{/if}" />
        <param name="loop" value="{if $attribute.content.is_loop}true{/if}" />
        <embed src={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl}
               type="video/quicktime"
               pluginspage="{$attribute.content.pluginspage}"
               {if $attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/if}
               {if $attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/if}
               play="{if $attribute.content.is_autoplay}true{/if}"
               loop="{if $attribute.content.is_loop}true{/if}" controller="{if $attribute.content.has_controller}true{/if}" >
        </embed>
    </object>
    {/case}

    {case match=windows_media_player}
    <object ID="MediaPlayer"  CLASSID="CLSID:6BF52A52-394A-11D3-B153-00C04F79FAA6" STANDBY="Loading Windows Media Player components..." type="application/x-oleobject"
            {if $attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/if}
            {if $attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/if}>
        <param name="filename" value={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl} />
        <param name="autostart" value="{$attribute.content.is_autoplay}" />
        <param name="showcontrols" value="{$attribute.content.has_controller}" />
        <embed src={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl}
               type="application/x-mplayer2" pluginspage="{$attribute.content.pluginspage}"
               {if $attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/if}
               {if $attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/if}
               autostart="{$attribute.content.is_autoplay}"
               showcontrols="{$attribute.content.has_controller}" >
        </embed>
    </object>
    {/case}

    {case match=real_player}
    <object classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA"
            {if $attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/if}
            {if $attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/if}>
        <param name="src" value={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl} />
        <param name="controls" value="{$attribute.content.controls}" />
        <param name="autostart" value="{if $attribute.content.is_autoplay}true{/if}" />
        <embed src={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl}
               pluginspage="{$attribute.content.pluginspage}"
               {if $attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/if}
               {if $attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/if}
               autostart="{if $attribute.content.is_autoplay}true{/if}"
               controls="{$attribute.content.controls}" >
        </embed>
    </object>
    {/case}

    {case match=silverlight}
    {literal}
    <script type="text/javascript">
        function onErrorHandler(sender, args) { }
        function onResizeHandler(sender, args) { }
    </script>
    {/literal}
    <div id="silverlightControlHost">
      <!-- Silverlight plug-in control -->
        <object data="data:application/x-silverlight," type="application/x-silverlight-2-b1" {if $attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/if} {if $attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/if}>
            <param name="source" value="{concat( "content/download/", $attribute.contentobject_id, "/", $attribute.content.contentobject_attribute_id, "/", $attribute.content.original_filename)|ezurl( 'no' )}" />
            <param name="onError" value="onErrorHandler" />
            <param name="onResize" value="onResizeHandler" />
            <a href="http://go.microsoft.com/fwlink/?LinkID=108182" style="text-decoration: none;">
                <img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none;" />
            </a>
        </object>
        <iframe style="visibility: hidden; height: 0; width: 0; border: 0px;"></iframe>
    </div>
    {/case}

    {case match=html5_video}
    <video src={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl}
               {if $attribute.content.width|gt( 0 )}width="{$attribute.content.width}"{/if}
               {if $attribute.content.height|gt( 0 )}height="{$attribute.content.height}"{/if}
               {if $attribute.content.is_autoplay}autoplay="autoplay"{/if}
               {if $attribute.content.is_loop}loop="loop"{/if}
               {if $attribute.content.has_controller}controls="controls"{/if}
               preload="none">
        {'Your browser does not support html5 video.'|i18n( 'design/ezwebin/view/ezmedia' )}
    </video>
    {/case}

    {case match=html5_audio}
    <audio src={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl}
               {if $attribute.content.is_autoplay}autoplay="autoplay"{/if}
               {if $attribute.content.is_loop}loop="loop"{/if}
               {if $attribute.content.has_controller}controls="controls"{/if}
               preload="none">
        {'Your browser does not support html5 audio.'|i18n( 'design/ezwebin/view/ezmedia' )}
    </audio>
    {/case}
    {/switch}

{else}
    {'No media file is available.'|i18n( 'design/ezwebin/view/ezmedia' )}
{/if}