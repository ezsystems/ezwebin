  <!-- Footer area: START -->
  <div id="footer">
    <address>
    {if $pagedesign.data_map.hide_powered_by.data_int|not}
        Powered by <a href="http://ez.no/ezpublish" title="eZ Publish&#8482; CMS Open Source Web Content Management">eZ Publish&#8482; CMS Open Source Web Content Management</a>. 
    {/if}
    {if $pagedesign.data_map.footer_text.has_content}
        {$pagedesign.data_map.footer_text.content} 
    {/if}
    </address>
  </div>
  <!-- Footer area: END -->
