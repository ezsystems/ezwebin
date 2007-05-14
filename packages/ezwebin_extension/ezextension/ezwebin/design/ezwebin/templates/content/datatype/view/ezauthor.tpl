{foreach $attribute.content.author_list as $author}
{$author.name|wash( xhtml )}{delimiter},&nbsp;{/delimiter}
{/foreach}