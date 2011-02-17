<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="user-activate">

<div class="attribute-header">
    <h1 class="long">{"Activate account"|i18n("design/ezwebin/user/activate")}</h1>
</div>

<p>
{if $account_activated}
    {if $is_pending}
        {'Your email address has been confirmed. An administrator needs to approve your sign up request, before your login becomes valid.'|i18n('design/standard/user')}
    {else}
        {'Your account is now activated.'|i18n('design/standard/user')}
    {/if}
{elseif $already_active}
    {'Your account is already active.'|i18n('design/standard/user')}
{else}
    {'Sorry, the key submitted was not a valid key. Account was not activated.'|i18n('design/standard/user')}
{/if}
</p>

<div class="buttonblock">
<form action={"/user/login"|ezurl} method="post">
    <input class="button" type="submit" value="{'OK'|i18n( 'design/ezwebin/user/activate' )}" />
</form>
</div>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>