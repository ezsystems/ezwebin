{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h4>{'Design'|i18n( 'design/admin/parts/visual/menu' )}</h4>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">

{section show=eq( $ui_context, 'edit' )}

<ul>
    <li><div><span class="disabled">{'Setup'|i18n( 'design/admin/parts/visual/menu' )}</span></div></li>
    <li><div><span class="disabled">{'Sitestyle'|i18n( 'design/admin/parts/visual/menu' )}</span></div></li>
    <li><div><span class="disabled">{'Menu management'|i18n( 'design/admin/parts/visual/menu' )}</span></div></li>
    <li><div><span class="disabled">{'Toolbar management'|i18n( 'design/admin/parts/visual/menu' )}</span></div></li>
    <li><div><span class="disabled">{'Packages'|i18n( 'design/admin/parts/setup/menu' )}</span></div></li>
    <li><div><span class="disabled">{'Languages'|i18n( 'design/admin/parts/setup/menu' )}</span></div></li>
</ul>

{section-else}

<ul>
    <li><div><a href={'/settings/view'|ezurl}>{'Setup'|i18n( 'design/admin/parts/visual/menu' )}</a></div></li>
    <li><div><a href={'/ezpldesign/sitestyle/'|ezurl}>{'Sitestyle'|i18n( 'design/admin/parts/visual/menu' )}</a></div></li>
    <li><div><a href={'/visual/menuconfig/'|ezurl}>{'Menu management'|i18n( 'design/admin/parts/visual/menu' )}</a></div></li>
    <li><div><a href={'/visual/toolbarlist/'|ezurl}>{'Toolbar management'|i18n( 'design/admin/parts/visual/menu' )}</a></div></li>
    <li><div><a href={'/package/list/'|ezurl}>{'Packages'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
    <li><div><a href={'/ezpldesign/translations/'|ezurl}>{'Languages'|i18n( 'design/admin/parts/setup/menu' )}</a></div></li>
</ul>

{/section}

{* DESIGN: Content END *}</div></div></div></div></div></div>

{* Documentation *}
{switch match=$module_result.ui_component}

{case match='menuconfig'}
{include uri='design:parts/lightning/menuconfig_doc.tpl'}
{/case}

{case match='toolbarlist'}
{include uri='design:parts/lightning/toolbarlist_doc.tpl'}
{/case}

{case match='package'}
{include uri='design:parts/lightning/package_doc.tpl'}
{/case}

{case /}

{/switch}
