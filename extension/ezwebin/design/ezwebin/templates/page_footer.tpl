  <!-- Footer area: START -->
  <div id="footer">
    <address>
    {if $pagedesign.data_map.footer_text.has_content}
        {$pagedesign.data_map.footer_text.content} 
    {/if}
    <br />
    {if $pagedesign.data_map.hide_powered_by.data_int|not}
    Powered by <a href={"ezinfo/about"|ezurl()} title="eZ Publish Content Management System">eZ Publish&#8482;</a> Content Management System.
    {/if}
    </address>
  </div>
  <!-- Footer area: END -->
