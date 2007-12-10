<div class="object-{if is_set($align)}{$align}{else}left{/if}">
    <div class="quote">
      <div class="quote-design">
      <div class="quote-begin"><span class="hide">"</span></div>
      {$content}
      {if is_set( $author )}<p class="author">{$author}</p>{/if}
      <div class="quote-end"><span class="hide">"</span></div>
      </div>
   </div>
</div>