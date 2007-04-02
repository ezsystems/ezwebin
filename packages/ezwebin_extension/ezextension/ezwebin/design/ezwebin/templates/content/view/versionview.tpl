<form method="post" action={concat( 'content/versionview/', $object.id, '/', $version.version, '/', $language, '/', $from_language )|ezurl}>

<div class="box-et box-et-content-edit">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">

<div class="block">
<div class="left">
    <a href={"/ezinfo/about"|ezurl}><img src={"ez_toolbar.png"|ezimage} alt="eZ publish Now" width="49" height="16" /></a>
{* version.status 0 is draft
   object.status 2 is archived *}
{section show=or( and( eq( $version.status, 0 ), $is_creator, $object.can_edit ),
                  and( eq( $object.status, 2 ), $object.can_edit ) )}
<input class="button" type="submit" name="EditButton" value="{'Edit'|i18n( 'design/ezwebin/content/view/versionview' )}" title="{'Edit the draft that is being displayed.'|i18n( 'design/ezwebin/content/view/versionview' )}" />
<input class="button" type="submit" name="PreviewPublishButton" value="{'Publish'|i18n( 'design/ezwebin/content/view/versionview' )}" title="{'Publish the draft that is being displayed.'|i18n( 'design/ezwebin/content/view/versionview' )}" />
{section-else}
<input class="button-disabled" type="submit" name="EditButton" value="{'Edit'|i18n( 'design/ezwebin/content/view/versionview' )}" disabled="disabled" title="{'This version is not a draft and thus it can not be edited.'|i18n( 'design/ezwebin/content/view/versionview' )}" />
<input class="button-disabled" type="submit" name="PreviewPublishButton" value="{'Publish'|i18n( 'design/ezwebin/content/view/versionview' )}" disabled="disabled" title="{'Publish the draft that is being displayed.'|i18n( 'design/ezwebin/content/view/versionview' )}" />
{/section}

</div>
<div class="right">
	<a href="http://ez.no/doc" title="Documentation"><img src={"ezt_question_mark.gif"|ezimage} alt="Help" class="help" /></a>
</div>

</div>

</div></div></div></div></div>
</div>

{node_view_gui view=full with_children=false() versionview_mode=true() is_editable=false() is_standalone=false() content_object=$object node_name=$object.name content_node=$node node=$node}

</form>