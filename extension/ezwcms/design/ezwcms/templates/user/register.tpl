<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<form enctype="multipart/form-data"  action={"/user/register/"|ezurl} method="post" name="Register">

<div class="attribute-header">
<h1>{"Register user"|i18n("design/standard/user")}</h1>
</div>

{if and( and( is_set( $checkErrNodeId ), $checkErrNodeId ), eq( $checkErrNodeId, true ) )}
	 <div class="message-error">
		<h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {$errMsg}</h2>
	 </div>
{/if}

{if $validation.processed}

	{if $validation.attributes|count|gt(0)}
		<div class="warning">
		<h2>{"Input did not validate"|i18n("design/standard/user")}</h2>
		<ul>
		{foreach $validation.attributes as $attribute}
			<li>{$attribute.name}: {$attribute.description}</li>
		{/foreach}
		</ul>
		</div>
	{else}
		<div class="feedback">
		<h2>{"Input was stored successfully"|i18n("design/standard/user")}</h2>
		</div>
	{/if}

{/if}

{if count($content_attributes)|gt(0)}
    {section name=ContentObjectAttribute loop=$content_attributes sequence=array(bglight,bgdark)}
	<input type="hidden" name="ContentObjectAttribute_id[]" value="{$ContentObjectAttribute:item.id}" />
	<div class="block">
	    <label>{$ContentObjectAttribute:item.contentclass_attribute.name}</label><div class="labelbreak"></div>
	    {attribute_edit_gui attribute=$ContentObjectAttribute:item}
	</div>
    {/section}

    <div class="buttonblock">
         <input class="button" type="hidden" name="UserID" value="{$content_attributes[0].contentobject_id}" />
    {if and( is_set( $checkErrNodeId ), $checkErrNodeId )|not()}
        <input class="button" type="submit" name="PublishButton" value="{'Register'|i18n('design/standard/user')}" />
    {else}	
       	<input class="button" type="submit" name="PublishButton" disabled="disabled" value="{'Register'|i18n('design/standard/user')}" />
    {/if}
	<input class="button" type="submit" name="CancelButton" value="{'Discard'|i18n('design/standard/user')}" />
    </div>
{else}
	<div class="warning">
		 <h2>{"Unable to register new user"|i18n("design/standard/user")}</h2>
	</div>
	<input class="button" type="submit" name="CancelButton" value="{'Back'|i18n('design/standard/user')}" />
{/if}
</form>

</div></div></div></div></div>
</div>
