<div class="box-mc">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="notification-settings">

<form method="post" action={"/notification/settings/"|ezurl}>

<div class="attribute-header">
	<h1>{"Notification settings"|i18n('design/standard/notification')}</h1>
</div>

{def $handlers=fetch('notification','handler_list')}

    {foreach $handlers as $handler}
        {include handler=$handler uri=concat( "design:notification/handler/",$handler.id_string,"/settings/edit.tpl")}
    {/foreach}


<input class="button" type="submit" name="Store" value="{'Store'|i18n('design/standard/notification')}" />
</form>

</div>

</div></div></div></div></div>
</div>