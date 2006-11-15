{* Event Calendar - Full view *}
{set-block scope=root variable=cache_ttl}400{/set-block}

{include uri=concat("design:full/event_view_", $node.data_map.view.class_content.options[$node.data_map.view.value[0]].name|downcase(), ".tpl") }