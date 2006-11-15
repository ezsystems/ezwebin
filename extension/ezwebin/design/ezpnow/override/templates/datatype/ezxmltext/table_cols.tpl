<table {section show=ne($classification|trim,'')}class="{$classification|wash}"{section-else}class="renderedtable"{/section} {section show=ne($border|trim,'')} border="{$border}"{/section} cellpadding="2" cellspacing="0" {section show=ne($width|trim,'')} width="{$width}"{/section}>
{section loop=$col_count|inc sequence=array('bglight','bgdark')}
<col class="{$sequence}" />
{/section}
{$rows}
</table>
