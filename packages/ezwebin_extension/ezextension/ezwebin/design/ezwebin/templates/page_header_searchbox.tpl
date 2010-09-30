<div id="searchbox">
  <form action={"/content/search"|ezurl}>
  <div id="searchbox-inner">
    <label for="searchtext" class="hide">{'Search text:'|i18n('design/ezwebin/pagelayout')}</label>
    {if $pagedata.is_edit}
    <input id="searchtext" name="SearchText" type="text" value="" size="12" disabled="disabled" />
    <input id="searchbutton" class="button-disabled" type="submit" value="{'Search'|i18n('design/ezwebin/pagelayout')}" title="{'Search'|i18n('design/ezwebin/pagelayout')}" disabled="disabled" />
    {else}
    <input id="searchtext" name="SearchText" type="text" value="" size="12" />
    <input id="searchbutton" class="button" type="submit" value="{'Search'|i18n('design/ezwebin/pagelayout')}" title="{'Search'|i18n('design/ezwebin/pagelayout')}" />
        {if eq( $ui_context, 'browse' )}
         <input name="Mode" type="hidden" value="browse" />
        {/if}
    {/if}
  </div>
  </form>
</div>