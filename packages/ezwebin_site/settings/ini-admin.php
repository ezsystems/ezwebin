<?php
//
// Created on: <11-Jan-2006 18:52:01 ks>
//
// Copyright (C) 1999-2006 eZ systems as. All rights reserved.
//
// This source file is part of the eZ publish (tm) Open Source Content
// Management System.
//
// This file may be distributed and/or modified under the terms of the
// "GNU General Public License" version 2 as published by the Free
// Software Foundation and appearing in the file LICENSE included in
// the packaging of this file.
//
// Licencees holding a valid "eZ publish professional licence" version 2
// may use this file in accordance with the "eZ publish professional licence"
// version 2 Agreement provided with the Software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
// THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE.
//
// The "eZ publish professional licence" version 2 is available at
// http://ez.no/ez_publish/licences/professional/ and in the file
// PROFESSIONAL_LICENCE included in the packaging of this file.
// For pricing of this licence please contact us via e-mail to licence@ez.no.
// Further contact information is available at http://ez.no/company/contact/.
//
// The "GNU General Public License" (GPL) is available at
// http://www.gnu.org/copyleft/gpl.html.
//
// Contact licence@ez.no if any conditions of this licencing isn't clear to
// you.
//

function eZSiteAdminINISettings( $parameters )
{
    $parameters = array_merge( $parameters,
                               array( 'is_admin' => true ) );
    $settings = array();
    $settings[] = eZSiteAdminToolbarINISettings();
    $settings[] = eZSiteAdminContentStructureMenuINISettings();
    $settings[] = eZSiteAdminOverrideINISettings();
    $settings[] = eZSiteAdminSiteINISettings();
    $settings[] = eZSiteAdminContentINISettings( $parameters );
    $settings[] = eZSiteAdminIconINISettings();
    $settings[] = eZSiteAdminViewCacheINISettings();
    $settings[] = eZSiteAdminODFINISettings();

    return $settings;
}

function eZSiteAdminContentStructureMenuINISettings()
{
    $contentStructureMenu =  array(
        'name' => 'contentstructuremenu.ini',
        'reset_arrays' => true,
        'settings' => array(
							'TreeMenu' => array(
												'ShowClasses' => array(
																		'folder',
																		'user_group',
																		'documentation_page',
																		'event_calender',
																		'frontpage',
																		'forums'
																		) ) )
        );
    return $contentStructureMenu;
}

function eZSiteAdminToolbarINISettings()
{
    $toolbar = array (
        'name' => 'toolbar.ini',
        'reset_arrays' => true,
        'settings' =>
        array (
            'Toolbar' =>
            array (
                'AvailableToolBarArray' =>
                array (
                    0 => 'setup',
                    1 => 'admin_right',
                    2 => 'admin_developer'
                    ),
                ),
            'Tool' =>
            array (
                'AvailableToolArray' =>
                array (
                    0 => 'setup_link',
                    1 => 'admin_current_user',
                    2 => 'admin_bookmarks',
                    3 => 'admin_clear_cache',
                    4 => 'admin_quick_settings',
                    ),
                ),
            'Toolbar_setup' =>
            array (
                'Tool' =>
                array (
                    0 => 'setup_link',
                    1 => 'setup_link',
                    2 => 'setup_link',
                    3 => 'setup_link',
                    4 => 'setup_link',
                    ),
                ),
            'Toolbar_admin_right' =>
            array (
                'Tool' =>
                array (
                    0 => 'admin_current_user',
                    1 => 'admin_bookmarks',
                    ),
                ),
            'Toolbar_admin_developer' =>
            array (
                'Tool' =>
                array (
                    0 => 'admin_clear_cache',
                    1 => 'admin_quick_settings',
                    ),
                ),
            'Tool_setup_link' =>
            array (
                'title' => '',
                'link_icon' => '',
                'url' => '',
                ),
            'Tool_setup_link_description' =>
            array (
                'title' => 'Title',
                'link_icon' => 'Icon',
                'url' => 'URL',
                ),
            'Tool_setup_setup_link_1' =>
            array (
                'title' => 'Classes',
                'link_icon' => 'classes.png',
                'url' => '/class/grouplist',
                ),
            'Tool_setup_setup_link_2' =>
            array (
                'title' => 'Cache',
                'link_icon' => 'cache.png',
                'url' => '/setup/cache',
                ),
            'Tool_setup_setup_link_3' =>
            array (
                'title' => 'URL translator',
                'link_icon' => 'url_translator.png',
                'url' => '/content/urltranslator',
                ),
            'Tool_setup_setup_link_4' =>
            array (
                'title' => 'Settings',
                'link_icon' => 'common_ini_settings.png',
                'url' => '/content/edit/52',
                ),
            'Tool_setup_setup_link_5' =>
            array (
                'title' => 'Look and feel',
                'link_icon' => 'look_and_feel.png',
                'url' => '/content/edit/54',
                ),
            ),
             );
    return $toolbar;
}

