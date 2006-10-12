<div class="box-mc">
<div class="tl"><div class="tr"><div class="br"><div class="bl"><div class="box-content float-break">

<div class="shop-orderview">

<div class="attribute-header">
  <h1>{"Order %order_id [%order_status]"|i18n("design/standard/shop",,
       hash( '%order_id', $order.order_nr,
             '%order_status', $order.status_name ) )}</h1>
</div>

{shop_account_view_gui view=html order=$order}

{def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )
         $locale = false()
         $symbol = false()}

{if $currency}
    {set locale = $currency.locale
         symbol = $currency.symbol}
{/if}

<br />

<h3>{"Product items"|i18n("design/standard/shop")}</h3>
<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<th>
	{"Product"|i18n("design/standard/shop")}
	</th>
	<th>
	{"Count"|i18n("design/standard/shop")}
	</th>
	<th>
	{"VAT"|i18n("design/standard/shop")}
	</th>
	<th>
	{"Price inc. VAT"|i18n("design/standard/shop")}
	</th>
	<th>
	{"Discount"|i18n("design/standard/shop")}
	</th>
	<th>
	{"Total Price ex. VAT"|i18n("design/standard/shop")}
	</th>
	<th>
	{"Total Price inc. VAT"|i18n("design/standard/shop")}
	</th>
</tr>
{section name=ProductItem loop=$order.product_items show=$order.product_items sequence=array(bglight,bgdark)}
<tr class="{$ProductItem:sequence}">
	<td>
	<a href={concat("/content/view/full/",$ProductItem:item.node_id,"/")|ezurl}>{$ProductItem:item.object_name}</a>
	</td>
	<td>
	{$ProductItem:item.item_count}
	</td>
	<td>
	{$ProductItem:item.vat_value} %
	</td>
	<td>
	{$ProductItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
	</td>
	<td>
	{$ProductItem:item.discount_percent}%
	</td>
	<td>
	{$ProductItem:item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}
	</td>
	<td>
	{$ProductItem:item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}
	</td>
</tr>
{/section}
</table>



<h3>{"Order summary"|i18n("design/standard/shop")}:</h3>
<table class="list" cellspacing="0" cellpadding="0" border="0">
<tr>
    <th>
    {"Summary"|i18n("design/standard/shop")}:
    </th>
    <th>
    Total ex. VAT
    </th>
    <th>
    Total inc. VAT
    </th>
</tr>
<tr class="bglight">
    <td>
    {"Subtotal of items"|i18n("design/standard/shop")}:
    </td>
    <td>
    {$order.product_total_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
    <td>
    {$order.product_total_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
</tr>

{section name=OrderItem loop=$order.order_items show=$order.order_items sequence=array(bglight,bgdark)}
<tr class="{$OrderItem:sequence}">
	<td>
	{$OrderItem:item.description}:
	</td>
	<td>
	{$OrderItem:item.price_ex_vat|l10n( 'currency', $locale, $symbol )}
	</td>
	<td>
	{$OrderItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
	</td>
</tr>
{/section}
<tr class="bgdark">
    <td>
    	{"Order total"|i18n("design/standard/shop")}
    </td>
    <td>
    	{$order.total_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
    <td>
    	{$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
</tr>
</table>


<h3>{"Order history"|i18n("design/standard/shop")}:</h3>
<table class="list" cellspacing="0" cellpadding="0" border="0">
<tr>
	<th>Date</th>
	<th>Order status</th>
</tr>
{let order_status_history=fetch( shop, order_status_history,
                                 hash( 'order_id', $order.order_nr ) )}
{section var=history loop=$order_status_history sequence=array(bglight,bgdark)}
<tr class="{$history.sequence} ">
    <td class="date">{$sel_pre}{$history.modified|l10n( shortdatetime )}</td>
	<td>{$history.status_name|wash}</td>
</tr>
{/section}
{/let}
</table>

</div>

</div></div></div></div></div>
</div>