<form enctype="multipart/form-data" method="post" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>

<div class="box-mc">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-edit">
    <div class="class-file">
	
    <div class="attribute-header">
    	<h1>{"Edit %1 - %2"|i18n("design/base",,array($class.name|wash,$object.name|wash))}</h1>
    </div>

    {include uri="design:content/edit_validation.tpl"}

    <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
    <br/>

    {include uri="design:content/edit_attribute.tpl"}
    <br/>

    <div class="buttonblock">
    <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n('design/base')}" />
    <input class="button" type="submit" name="DiscardButton" value="{'Discard'|i18n('design/base')}" />
    <input type="hidden" name="DiscardConfirm" value="0" />
    </div>
	
	</div>
</div>

</div></div></div></div></div>
</div>
</form>