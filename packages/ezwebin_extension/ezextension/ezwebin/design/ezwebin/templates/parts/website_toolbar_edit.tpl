<!-- eZ website toolbar: START -->

<div id="ezwt">
<div class="tl"><div class="tr"><div class="tc"></div></div></div>
<div class="mc"><div class="ml"><div class="mr float-break">

<!-- eZ website toolbar content: START -->

<div id="ezwt-ezlogo">
<a href={"/ezinfo/about"|ezurl} title="{'About'|i18n('design/ezwebin/parts/website_toolbar')}" target="_blank"><img src={"websitetoolbar/ezwt-logo.gif"|ezimage} width="50" height="16" alt="eZ" /></a>
</div>

<div id="ezwt-standardactions" class="left">

    <input type="image" src={"websitetoolbar/ezwt-icon-versions.gif"|ezimage} name="VersionsButton" title="{'Manage versions'|i18n('design/ezwebin/content/edit')}" />

    <input type="image" src={"websitetoolbar/ezwt-icon-exit.gif"|ezimage} name="StoreExitButton" title="{'Store and exit'|i18n( 'design/ezwebin/content/edit' )}" />

    <input type="image" src={"websitetoolbar/ezwt-icon-preview.gif"|ezimage} name="PreviewButton" title="{'Preview'|i18n('design/ezwebin/content/edit')}" />

<select name="FromLanguage">
<option value=""{if $from_language|not} selected="selected"{/if}> {'Translate from'|i18n( 'design/ezwebin/content/edit' )}</option>

{if $object.status}
{foreach $object.languages as $lang}
<option value="{$lang.locale}"{if $lang.locale|eq($from_language)} selected="selected"{/if}>
{$lang.name|wash}
</option>
{/foreach}
{/if}
</select>

{if $object.status|eq(0)}
    <input disabled="disabled" type="image" src={"websitetoolbar/ezwt-icon-add_translation-disabled.gif"|ezimage} name="FromLanguageButton" title="{'Translate'|i18n( 'design/ezwebin/content/edit' )}" />
{else}
    <input type="image" src={"websitetoolbar/ezwt-icon-add_translation.gif"|ezimage} name="FromLanguageButton" title="{'Translate'|i18n( 'design/ezwebin/content/edit' )}" />
{/if}
</div>

<div id="ezwt-help">
<p><a href="http://ez.no/doc" title="{'Documentation'|i18n( 'design/ezwebin/parts/website_toolbar' )}" target="_blank"><span class="hide">{'Documentation'|i18n( 'design/ezwebin/content/edit' )}</span>?</a></p>
</div>

<!-- eZ website toolbar content: END -->

</div></div></div>
<div class="bl"><div class="br"><div class="bc"></div></div></div>
</div>

<!-- eZ website toolbar: END -->