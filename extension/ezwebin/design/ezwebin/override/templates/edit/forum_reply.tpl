{* Forum reply - Edit *}

{def $parent_node=fetch( 'content', 'node', hash( node_id, $object.current.main_parent_node_id ) )}

<form enctype="multipart/form-data" method="post" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>

<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-edit">
    <div class="class-forum-reply">

		<div class="attribute-header">
        	<h1>{"Edit %1 - %2"|i18n("design/ezwebin/edit/forum_reply",,array($class.name|wash,$object.name|wash))}</h1>
		</div>
		
        {include uri="design:content/edit_validation.tpl"}

        <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
		
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$object.data_map.subject.id}" />
        <input type="hidden" name="ContentObjectAttribute_ezstring_data_text_{$object.data_map.subject.id}" value="{concat("Re: ", $parent_node.name)|wash(xhtml)|shorten(50)}" />
		
		<div class="block">
    		<label>Message:</label>
    		{attribute_edit_gui attribute=$object.data_map.message}
		</div>
        
		<br/>

        <div class="buttonblock">
            <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n('design/ezwebin/edit/forum_reply')}" />
            <input class="button" type="submit" name="DiscardButton" value="{'Discard'|i18n('design/ezwebin/edit/forum_reply')}" />
            <input type="hidden" name="DiscardConfirm" value="0" />
        </div>
    </div>
</div>


</div></div></div></div></div>
</div>

</form>