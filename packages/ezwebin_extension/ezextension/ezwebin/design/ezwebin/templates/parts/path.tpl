  <!-- Path content: START -->
  <p>
  {foreach $pagedata.path_array as $path}
  {if $path.url}
    <a href={cond( is_set( $path.url_alias ), $path.url_alias,
                                        $path.url )|ezurl}>{$path.text|wash}</a>
  {else}
    <span class="path-text">{$path.text|wash}</span>
  {/if}
  {delimiter}<span class="path-separator">/</span>{/delimiter}
  {/foreach}
  </p>
  <!-- Path content: END -->