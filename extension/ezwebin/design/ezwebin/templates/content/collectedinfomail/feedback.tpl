{set-block scope=root variable=subject}{"Feedback from %1"|i18n("design/ezwebin/collectedinfomail/feedback",,array($collection.object.name|wash))}{/set-block}

{if and( is_set( $object.data_map.recipient ), $object.data_map.recipient.has_content )}
{set-block scope=root variable=email_receiver}{$object.data_map.recipient.content}{/set-block}
{/if}

{* Set this to redirect to another node
{set-block scope=root variable=redirect_to_node_id}2{/set-block}
*}

{"The following feedback was collected"|i18n("design/ezwebin/collectedinfomail/feedback")}:

{foreach $collection.attributes as $attribute}
{$attribute.contentclass_attribute_name|wash()}:
{attribute_result_gui view=info attribute=$attribute}

{/foreach}