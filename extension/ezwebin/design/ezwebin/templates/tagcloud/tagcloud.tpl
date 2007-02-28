{foreach $tag_cloud as $tag}
<a href={concat( "/content/keyword/", $tag['tag']|rawurlencode )|ezurl()} style="font-size: {$tag['font_size']}%" title="{$tag['count']} objects tagged with '{$tag['tag']|wash()}'">{$tag['tag']|wash()}</a> 
{/foreach}