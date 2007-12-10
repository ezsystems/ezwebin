{if $attribute.content.has_discount}
<span class="old-price">{'Price'|i18n( 'design/ezwebin/view/ezprice' )}: {$attribute.content.inc_vat_price|l10n( currency )}</span> <br />
<span class="new-price">{'Your price'|i18n( 'design/ezwebin/view/ezprice' )}: {$attribute.content.discount_price_inc_vat|l10n( currency )}</span><br />
<span class="discount-percent">{'You save'|i18n( 'design/ezwebin/view/ezprice' )}: {sub($attribute.content.inc_vat_price,$attribute.content.discount_price_inc_vat)|l10n( currency )} ( {$attribute.content.discount_percent} % )</span>
{else}
{'Price'|i18n( 'design/ezwebin/view/ezprice' )} {$attribute.content.inc_vat_price|l10n( currency )}<br />
{/if}