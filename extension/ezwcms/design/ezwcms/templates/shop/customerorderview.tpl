<div class="box-mc">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="shop-customerorderview">
	<div class="attribute-header">
		<h1>{"Customer Information"|i18n("design/standard/shop")}</h1>
	</div>
	
{shop_account_view_gui view=html order=$order_list[0]}


<div class="attribute-header">
	<h1>{"Order list"|i18n("design/standard/shop")}</h1>
</div>

{def $currency = false()
     $locale = false()
     $symbol = false()
     $product_info_count = false()}

{section show=$order_list}
<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<th>
	{"ID"|i18n("design/standard/shop")}
	</th>
	<th>
	{"Date"|i18n("design/standard/shop")}
	</th>
	<th>
	{"Total ex. VAT"|i18n("design/standard/shop")}
	</th>
	<th>
	{"Total inc. VAT"|i18n("design/standard/shop")}
	</th>
    <th>
	</th>
</tr>
{section var=Order loop=$order_list sequence=array(bglight,bgdark)}
{set currency = fetch( 'shop', 'currency', hash( 'code', $Order.item.productcollection.currency_code ) ) }
{if $currency}
    {set locale = $currency.locale
         symbol = $currency.symbol}
{else}
    {set locale = false()
         symbol = false()}
{/if}

<tr class="{$Order.sequence}">
	<td>
	{$Order.item.order_nr}
	</td>
	<td>
	{$Order.item.created|l10n(shortdatetime)}
	</td>
	<td>
	{$Order.item.total_ex_vat|l10n( 'currency', $locale, $symbol )}
	</td>
	<td>
	{$Order.item.total_inc_vat|l10n( 'currency', $locale, $symbol )}
	</td>
	<td>
	<a href={concat("/shop/orderview/",$Order.item.id,"/")|ezurl}>view</a>
	</td>
</tr>
{/section}
</table>
{/section}


<div class="attribute-header">
  <h1>{"Purchase list"|i18n("design/standard/shop")}</h1>
</div>

{section show=$product_list}
<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<th>
	{"Product"|i18n("design/standard/shop")}
	</th>
    <th>
	{"Amount"|i18n("design/standard/shop")}
	</th>
	<th>
	{"Total ex. VAT"|i18n("design/standard/shop")}
	</th>
	<th>
	{"Total inc. VAT"|i18n("design/standard/shop")}
	</th>
</tr>

{def $quantity_text = ''
     $total_ex_vat_text = ''
     $total_inc_vat_text = ''
     $br_tag = ''}

{section var="Product" loop=$product_list sequence=array(bglight,bgdark)}

    {set quantity_text = ''
         total_ex_vat_text = ''
         total_inc_vat_text = ''
         br_tag = ''}

    {foreach $Product.product_info as $currency_code => $info}
        {if $currency_code}
            {set currency = fetch( 'shop', 'currency', hash( 'code', $currency_code ) ) }
        {else}
            {set currency = false()}
        {/if}
        {if $currency}
            {set locale = $currency.locale
                 symbol = $currency.symbol}
        {else}
            {set locale = false()
                 symbol = false()}
        {/if}

        {set quantity_text = concat( $quantity_text, $br_tag, $info.sum_count) }
        {set total_ex_vat_text = concat($total_ex_vat_text, $br_tag, $info.sum_ex_vat|l10n( 'currency', $locale, $symbol )) }
        {set total_inc_vat_text = concat($total_inc_vat_text, $br_tag, $info.sum_inc_vat|l10n( 'currency', $locale, $symbol )) }

        {if $br_tag|not()}
            {set br_tag = '<br />'}
        {/if}
    {/foreach}

    <tr class="{$Product.sequence}">
        <td>{content_view_gui view=text_linked content_object=$Product.product}</td>
        <td align="right">{$quantity_text}</td>
        <td align="right">{$total_ex_vat_text}</td>
        <td align="right">{$total_inc_vat_text}</td>
    </tr>

{/section}

</table>
{/section}
{undef}

</div>

</div></div></div></div></div>
</div>