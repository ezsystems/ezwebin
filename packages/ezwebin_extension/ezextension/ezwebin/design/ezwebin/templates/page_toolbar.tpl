  <div id="toolbar">
  {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
  {include uri='design:parts/website_toolbar.tpl'}
  {/if}
  </div>