{default enable_print=true()}

<link rel="Home" href={"/"|ezurl} title="{'%sitetitle front page'|i18n('design/standard/layout',,hash('%sitetitle',$site.title))}" />
<link rel="Index" href={"/"|ezurl} />
<link rel="Top"  href={"/"|ezurl} title="{$site_title}" />
<link rel="Search" href={"content/advancedsearch"|ezurl} title="{'Search %sitetitle'|i18n('design/standard/layout',,hash('%sitetitle',$site.title))}" />
<link rel="Shortcut icon" href={"favicon.ico"|ezimage} type="image/x-icon" />
<link rel="Copyright" href={"/ezinfo/copyright"|ezurl} />
<link rel="Author" href={"/ezinfo/about"|ezurl} />
<link rel="alternate" type="application/rss+xml" title="RSS" href="{fetch_alias( 'by_identifier', hash( 'attr_id', 'sitestyle_identifier' ) ).data_map.rss_feed.data_text}" />

{if $enable_print}
<link rel="Alternate" href={concat("layout/set/print/",$site.uri.original_uri)|ezurl} media="print" title="{'Printable version'|i18n('design/standard/layout')}" />
{/if}

{/default}