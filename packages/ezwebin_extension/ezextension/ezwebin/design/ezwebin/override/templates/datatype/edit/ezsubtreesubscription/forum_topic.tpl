{if is_set( $attribute_base )|not()}
    {def $attribute_base = 'ContentObjectAttribute'}
{/if}

{if is_set( $type )|not()}
    {def $type = 'checkbox'}
{/if}

{if $type|eq( 'checkbox' )}
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="checkbox" name="{$attribute_base}_data_subtreesubscription_{$attribute.id}" {$attribute.data_int|choose( '', 'checked="checked"' )} />
{elseif $attribute.data_int|eq(1)}
{* Datatype expect just the postvariable to be set if value should be 'checked' *}
    <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="hidden" name="{$attribute_base}_data_subtreesubscription_{$attribute.id}" value="{$attribute.data_int}" />
{/if}    
{* Datatype expect the postvariable not to be set if value should be 'unchecked', therefor output nothing if type=hidden *}
