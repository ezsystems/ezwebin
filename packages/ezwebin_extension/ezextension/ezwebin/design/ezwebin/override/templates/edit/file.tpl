<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-edit">
    <div class="class-file">

    <form enctype="multipart/form-data" method="post" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>


    {include uri='design:parts/website_toolbar_edit.tpl'}

    <div class="attribute-header">
        <h1 class="long">{"Edit %1 - %2"|i18n("design/ezwebin/edit/file",,array($class.name|wash,$object.name|wash))}</h1>
    </div>

    {include uri="design:content/edit_validation.tpl"}

    <input type="hidden" name="MainNodeID" value="{$main_node_id}" />

    {include uri="design:content/edit_attribute.tpl"}

    <div class="buttonblock">
        <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n('design/ezwebin/edit/file')}" />
        <input class="button" type="submit" name="DiscardButton" value="{'Discard'|i18n('design/ezwebin/edit/file')}" />
        <input type="hidden" name="DiscardConfirm" value="0" />
    </div>

    </form>

    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>