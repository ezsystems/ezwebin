<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-tipafriend">

<div class="attribute-header">
    <h1 class="long">{"Tip a friend"|i18n("design/ezwebin/content/tipafriend")}</h1>
</div>

{switch name=Sw match=$action}
  {case match="confirm"}
    <div class="message-feedback">
      <h2>{"The message was sent."|i18n("design/ezwebin/content/tipafriend")}</h2>
      <p><a href={concat("/content/view/full/",$node_id)|ezurl}>{"Click here to return to the original page."|i18n("design/ezwebin/content/tipafriend")}</a></p>
    </div>
  {/case}
  {case match="error"}
    <div class="message-warning">
      <h2>{"The message was not sent."|i18n("design/ezwebin/content/tipafriend")}</h2>
      <p>{"The message was not sent due to an unknown error. Please notify the site administrator about this error."|i18n("design/ezwebin/content/tipafriend")}</p>
      <p><a href={concat("/content/view/full/",$node_id)|ezurl}>{"Click here to return to the original page."|i18n("design/ezwebin/content/tipafriend")}</a></p>
    </div>
  {/case}
  {case}

{section show=$error_strings}
<div class="message-warning">
<h2>{"Please correct the following errors:"|i18n("design/ezwebin/content/tipafriend")}:</h2>
{section loop=$error_strings}
<p>{$:item}</p>
{/section}
</div>
{/section}

<form action={"/content/tipafriend/"|ezurl} method="post">

<div class="block">
<label>{"Your name"|i18n("design/ezwebin/content/tipafriend")}</label><div class="labelbreak"></div>
<input class="box" type="text" size="40" name="YourName" value="{$your_name|wash}" />
</div>

<div class="block">
<label>{"Your email address"|i18n("design/ezwebin/content/tipafriend")}</label><div class="labelbreak"></div>
<input class="box" type="text" size="40" name="YourEmail" value="{$your_email|wash}" />
</div>

<div class="block">
<label>{"Recipient's email address"|i18n("design/ezwebin/content/tipafriend")}</label><div class="labelbreak"></div>
<input class="box" type="text" size="40" name="ReceiversEmail" value="{$receivers_email|wash}" />
</div>

<div class="block">
<label>{"Comment"|i18n("design/ezwebin/content/tipafriend")}</label><div class="labelbreak"></div>
<textarea class="box" cols="40" rows="10" name="Comment">{$comment|wash}</textarea>
</div>

<div class="buttonblock">
<input class="button" type="submit" name="SendButton" value="{'Send'|i18n('design/ezwebin/content/tipafriend')}" />
<input class="button" type="submit" name="CancelButton" value="{'Cancel'|i18n('design/ezwebin/content/tipafriend')}" />
</div>

<input type="hidden" name="NodeID" value="{$node_id}" />

</form>

  {/case}
{/switch}

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>