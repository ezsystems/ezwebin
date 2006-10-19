{def $page_limit=10
     $col_count=2
     $children=fetch('content','list',hash(parent_node_id,$node.node_id,limit,$page_limit,offset,$view_parameters.offset))
     $child_count=fetch('content','list_count',hash(parent_node_id,$node.node_id))}
<div class="box">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="attribute-header">
	<h1 class="long">{"Site map"|i18n("design/standard/node/view")} {$node.name|wash}</h1>
</div>

<table width="100%" cellspacing="0" cellpadding="4">
<tr>
{foreach $children as $key => $child}
    <td>
    <h2><a href={$child.url_alias|ezurl}>{$child.name}</a></h2>

    {def $sub_children=fetch('content','list',hash(parent_node_id,$child.node_id,limit,$page_limit))
         $sub_child_count=fetch('content','list_count',hash(parent_node_id,$child.node_id))}

    <ul>
    {foreach $sub_children as $sub_child}
    <li><a href={$sub_child.url_alias|ezurl}>{$sub_child.name}</a></li>
    {/foreach}
    </ul>
    </td>
    {if ne( $key|mod($col_count), 0 )}
</tr>
<tr>
    {/if}
{/foreach}
</tr>
</table>

</div></div></div></div></div>
</div>