
{default attribute_base=ContentObjectAttribute}
{let package_list=fetch( package, list,
                         hash( filter_array, array( array( type, $attribute.contentclass_attribute.data_text1 ) ) ) )}

{if is_set( ezhttp( 'CurrentSiteAccess', 'post' ) ) }
    {def $current_siteaccess=ezhttp( 'CurrentSiteAccess', 'post' ) }
{else}
    {def $current_siteaccess=ezini( 'SiteSettings', 'DefaultAccess', 'site.ini' ) }
{/if}

{def $CurrentPageStyle=ezini( 'StylesheetSettings', 'PageStyle', 'design.ini', concat( 'settings/siteaccess/', $current_siteaccess ) ) }

<div class="block">
{section name=Package loop=$:package_list}
 <div class="package_element" align="bottom">
      <label for="{$:item.name|wash}"><img class="package-thumbnail" src={$:item|ezpackage( thumbnail )|ezroot} /></label>
      <br />
      <input type="radio" 
             id="{$:item.name|wash}" 
             name="{$attribute_base}_ezpackage_data_text_{$attribute.id}" 
             value="{$:item.name|wash}"
             {section show=eq( $:item.name, $CurrentPageStyle )} checked{/section}
      <label for="{$:item.name|wash}">{$:item.summary|wash}:</label>
 </div>
 {delimiter modulo=4}
    </div>
    <div class="block">
 {/delimiter}
{/section}
</div>

{undef}
{/let}
{/default}


<!-- Can't read from the database, cause it dont support differnet siteaccesses
             {section show=eq( $:item.name, $attribute.data_text )} checked{/section} /> -->
