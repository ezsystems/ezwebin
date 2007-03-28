{section var=Authors loop=$attribute.content.author_list sequence=array( bglight, bgdark )}
{$Authors.item.name|wash( xhtml )}{delimiter},&nbsp;{/delimiter}
{/section}