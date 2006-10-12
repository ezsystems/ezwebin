

<div class="box-et box-et-content-edit">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content">

<div class="block">
<div class="left">
    <a href={"/ezinfo/about"|ezurl}><img src={"ez_toolbar.png"|ezimage} border="0" /></a>
	<form enctype="multipart/form-data" method="post" action={concat("/content/edit/",$object.id,"/",$edit_version,"/",$edit_language|not|choose(concat($edit_language,"/"),''))|ezurl}>
    <input class="button" type="submit" name="VersionsButton" value="{'Versions'|i18n('design/standard/content/edit')}" />

    <input class="button" type="submit" name="StoreExitButton" value="{'Store and exit'|i18n( 'design/admin/content/edit' )}" title="{'Store the draft that is being edited and exit from edit mode.'|i18n( 'design/admin/content/edit' )}" />
    <input class="button" type="submit" name="PreviewButton" value="{'Preview'|i18n('design/standard/content/edit')}" />
<select name="FromLanguage">
<option value=""{if $from_language|not} selected="selected"{/if}> {'No translation'|i18n( 'design/admin/content/edit' )}</option>

{if $object.status}
{foreach $object.languages as $language}
<option value="{$language.locale}"{if $language.locale|eq($from_language)} selected="selected"{/if}>
{$language.name|wash}
</option>
{/foreach}
{/if}
</select>

<input {if $object.status|eq(0)}class="button-disabled" disabled="disabled"{else} class="button"{/if} type="submit" name="FromLanguageButton" value="{'Translate'|i18n( 'design/admin/content/edit' )}" title="{'Edit the current object showing the selected language as a reference.'|i18n( 'design/admin/content/edit' )}" />
</form>

		<form method="post" action={concat( "/content/diff/", $object.id )|ezurl}>
  		<input class="button" type="submit" name="DiffAction" value="{'History'|i18n('design/standard/node/view')}" />
	</form>
</div>
<div class="right">
<img src={"ezt_question_mark.gif"|ezimage} alt="Help" class="help"/>
</div>

</div>

</div></div></div></div></div>
</div>

<form enctype="multipart/form-data" method="post" action={concat("/content/edit/",$object.id,"/",$edit_version,"/",$edit_language|not|choose(concat($edit_language,"/"),''))|ezurl}>

<div class="box-mc">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="content-edit">

    <div class="attribute-header">
    <h1>{"Edit %1 - %2"|i18n("design/standard/content/edit",,array($class.name|wash,$object.name|wash))}</h1>
    </div>

    {include uri="design:content/edit_validation.tpl"}

    <br/>

    {include uri="design:content/edit_attribute.tpl"}

    <div class="buttonblock">
    <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n('design/standard/content/edit')}" />
    <input class="button" type="submit" name="StoreButton" value="{'Store draft'|i18n('design/standard/content/edit')}" />
    <input class="button" type="submit" name="DiscardButton" value="{'Discard'|i18n('design/standard/content/edit')}" />
    <input type="hidden" name="DiscardConfirm" value="0" />
	<input type="hidden" name="RedirectIfDiscarded" value="{ezhttp( 'LastAccessesURI', 'session' )}" />
	<input type="hidden" name="RedirectURIAfterPublish" value="{ezhttp( 'LastAccessesURI', 'session' )}" />
    </div>

</div>

</div></div></div></div></div>
</div>

</form>
