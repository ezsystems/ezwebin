  <!-- Footer area: START -->
  <div id="footer">
    <address>
    {if $pagedesign.data_map.footer_text.has_content}
        {$pagedesign.data_map.footer_text.content} 
    {/if}
    {if $pagedesign.data_map.hide_powered_by.data_int|not}
    Powered by <a href="http://ez.no" title="eZ Publish Content Management System">eZ Publish&#8482;</a> Content Management System.
    {/if}
    </address>
  </div>
  <!-- Footer area: END -->
