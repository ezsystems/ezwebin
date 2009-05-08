{if $content_object.allowed_assign_state_list|count}
    <a href={concat( "/state/assign/", $content_object.id )|ezurl} title="{'Edit object states'|i18n( 'design/standard/parts/website_toolbar' )}"><img src={"websitetoolbar/ezwt-icon-objectstates.gif"|ezimage()} alt="{'Edit object states'|i18n( 'design/standard/parts/website_toolbar' )}" /></a>
{/if}