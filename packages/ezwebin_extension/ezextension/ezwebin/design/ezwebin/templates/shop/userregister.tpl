<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-userregister">

<ul>
     <li>1. {"Shopping basket"|i18n("design/ezwebin/shop/userregister")}</li>
     <li class="selected">2. {"Account information"|i18n("design/ezwebin/shop/userregister")}
</li>
     <li>3. {"Confirm order"|i18n("design/ezwebin/shop/userregister")}</li>
</ul>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-userregister">

<div class="attribute-header">
     <h1 class="long">{"Your account information"|i18n("design/ezwebin/shop/userregister")}</h1>
</div>

{section show=$input_error}
<div class="warning">
<p>
{"Input did not validate. All fields marked with * must be filled in."|i18n("design/ezwebin/shop/userregister")}
</p>
</div>

{/section}
<form method="post" action={"/shop/userregister/"|ezurl}>

<div class="block">
    <div class="element">
    <label>
    {"First name"|i18n("design/ezwebin/shop/userregister")}:*
    </label><div class="labelbreak"></div>
    <input class="halfbox" type="text" name="FirstName" size="20" value="{$first_name|wash}" />
    </div>
    <div class="element">
    <label>
    {"Last name"|i18n("design/ezwebin/shop/userregister")}:*
    </label><div class="labelbreak"></div>
    <input class="halfbox" type="text" name="LastName" size="20" value="{$last_name|wash}" />
    </div>
    <div class="break"></div>
</div>
<br />
<div class="block">
<label>
{"Email"|i18n("design/ezwebin/shop/userregister")}:*
</label><div class="labelbreak"></div>
<input class="box" type="text" name="EMail" size="20" value="{$email|wash}" />
</div>

<div class="block">
<label>
{"Company"|i18n("design/ezwebin/shop/userregister")}:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="Street1" size="20" value="{$street1|wash}" />
</div>

<div class="block">
<label>
{"Street"|i18n("design/ezwebin/shop/userregister")}:*
</label><div class="labelbreak"></div>
<input class="box" type="text" name="Street2" size="20" value="{$street2|wash}" />
</div>

<div class="block">
    <div class="element">
    <label>
    {"Zip"|i18n("design/ezwebin/shop/userregister")}:*
    </label><div class="labelbreak"></div>
    <input class="halfbox" type="text" name="Zip" size="20" value="{$zip|wash}" />
    </div>
    <div class="element">
    <label>
    {"Place"|i18n("design/ezwebin/shop/userregister")}:*
    </label><div class="labelbreak"></div>
    <input class="halfbox" type="text" name="Place" size="20" value="{$place|wash}" />
    </div>
    <div class="break"></div>
</div>
<br/>
<div class="block">
<label>
{"State"|i18n("design/ezwebin/shop/userregister")}:
</label><div class="labelbreak"></div>
<input class="box" type="text" name="State" size="20" value="{$state|wash}" />
</div>

<div class="block">
<label>
{"Country"|i18n("design/ezwebin/shop/userregister")}:*
</label><div class="labelbreak"></div>
{include uri='design:shop/country/edit.tpl' select_name='Country' select_size=5 current_val=$country}
</div>


<div class="block">
<label>
{"Comment"|i18n("design/ezwebin/shop/userregister")}:
</label><div class="labelbreak"></div>
<textarea name="Comment" cols="80" rows="5">{$comment|wash}</textarea>
</div>


<div class="buttonblock">
    <input class="button" type="submit" name="CancelButton" value="{"Cancel"|i18n('design/ezwebin/shop/userregister')}" />
    <input class="defaultbutton" type="submit" name="StoreButton" value="{"Continue"|i18n( 'design/ezwebin/shop/userregister')}" />
</div>

</form>

<p>
{"All fields marked with * must be filled in."|i18n("design/ezwebin/shop/userregister")}
</p>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>