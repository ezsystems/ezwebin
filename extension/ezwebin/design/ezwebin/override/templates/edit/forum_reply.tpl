{* Forum reply - Edit *}

{def $parent_node=fetch( 'content', 'node', hash( node_id, $object.current.main_parent_node_id ) )}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-edit">
    <div class="class-forum-reply">

    <form enctype="multipart/form-data" method="post" action={concat( "/content/edit/", $object.id, "/", $edit_version, "/", $edit_language|not|choose( concat( $edit_language, "/" ), '' ) )|ezurl}>

        <div class="attribute-header">
            <h1 class="long">{"Edit %1 - %2"|i18n("design/ezwebin/edit/forum_reply",,array($class.name|wash,$object.name|wash))}</h1>
        </div>
        
        {include uri="design:content/edit_validation.tpl"}

        <input type="hidden" name="MainNodeID" value="{$main_node_id}" />
        
        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$object.data_map.subject.id}" />
        <input type="hidden" name="ContentObjectAttribute_ezstring_data_text_{$object.data_map.subject.id}" value="{concat("Re: ", $parent_node.name)|wash(xhtml)|shorten(50)}" />
        
        <div class="block">
            <label>{$object.data_map.message.contentclass_attribute.name}</label>
            {attribute_edit_gui attribute=$object.data_map.message}
        </div>

        <div class="buttonblock">
            <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n('design/ezwebin/edit/forum_reply')}" />
            <input class="button" type="submit" name="DiscardButton" value="{'Discard'|i18n('design/ezwebin/edit/forum_reply')}" />
            <input type="hidden" name="DiscardConfirm" value="0" />
        </div>

    </form>

    </div>
</div>


</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>