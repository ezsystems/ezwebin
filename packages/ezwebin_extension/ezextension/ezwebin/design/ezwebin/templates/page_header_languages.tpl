<div id="languages">
    {if and( is_set($DesignKeys:used.url_alias), $DesignKeys:used.url_alias|count|ge(1) )}
        {def $availTranslation=language_switcher( $DesignKeys:used.url_alias )}
    {else}
        {def $availTranslation=language_switcher( $site.uri.original_uri)}
    {/if}
    {foreach $availTranslation as $lang}
        <a href={$lang.url|ezurl}>{$lang.text|wash}</a>
    {/foreach}
</div>