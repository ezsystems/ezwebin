<div id="logo">
{if $pagedesign.data_map.image.content.is_valid|not()}
    <h1><a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')|wash}">{ezini('SiteSettings','SiteName')|wash}</a></h1>
{else}
    <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')|wash}"><img src={$pagedesign.data_map.image.content[original].full_path|ezroot} alt="{$pagedesign.data_map.image.content[original].text}" width="{$pagedesign.data_map.image.content[original].width}" height="{$pagedesign.data_map.image.content[original].height}" /></a>
{/if}
</div>