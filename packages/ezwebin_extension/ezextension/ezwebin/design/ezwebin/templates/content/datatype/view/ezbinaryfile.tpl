{if is_unset( $icon_size )}{def $icon_size = 'normal'}{/if}
{if is_unset( $icon_title )}{def $icon_title = $attribute.content.mime_type}{/if}
{if is_unset( $icon )}{def $icon = 'no'}{/if}
{if $attribute.has_content}
{if $attribute.content}
{switch match=$icon}
    {case match='no'}
        <a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl}>{$attribute.content.original_filename|wash( xhtml )}</a> {$attribute.content.filesize|si( byte )}
    {/case}
    {case}
        <a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl}>{$attribute.content.mime_type|mimetype_icon( $icon_size, $icon_title )} {$attribute.content.original_filename|wash( xhtml )}</a> {$attribute.content.filesize|si( byte )}
    {/case}
{/switch}
{else}
    <div class="message-error"><h2>{'The file could not be found.'|i18n( 'design/ezwebin/view/ezbinaryfile' )}</h2></div>
{/if}
{/if}
