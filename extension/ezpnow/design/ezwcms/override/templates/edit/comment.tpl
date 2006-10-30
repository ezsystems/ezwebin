
<form enctype="multipart/form-data" method="post" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>

<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-edit">
    <div class="class-comment">

	<div class="attribute-header">
    	<h1>{"Edit %1 - %2"|i18n("design/base",,array($class.name|wash,$object.name|wash))}</h1>
	</div>
    {include uri="design:content/edit_validation.tpl"}

    <br/>

    <div class="block">
       {def $attribute=$object.data_map.subject}
       <label>{$attribute.contentclass_attribute.name}</label><div class="labelbreak"></div>
       <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
       <input class="box" type="text" size="70" name="ContentObjectAttribute_ezstring_data_text_{$attribute.id}" value="" />
    </div>

    {def $current_user=fetch( 'user', 'current_user' )
         $attribute=$object.data_map.author}
    <div class="block">
        {if $current_user.is_logged_in}
        <input type="hidden" name="ContentObjectAttribute_ezstring_data_text_{$attribute.id}" value="{$current_user.contentobject.name|wash}" />
        {else}
            <label>{$attribute.contentclass_attribute.name}</label><div class="labelbreak"></div>
	    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
	    <input class="box" type="text" size="70" name="ContentObjectAttribute_ezstring_data_text_{$attribute.id}" value="" />
        {/if}
    </div>

    <div class="block">
       {def $attribute=$object.data_map.message}
       <label>{$attribute.contentclass_attribute.name}</label><div class="labelbreak"></div>
       <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
       <textarea class="box" cols="70" rows="10" name="ContentObjectAttribute_data_text_{$attribute.id}"></textarea>
    </div>

    <div class="buttonblock">
        <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n('design/base')}" />
	    <input class="button" type="submit" name="DiscardButton" value="{'Discard'|i18n('design/base')}" />
        <input type="hidden" name="MainNodeID" value="{$main_node_id }" />
        <input type="hidden" name="DiscardConfirm" value="0" />
    </div>

    </div>
</div>

</div></div></div></div></div>
</div>
</form>