<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="notification-settings">

<form name="notification" method="post" action={"/notification/settings/"|ezurl}>

<div class="attribute-header">
    <h1 class="long">{'Notification settings'|i18n( 'design/ezwebin/notification/settings' )}</h1>
</div>

{def $handlers=fetch( 'notification', 'handler_list' )}

    {foreach $handlers as $handler}
        {if eq( $handler.id_string, $handlers.ezsubtree.id_string )}
            {skip}
        {/if}
        {include handler=$handler uri=concat( 'design:notification/handler/', $handler.id_string, '/settings/edit.tpl' )}
    {/foreach}


<input class="button" type="submit" name="Store" value="{'Apply changes'|i18n('design/ezwebin/notification/settings')}" />

<br />

{include handler=$handlers.ezsubtree view_parameters=$view_parameters uri=concat( 'design:notification/handler/', $handlers.ezsubtree.id_string, '/settings/edit.tpl' )}

</form>


</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>