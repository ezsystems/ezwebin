<!-- eZ website toolbar: START -->

<div id="ezwt">
<div class="tl"><div class="tr"><div class="tc"></div></div></div>
<div class="mc"><div class="ml"><div class="mr float-break">

<!-- eZ website toolbar content: START -->

<div id="ezwt-ezlogo">
<a href={"/ezinfo/about"|ezurl} title="{'About'|i18n('design/ezwebin/parts/website_toolbar')}" target="_blank"><img src={"websitetoolbar/ezwt-logo.gif"|ezimage} width="50" height="16" alt="eZ" /></a>
</div>

<div id="ezwt-standardactions" class="left">

    <input class="button" type="submit" name="VersionsButton" value="{'Manage versions'|i18n('design/ezwebin/content/edit')}" />

    <input class="button" type="submit" name="StoreExitButton" value="{'Store and exit'|i18n( 'design/ezwebin/content/edit' )}" title="{'Store the draft that is being edited and exit from edit mode.'|i18n( 'design/ezwebin/content/edit' )}" />
    <input class="button" type="submit" name="PreviewButton" value="{'Preview'|i18n('design/ezwebin/content/edit')}" />
<select name="FromLanguage">
<option value=""{if $from_language|not} selected="selected"{/if}> {'No translation'|i18n( 'design/ezwebin/content/edit' )}</option>

{if $object.status}
{foreach $object.languages as $language}
<option value="{$language.locale}"{if $language.locale|eq($from_language)} selected="selected"{/if}>
{$language.name|wash}
</option>
{/foreach}
{/if}
</select>

<input {if $object.status|eq(0)}class="button-disabled" disabled="disabled"{else} class="button"{/if} type="submit" name="FromLanguageButton" value="{'Translate'|i18n( 'design/ezwebin/content/edit' )}" title="{'Edit the current object showing the selected language as a reference.'|i18n( 'design/ezwebin/content/edit' )}" />

</div>

<div id="ezwt-help">
<p><a href="http://ez.no/doc" title="{'Documentation'|i18n( 'design/ezwebin/parts/website_toolbar' )}" target="_blank"><span class="hide">{'Documentation'|i18n( 'design/ezwebin/content/edit' )}</span>?</a></p>
</div>

<!-- eZ website toolbar content: END -->

</div></div></div>
<div class="bl"><div class="br"><div class="bc"></div></div></div>
</div>

<!-- eZ website toolbar: END -->