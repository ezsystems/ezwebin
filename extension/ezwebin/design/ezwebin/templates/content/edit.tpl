<form enctype="multipart/form-data" id="editform" name="editform" method="post" action={concat("/content/edit/",$object.id,"/",$edit_version,"/",$edit_language|not|choose(concat($edit_language,"/"),''))|ezurl}>

{include uri='design:parts/website_toolbar_edit.tpl'}

</div></div></div>
<div class="bl"><div class="br"><div class="bc"></div></div></div>
</div>

<!-- eZ website toolbar: END -->

<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-edit">

    <div class="attribute-header">
	    <h1 class="long">{"Edit %1 - %2"|i18n("design/ezwebin/content/edit",,array($class.name|wash,$object.name|wash))}</h1>
    </div>

    {include uri="design:content/edit_validation.tpl"}

    {include uri="design:content/edit_attribute.tpl"}

    <div class="buttonblock">
    <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n('design/ezwebin/content/edit')}" />
    <input class="button" type="submit" name="StoreButton" value="{'Store draft'|i18n('design/ezwebin/content/edit')}" />
    <input class="button" type="submit" name="DiscardButton" value="{'Discard draft'|i18n('design/ezwebin/content/edit')}" />
    <input type="hidden" name="DiscardConfirm" value="0" />
	<input type="hidden" name="RedirectIfDiscarded" value="{ezhttp( 'LastAccessesURI', 'session' )}" />
	<input type="hidden" name="RedirectURIAfterPublish" value="{ezhttp( 'LastAccessesURI', 'session' )}" />
    </div>
	
    {include uri='design:content/edit_locations.tpl'}

</div>

</div></div></div></div></div>
</div>

</form>