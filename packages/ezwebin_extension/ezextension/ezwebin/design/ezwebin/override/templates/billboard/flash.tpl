{def $size="billboard"
     $alternative_text=$object.data_map.name.content}

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
