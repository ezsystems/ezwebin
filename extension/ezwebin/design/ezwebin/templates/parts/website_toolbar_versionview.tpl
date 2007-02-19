<!-- eZ website toolbar: START -->

<div id="ezwt">
<div class="tl"><div class="tr"><div class="tc"></div></div></div>
<div class="mc"><div class="ml"><div class="mr float-break">

<!-- eZ website toolbar content: START -->

<div id="ezwt-ezlogo">
<a href={"/ezinfo/about"|ezurl} title="{'About'|i18n('design/ezwebin/parts/website_toolbar')}" target="_blank"><img src={"websitetoolbar/ezwt-logo.gif"|ezimage} width="50" height="16" alt="eZ" /></a>
</div>

<div id="ezwt-standardactions" class="left">

{if or( and( eq( $version.status, 0 ), $is_creator, $object.can_edit ),
                  and( eq( $object.status, 2 ), $object.can_edit ) )}
<input class="button" type="submit" name="EditButton" value="{'Edit'|i18n( 'design/ezwebin/content/view/versionview' )}" title="{'Edit the draft that is being displayed.'|i18n( 'design/ezwebin/content/view/versionview' )}" />
<input class="button" type="submit" name="PreviewPublishButton" value="{'Publish'|i18n( 'design/ezwebin/content/view/versionview' )}" title="{'Publish the draft that is being displayed.'|i18n( 'design/ezwebin/content/view/versionview' )}" />
{else}
<input class="button-disabled" type="submit" name="EditButton" value="{'Edit'|i18n( 'design/ezwebin/content/view/versionview' )}" disabled="disabled" title="{'This version is not a draft and thus it can not be edited.'|i18n( 'design/ezwebin/content/view/versionview' )}" />
<input class="button-disabled" type="submit" name="PreviewPublishButton" value="{'Publish'|i18n( 'design/ezwebin/content/view/versionview' )}" disabled="disabled" title="{'Publish the draft that is being displayed.'|i18n( 'design/ezwebin/content/view/versionview' )}" />
{/if}

</div>

<div id="ezwt-help">
<p><a href="http://ez.no/doc" title="{'Documentation'|i18n( 'design/ezwebin/parts/website_toolbar' )}" target="_blank"><span class="hide">{'Documentation'|i18n( 'design/ezwebin/content/edit' )}</span>?</a></p>
</div>

<!-- eZ website toolbar content: END -->

</div></div></div>
<div class="bl"><div class="br"><div class="bc"></div></div></div>
</div>

<!-- eZ website toolbar: END -->