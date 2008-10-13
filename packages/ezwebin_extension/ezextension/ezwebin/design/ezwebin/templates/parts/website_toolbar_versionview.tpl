{def $custom_templates = ezini( 'CustomTemplateSettings', 'CustomTemplateList', 'websitetoolbar.ini' )
     $include_in_view = ezini( 'CustomTemplateSettings', 'IncludeInView', 'websitetoolbar.ini' )}

<!-- eZ website toolbar: START -->

<div id="ezwt">
<div class="tl"><div class="tr"><div class="tc"></div></div></div>
<div class="mc"><div class="ml"><div class="mr float-break">

<!-- eZ website toolbar content: START -->

<div id="ezwt-ezlogo">
<a href={"/ezinfo/about"|ezurl} title="{'About'|i18n('design/ezwebin/parts/website_toolbar')}" target="_blank"><img src={"websitetoolbar/ezwt-logo.gif"|ezimage} width="50" height="16" alt="eZ" /></a>
</div>

<div id="ezwt-standardactions">
<form method="post" action={concat( 'content/versionview/', $object.id, '/', $version.version, '/', $language, '/', $from_language )|ezurl} class="left">

{if $object.versions|count|gt( 1 )}
<input type="image" src={"websitetoolbar/ezwt-icon-versions.gif"|ezimage} name="VersionsButton" title="{'Manage versions'|i18n('design/ezwebin/content/view/versionview')}" /> 
{else}
<input disabled="disabled" type="image" src={"websitetoolbar/ezwt-icon-versions-disabled.gif"|ezimage} name="VersionsButton" title="{'Manage versions'|i18n('design/ezwebin/content/view/versionview')}" /> 
{/if}

{if or( and( eq( $version.status, 0 ), $is_creator, $object.can_edit ),
                  and( eq( $object.status, 2 ), $object.can_edit ) )}
<input type="image" src={"websitetoolbar/ezwt-icon-edit.gif"|ezimage} name="EditButton" title="{'Edit'|i18n( 'design/ezwebin/content/view/versionview' )}" />
<input type="image" src={"websitetoolbar/ezwt-icon-publish.gif"|ezimage} name="PreviewPublishButton" title="{'Publish'|i18n( 'design/ezwebin/content/view/versionview' )}" />
{else}
<input disabled="disabled" type="image" src={"websitetoolbar/ezwt-icon-edit-disabled.gif"|ezimage} name="EditButton" title="{'Edit'|i18n( 'design/ezwebin/content/view/versionview' )}" />
<input disabled="disabled" type="image" src={"websitetoolbar/ezwt-icon-publish-disabled.gif"|ezimage} name="PreviewPublishButton" title="{'Publish'|i18n( 'design/ezwebin/content/view/versionview' )}" />
{/if}

{* Custom templates inclusion *}
{foreach $custom_templates as $custom_template}
    {if is_set( $include_in_view[$custom_template] )}
        {def $views = $include_in_view[$custom_template]|explode( ';' )}
        {if $views|contains( 'versionview' )}
            {include uri=concat( 'design:parts/websitetoolbar/', $custom_template, '.tpl' )}
        {/if}
        {undef $views}
    {/if}
{/foreach}

</form>
</div>

<div id="ezwt-help">
<p><a href="http://ez.no/doc" title="{'Documentation'|i18n( 'design/ezwebin/parts/website_toolbar' )}" target="_blank"><span class="hide">{'Documentation'|i18n( 'design/ezwebin/content/edit' )}</span>?</a></p>
</div>

<!-- eZ website toolbar content: END -->

</div></div></div>
<div class="bl"><div class="br"><div class="bc"></div></div></div>
</div>

<!-- eZ website toolbar: END -->