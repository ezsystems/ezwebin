<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="user-activate">

<div class="attribute-header">
	<h1 class="long">{"Activate account"|i18n("design/ezwebin/user/activate")}</h1>
</div>

<p>
{if $account_activated}
{'Your account is now activated.'|i18n('design/ezwebin/user/activate')}
{elseif $already_active}
{'Your account is already active.'|i18n('design/ezwebin/user/activate')}
{else}
{'Sorry, the key submitted was not a valid key. Account was not activated.'|i18n('design/ezwebin/user/activate')}
{/if}
</p>

<div class="buttonblock">
<form action={"/user/login"|ezurl} method="post">
    <input class="button" type="submit" value="{'OK'|i18n( 'design/ezwebin/user/activate' )}" />
</form>
</div>

</div>

</div></div></div></div></div>
</div>