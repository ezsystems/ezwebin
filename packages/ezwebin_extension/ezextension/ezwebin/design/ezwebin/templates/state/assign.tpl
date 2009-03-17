<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<form name="locationsform" method="post" action={'state/assign'|ezurl}>
<input type="hidden" name="ObjectID" value="{$node.object.id}" />
<input type="hidden" name="RedirectRelativeURI" value="{$node.url_alias}" />

<div class="attribute-header">
    <h1 class="long">{'Object states for object'|i18n( 'design/ezwebin/websitetoolbar/objectstates' )}&nbsp;: <a href={$node.url_alias|ezurl}>{$node.name}</a></h1>
</div>


{if $node.object.allowed_assign_state_list|count}
	<table class="list" cellspacing="0">
	    <tr>
	        <th class="object-states-group">{'Content object state group'|i18n( 'design/ezwebin/websitetoolbar/objectstates' )}</th>
	        <th class="available-states">{'Available states'|i18n( 'design/ezwebin/websitetoolbar/objectstates' )}</th>
	    </tr>
	
	    {foreach $node.object.allowed_assign_state_list as $allowed_assign_state_info sequence array( bglight, bgdark ) as $sequence}
	    <tr class="{$sequence}">
	        <td>{$allowed_assign_state_info.group.current_translation.name|wash}</td>
	        <td>
	            <select name="SelectedStateIDList[]" {if $allowed_assign_state_info.states|count|eq(1)}disabled="disabled"{/if}>
	            {foreach $allowed_assign_state_info.states as $state}
	                <option value="{$state.id}" {if $node.object.state_id_array|contains($state.id)}selected="selected"{/if}>{$state.current_translation.name|wash}</option>
	            {/foreach}
	            </select>
	        </td>
	    </tr>
	    {/foreach}
	</table>
{else}
	<div class="block">
	    <p>
		{'No content object state is configured. This can be done %urlstart here %urlend.'|i18n( 'design/ezwebin/websitetoolbar/objectstates', '', hash( '%urlstart', concat( '<a href=', 'state/groups'|ezurl, '>' ), 
		                                                                                                                                  '%urlend', '</a>' ) )}
	    </p>
	</div>
{/if}

{* DESIGN : Control START *}
<div class="controlbar">
<div class="block">
<div class="left">
    {if $node.object.allowed_assign_state_list|count}
    <input type="submit" value="{'Set states'|i18n( 'design/ezwebin/websitetoolbar/objectstates' )}" name="AssignButton" class="button" title="{'Apply states from the list above.'|i18n( 'design/ezwebin/websitetoolbar/objectstates' )}" />
    {else}
    <input type="submit" value="{'Set states'|i18n( 'design/ezwebin/websitetoolbar/objectstates' )}" name="AssignButton" class="button-disabled" title="{'No state to be applied to this content object. You might need to be assigned a more permissive access policy.'|i18n( 'design/ezwebin/websitetoolbar/objectstates' )}"/>
    {/if}
</div>
<div class="break"></div>
</div>
</div>
{* DESIGN : Control END *}

</form>

{undef}

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>