function eZSiteAdminOverrideINISettings()
{
    return array (
        'name' => 'override.ini',
        'settings' =>
        array (
            'article' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/article.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'article',
                    ),
                ),
            'comment' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/comment.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'comment',
                    ),
                ),
            'company' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/company.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'company',
                    ),
                ),
            'feedback_form' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/feedback_form.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'feedback_form',
                    ),
                ),
            'file' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/file.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'file',
                    ),
                ),
            'flash' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/flash.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'flash',
                    ),
                ),
            'folder' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/folder.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'folder',
                    ),
                ),
            'forum' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/forum.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'forum',
                    ),
                ),
            'forum_topic' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/forum_topic.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'forum_topic',
                    ),
                ),
            'forum_reply' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/forum_reply.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'forum_reply',
                    ),
                ),
            'gallery' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/gallery.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'gallery',
                    ),
                ),
            'image' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/image.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'image',
                    ),
                ),
            'link' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/link.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'link',
                    ),
                ),
            'person' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/person.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'person',
                    ),
                ),
            'poll' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/poll.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'poll',
                    ),
                ),
            'product' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/product.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'product',
                    ),
                ),
            'review' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/review.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'review',
                    ),
                ),
            'quicktime' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/quicktime.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'quicktime',
                    ),
                ),
            'real_video' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/real_video.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'real_video',
                    ),
                ),
            'weblog' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/weblog.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'weblog',
                    ),
                ),
            'windows_media' =>
            array (
                'Source' => 'node/view/admin_preview.tpl',
                'MatchFile' => 'admin_preview/windows_media.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'windows_media',
                    ),
                ),
            'thumbnail_image' =>
            array (
                'Source' => 'node/view/thumbnail.tpl',
                'MatchFile' => 'thumbnail/image.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'image',
                    ),
                ),
            'window_controls' =>
            array (
                'Source' => 'window_controls.tpl',
                'MatchFile' => 'window_controls_user.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'navigation_part_identifier' => 'ezusernavigationpart',
                    ),
                ),
            'windows' =>
            array (
                'Source' => 'windows.tpl',
                'MatchFile' => 'windows_user.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'navigation_part_identifier' => 'ezusernavigationpart',
                    ),
                ),
            'embed_image' =>
            array (
                'Source' => 'content/view/embed.tpl',
                'MatchFile' => 'embed_image.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'image',
                    ),
                ),
            'embed-inline_image' =>
            array (
                'Source' => 'content/view/embed-inline.tpl',
                'MatchFile' => 'embed-inline_image.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'image',
                    ),
                ),
            'embed_node_image' =>
            array (
                'Source' => 'node/view/embed.tpl',
                'MatchFile' => 'embed_image.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'image',
                    ),
                ),
            'embed-inline_node_image' =>
            array (
                'Source' => 'node/view/embed-inline.tpl',
                'MatchFile' => 'embed-inline_image.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'image',
                    ),
                ),
            'thumbnail_image_browse' =>
            array (
                'Source' => 'node/view/browse_thumbnail.tpl',
                'MatchFile' => 'thumbnail/image_browse.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'image',
                    ),
                ),
            'thumbnail_banner' =>
            array (
                'Source' => 'node/view/thumbnail.tpl',
                'MatchFile' => 'thumbnail/image.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'banner',
                    )
                ),
            'thumbnail_banner_browse' =>
            array (
                'Source' => 'node/view/browse_thumbnail.tpl',
                'MatchFile' => 'thumbnail/image_browse.tpl',
                'Subdir' => 'templates',
                'Match' =>
                array (
                    'class_identifier' => 'banner',
                    )
                )
            )
        );
}

function eZSiteAdminSiteINISettings()
{
    $settings = array();
    $settings['SiteAccessSettings'] = array( 'RequireUserLogin' => 'true' );
    $settings['SiteSettings'] = array( 'LoginPage' => 'custom' );

    // Make sure viewcaching works in admin with the new admin interface
    $settings['ContentSettings'] = array( 'CachedViewPreferences' => array( 'full' => 'admin_navigation_content=0;admin_navigation_details=0;admin_navigation_languages=0;admin_navigation_locations=0;admin_navigation_relations=0;admin_navigation_roles=0;admin_navigation_policies=0;admin_navigation_content=0;admin_navigation_translations=0;admin_children_viewmode=list;admin_list_limit=1;admin_edit_show_locations=0;admin_leftmenu_width=10;admin_url_list_limit=10;admin_url_view_limit=10;admin_section_list_limit=1;admin_orderlist_sortfield=user_name;admin_orderlist_sortorder=desc;admin_search_stats_limit=1;admin_treemenu=1;admin_bookmarkmenu=1;admin_left_menu_width=13' ) );
    $settings['SiteAccessSettings'] = array_merge( $settings['SiteAccessSettings'], array( 'ShowHiddenNodes' => 'true' ) );

    return array( 'name' => 'site.ini',
                  'settings' => $settings );
}

function eZSiteAdminContentINISettings( $parameters )
{
    $designList = $parameters['design_list'];
    $image = array( 'name' => 'content.ini',
                    'reset_arrays' => true,
                    'settings' => array( 'VersionView' =>
                                         array( 'AvailableSiteDesignList' => $designList ) ) );

    return $image;
}

function eZSiteAdminIconINISettings()
{
    $image = array( 'name' => 'icon.ini',
                    'reset_arrays' => true,
                    'settings' => array( 'IconSettings' => array( 'Theme' => 'crystal-admin',
                                                                      'Size' => 'normal' ) ) );
    return $image;
}

function eZSiteAdminViewCacheINISettings()
{
    return array( 'name' => 'viewcache.ini',
                  'settings' => array( 'ViewCacheSettings' => array( 'SmartCacheClear' => 'enabled' ) ) );
}

function eZSiteAdminODFINISettings()
{
    // note: do not forget to update eZSiteODFINISettings when updating this function

    // update 'article' class attributes info
    $articleExtraAttributes = array( 'caption' => 'caption',
                                     'publish_date' => 'publish_date',
                                     'unpublish_date' => 'unpublish_date' );

    return array( 'name' => 'odf.ini',
                  'settings' => array( 'article' => array( 'Attribute' => $articleExtraAttributes ) ) );
}

?>
