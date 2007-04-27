{def $page_limit = 20
     $keyword_list = fetch( 'content', 'keyword', hash( 'alphabet', $alphabet,
                                                       'limit', $page_limit,
                                                       'offset', $view_parameters.offset,
                                                       'classid', $view_parameters.classid ) )
     $list_count = fetch( 'content', 'keyword_count', hash( 'alphabet', $alphabet,
                                                           'limit', $page_limit,
                                                           'offset', $view_parameters.offset,
                                                           'classid', $view_parameters.classid ) )}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">

<div class="attribute-header">
    <h1 class="long">{'Keyword: %keyword'|i18n( 'design/ezwebin/content/keyword', ,
hash( '%keyword', $alphabet ) )}</h1>
</div>

<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
    <th>{'Link'|i18n( 'design/ezwebin/content/keyword' )}</th>
    <th>{'Type'|i18n( 'design/ezwebin/content/keyword' )}</th>
</tr>
{foreach $keyword_list as $keyword sequence array( 'bgdark', 'bglight' ) as $style}
<tr class="{$style}">
<td>
<a href={$keyword.link_object.object.main_node.url_alias|ezurl}>{$keyword.link_object.name|wash}</a>
</td>
<td>
{$keyword.link_object.class_name|wash}
</td>
</tr>
{/foreach}

</table>
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=concat('/content/keyword/', $alphabet)
         item_count=$list_count
         view_parameters=$view_parameters
         item_limit=$page_limit}

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>