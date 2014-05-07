<div class="block">
{$attribute.content.name|wash}
</div>

{foreach  $attribute.content.multioption_list as $multioptions}
<div class="block">
<label>{$multioptions.name|wash}:</label>
<select name="eZOption[{$attribute.id}][]">
    {foreach $multioptions.optionlist as $index => $option}
            {if ne( $option.additional_price, '' )}
                {if eq( sum( $index, 1 ), $multioptions.default_option_id )}
                    <option value="{$option.option_id}" selected="selected">{$option.value|wash}-{$option.additional_price|l10n( currency )}</option>
                {else}
                    <option value="{$option.option_id}">{$option.value|wash}-{$option.additional_price|l10n( currency )}</option>
                {/if}
            {else}
                {if eq( sum( $index, 1 ), $multioptions.default_option_id)}
                    <option value="{$option.option_id}" selected="selected">{$option.value|wash}</option>
                {else}
                    <option value="{$option.option_id}">{$option.value|wash}</option>
                {/if}
            {/if}
        {/foreach}
    </select>
</div>
{/foreach}