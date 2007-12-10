<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">

<form enctype="multipart/form-data" method="post" action={"/ezodf/export"|ezurl}>

<div class="attribute-header">
    <h1 class="long">{"OpenOffice.org export"|i18n("design/ezwebin/ezodf/export")}</h1>
</div>

<div class="object-right">
<img src={"ooo_logo.gif"|ezimage} alt="OpenOffice.org" />
</div>

<h2>{"Export eZ publish content to OpenOffice.org"|i18n("design/ezwebin/ezodf/export")}</h2>

{section show=$error_string}
   <h3>{"Error"|i18n("design/ezwebin/ezodf/export")}: {$error_string}</h3>
{/section}

<p>
{"Here you can export any eZ publish content object to an OpenOffice.org Writer document format."|i18n("design/ezwebin/ezodf/export")}
</p>

<div class="block">
    <input class="button" type="submit" name="ExportButton" value="{'Export Object'|i18n('design/ezwebin/ezodf/export')}" />
</div>

</form>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
