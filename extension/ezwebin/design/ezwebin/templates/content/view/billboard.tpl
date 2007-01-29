{def $size="billboard"
     $alternative_text=$object.data_map.name.content}

{if is_set( $object.data_map.image.content[$size].alternative_text )}
{set $alternative_text=$object.data_map.image.content[$size].alternative_text}
{/if}

{* First check if this is a media object (flash / video), if not treath as image *}
{if is_set($object.data_map.file)}

   {def $filters = ezini( $size, 'Filters', 'image.ini' )
        $banner_width = 754}
	{foreach $filters as $filter}
	   {if $filter|contains( "geometry/scalewidth" )}
	      {set $banner_width = $filter|explode("=").1}
	      {break}
	   {/if}
	{/foreach}
	{attribute_view_gui attribute=$object.data_map.file media_width=$banner_width}
    {* media_width is supported by enchanment: http://issues.ez.no/IssueView.php?Id=10076 *}
{else}
	{if eq( $object.data_map.image_map.content, true() ) }
	        <img usemap="#banner_map" src={$object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" border="0" width="{$object.data_map.image.content[$size].width}" height="{$object.data_map.image.content[$size].height}" />
	{$object.data_map.image_map.content}
	{else}
	{if $object.data_map.url.content}
	            <a href={$object.data_map.url.content|ezurl}>
	            <img src={$object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" border="0" width="{$object.data_map.image.content[$size].width}" height="{$object.data_map.image.content[$size].height}" />
	            </a>
	{else}
	            <img src={$object.data_map.image.content[$size].full_path|ezroot} alt="{$alternative_text}" border="0" width="{$object.data_map.image.content[$size].width}" height="{$object.data_map.image.content[$size].height}" />
	{/if}
	{/if}
{/if}