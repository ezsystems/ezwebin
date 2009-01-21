{set $classification = cond( $align, concat( $classification, ' text-', $align ), $classification )}
<p{if $classification|trim} class="{$classification|wash}"{/if}>
{if eq( $content|trim(), '' )}&nbsp;{else}{$content}{/if}
</p>