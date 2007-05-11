{def $collection = cond( $collection_id, fetch( content, collected_info_collection, hash( collection_id, $collection_id ) ),
                          fetch( content, collected_info_collection, hash( contentobject_id, $node.contentobject_id ) ) )}

{set-block scope=global variable=title}{'Form %formname'|i18n( 'design/ezwebin/collectedinfo/form', , hash( '%formname', $node.name|wash() ) )}{/set-block}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">

<div class="attribute-header">
    <h1>{$object.name|wash}</h1>
</div>

<p>{'Thank you for your feedback.'|i18n( 'design/ezwebin/collectedinfo/form' )}</p>

{if $error}

{if $error_existing_data}
<p>{'You have already submitted this form. The data you entered was:'|i18n('design/ezwebin/collectedinfo/form')}</p>
{/if}

{/if}

{foreach $collection.attributes as $attribute}

<p><strong>{$attribute.contentclass_attribute_name|wash}:</strong> {attribute_result_gui view=info attribute=$attribute} </p>

{/foreach}

<p/>

<a href={$node.parent.url|ezurl}>{'Return to site'|i18n('design/ezwebin/collectedinfo/form')}</a>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>