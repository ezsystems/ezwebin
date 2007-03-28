<table {section show=ne($classification|trim,'')}class="{$classification|wash}"{section-else}class="renderedtable"{/section} {section show=ne($border|trim,'')} border="{$border}"{/section} cellpadding="2" cellspacing="0" {section show=ne($width|trim,'')} width="{$width}"{/section}>
<col class="bgdark" />
{section loop=$col_count}
<col class="bglight" />
{/section}
{$rows}
</table>
