<div id="languages">
    {if $locales|count|gt( 1 )}
    <ul>
    {foreach $pagedesign.data_map.language_settings.content.rows.sequential as $row}
    {def $site_url = $row.columns[0]
         $language = $row.columns[2]}
    {if $row.columns[0]}
        {set $site_url = $site_url|append( "/" )}
        <li{if $row.columns[1]|downcase()|eq($access_type.name)} class="current_siteaccess"{/if}>
        {if is_set($DesignKeys:used.url_alias)}
            <a href="{concat( "http://", $site_url,
                     $DesignKeys:used.url_alias
                     )}">{$language}</a>
        {else}
            <a href="{concat( "http://", $site_url,
                     $uri_string
                     )}">{$language}</a>
        {/if}
        </li>
    {/if}
    {undef $site_url $language}
    {/foreach}
    </ul>
    {/if}
</div>