  <!-- Path content: START -->
  <p>
  {foreach $pagedata.path_array as $path}
  {if $path.url}
    <a href={cond( is_set( $path.url_alias ), $path.url_alias,
                                        $path.url )|ezurl}>{$path.text|wash}</a>
  {else}
    {$path.text|wash}
  {/if}
  {delimiter}/{/delimiter}
  {/foreach}
  </p>
  <!-- Path content: END -->