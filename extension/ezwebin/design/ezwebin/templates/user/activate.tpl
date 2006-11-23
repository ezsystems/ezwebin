<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="user-activate">

<div class="attribute-header">
	<h1 class="long">{"Activate account"|i18n("design/ezwebin/user/activate")}</h1>
</div>

<p>
{section show=$account_activated}
{'Your account is now activated.'|i18n('design/ezwebin/user/activate')}
{section-else}
{'Sorry, the key submitted was not a valid key. Account was not activated.'|i18n('design/ezwebin/user/activate')}
{/section}

</p>

</div>

</div></div></div></div></div>
</div>