<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="user-success">

{if $verify_user_email}
<div class="attribute-header">
	<h1 class="long">{"User registered"|i18n("design/ezwebin/user/success")}</h1>
</div>

<div class="feedback">
	<p>
	{'Your account was successfully created. An e-mail will be sent to the specified
	e-mail address. You need to follow the instructions in that mail to activate
	your account.'|i18n('design/ezwebin/user/success')}
	</p>
</div>
{else}
<div class="attribute-header">
	<h1 class="long">{"User registered"|i18n("design/ezwebin/user/success")}</h1>
</div>

<div class="feedback">
	<h2>{"Your account was successfully created."|i18n("design/ezwebin/user/success")}</h2>
</div>
{/if}

</div>

</div></div></div></div></div>
</div>