{def $node=fetch( content, node, hash( node_id, $node_id) )}
<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="notification-addtonotification">

<div class="attribute-header">
<h1>
    {'Add to my notifications'|i18n( 'design/ezwebin/notification/addingresult')}
</h1>
</div>

<p>
{if $already_exists}
    {"Notification for node <%node_name> already exists."
    |i18n( 'design/ezwebin/notification/addingresult',,
           hash( '%node_name', $node.name ) )|wash}
{else}
    {"Notification for node <%node_name> was added successfully."
    |i18n( 'design/ezwebin/notification/addingresult',,
           hash( '%node_name', $node.name ) )|wash}
{/if}
</p>

<div class="buttonblock">
<form method="post" action={$redirect_url|ezurl}>
    <input class="button" type="submit" name="OK" value="{'OK'|i18n('design/ezwebin/notification/addingresult')}" />
</form>
</div>

</div>

</div></div></div></div></div>
</div>