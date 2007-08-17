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

function eZSiteINISettings( $parameters )
{
    $parameters = array_merge( $parameters,
                               array( 'is_admin' => false ) );
    $setupData = loadSetupData( $parameters );

    $settings = array();
    $settings[] = eZSiteMenuINISettings();
    $settings[] = eZSiteOverrideINISettings();
    $settings[] = eZSiteToolbarINISettings( $parameters );
    $settings[] = eZSiteSiteINISettings( $setupData );
    $settings[] = eZSiteImageINISettings();
    $settings[] = eZSiteContentINISettings( $parameters );
    $settings[] = eZSiteDesignINISettings( $parameters );
    $settings[] = eZSiteBrowseINISettings( $parameters );
    $settings[] = eZSiteTemplateINISettings( $parameters );
    //$settings[] = eZSiteIconINISettings( $parameters );

    $settings[] = eZSiteContentStructureMenuINISettings();

    return $settings;
}

function eZSiteSiteINISettings( $setupData )
{
    $settings = array();

    $settings['RegionalSettings'] = array( 'ShowUntranslatedObjects' => 'disabled' );

    $settings['SiteAccessSettings'] = array( 'RequireUserLogin' => 'false',
                                             'ShowHiddenNodes' => 'false' );

    $settings['SiteSettings'] = array( 'LoginPage' => 'embedded',
                                       'AdditionalLoginFormActionURL' => $setupData['siteaccessURLs']['admin_url'] . '/user/login' );

    $settings['DesignSettings'] = array( 'SiteDesign' => $setupData['mainSiteDesign'] );

    $settings['Session'] = array( 'SessionNamePerSiteAccess' => 'disabled' );

    return array( 'name' => 'site.ini',
                  'settings' => $settings );
}


function eZSiteDesignINISettings()
{
    $settings =  array(
        'name' => 'design.ini',
        'reset_arrays' => false,
        'settings' => array(
            'JavaScriptSettings' => array(
                'JavaScriptList' => array(
                    'insertmedia.js' )
                )
            )
        );
    return $settings;
}

function eZSiteContentStructureMenuINISettings()
{
    $contentStructureMenu =  array(
        'name' => 'contentstructuremenu.ini',
        'reset_arrays' => true,
        'settings' => array(
            'TreeMenu' => array(
                'ShowClasses' => array(
                    'folder',
                    'documentation_page',
                    'frontpage',
                    'forums'
                    ),
                'ToolTips' => 'disabled'
                )
            )
        );
    return $contentStructureMenu;
}

function eZSiteMenuINISettings()
{
    return array( 'name' => 'menu.ini',
                  'reset_arrays' => true,
                  'settings' => array( 'MenuSettings' => array( 'AvailableMenuArray' => array( 'TopOnly',
                                                                                               'LeftOnly',
                                                                                               'DoubleTop',
                                                                                               'LeftTop' ) ),
                                       'SelectedMenu' => array( 'CurrentMenu' => 'LeftTop',
                                                                'TopMenu' => 'flat_top',
                                                                'LeftMenu' => 'flat_left' ),
                                       'TopOnly' => array( 'TitleText' => 'Only top menu',
                                                           'MenuThumbnail' => 'menu/top_only.jpg',
                                                           'TopMenu' => 'flat_top',
                                                           'LeftMenu' => '' ),
                                       'LeftOnly' => array( 'TitleText' => 'Left menu',
                                                           'MenuThumbnail' => 'menu/left_only.jpg',
                                                           'TopMenu' => '',
                                                           'LeftMenu' => 'flat_left' ),
                                       'DoubleTop' => array( 'TitleText' => 'Double top menu',
                                                             'MenuThumbnail' => 'menu/double_top.jpg',
                                                             'TopMenu' => 'double_top',
                                                             'LeftMenu' => '' ),
                                       'LeftTop' => array( 'TitleText' => 'Left and top',
                                                             'MenuThumbnail' => 'menu/left_top.jpg',
                                                             'TopMenu' => 'flat_top',
                                                             'LeftMenu' => 'flat_left' ),
                                       'MenuContentSettings' => array( 'TopIdentifierList'  => array( 'folder', 'feedback_form' ),
                                                                       'LeftIdentifierList' => array( 'folder', 'feedback_form' ) )

                                       ) );
}

function eZSiteOverrideINISettings()
{
    return array (
        'name' => 'override.ini',
        'settings' =>
        array (
'full_article'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/article.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'article'
)
),
'full_article_mainpage'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/article_mainpage.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'article_mainpage'
)
),
'full_article_subpage'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/article_subpage.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'article_subpage'
)
),
'full_banner'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/banner.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'banner'
)
),
'full_blog'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/blog.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'blog'
)
),
'full_blog_post'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/blog_post.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'blog_post'
)
),
'full_comment'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/comment.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'comment'
)
),
'full_documentation_page'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/documentation_page.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'documentation_page'
)
),
'full_event_calendar'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/event_calendar.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'event_calendar'
)
),
'full_event'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/event.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'event'
)
),
'full_feedback_form'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/feedback_form.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'feedback_form'
)
),
'full_file'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/file.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'file'
)
),
'full_flash'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/flash.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'flash'
)
),
'full_folder'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/folder.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'folder'
)
),
'full_forum'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/forum.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forum'
)
),
'full_forum_reply'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/forum_reply.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forum_reply'
)
),
'full_forum_topic'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/forum_topic.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forum_topic'
)
),
'full_forums'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/forums.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forums'
)
),
'full_frontpage'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/frontpage.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'frontpage'
)
),
'full_gallery'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/gallery.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'gallery'
)
),
'full_image'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/image.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'image'
)
),
'full_infobox'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/infobox.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'infobox'
)
),
'full_link'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/link.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'link'
)
),
'full_multicalendar'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/multicalendar.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'multicalendar'
)
),
'full_poll'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/poll.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'poll'
)
),
'full_product'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/product.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'product'
)
),
'full_quicktime'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/quicktime.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'quicktime'
)
),
'full_real_video'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/real_video.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'real_video'
)
),
'full_windows_media'=>
array(
'Source'=>'node/view/full.tpl',
'MatchFile'=>'full/windows_media.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'windows_media'
)
),
'line_article'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/article.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'article'
)
),
'line_article_mainpage'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/article_mainpage.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'article_mainpage'
)
),
'line_article_subpage'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/article_subpage.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'article_subpage'
)
),
'line_banner'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/banner.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'banner'
)
),
'line_blog'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/blog.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'blog'
)
),
'line_blog_post'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/blog_post.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'blog_post'
)
),
'line_comment'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/comment.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'comment'
)
),
'line_documentation_page'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/documentation_page.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'documentation_page'
)
),
'line_event_calendar'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/event_calendar.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'event_calendar'
)
),
'line_event'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/event.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'event'
)
),
'line_feedback_form'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/feedback_form.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'feedback_form'
)
),
'line_file'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/file.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'file'
)
),
'line_flash'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/flash.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'flash'
)
),
'line_folder'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/folder.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'folder'
)
),
'line_forum'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/forum.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forum'
)
),
'line_forum_reply'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/forum_reply.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forum_reply'
)
),
'line_forum_topic'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/forum_topic.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forum_topic'
)
),
'line_forums'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/forums.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forums'
)
),
'line_gallery'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/gallery.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'gallery'
)
),
'line_image'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/image.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'image'
)
),
'line_infobox'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/infobox.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'infobox'
)
),
'line_link'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/link.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'link'
)
),
'line_multicalendar'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/multicalendar.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'multicalendar'
)
),
'line_poll'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/poll.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'poll'
)
),
'line_product'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/product.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'product'
)
),
'line_quicktime'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/quicktime.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'quicktime'
)
),
'line_real_video'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/real_video.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'real_video'
)
),
'line_windows_media'=>
array(
'Source'=>'node/view/line.tpl',
'MatchFile'=>'line/windows_media.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'windows_media'
)
),
'edit_comment'=>
array(
'Source'=>'content/edit.tpl',
'MatchFile'=>'edit/comment.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'comment'
)
),
'edit_file'=>
array(
'Source'=>'content/edit.tpl',
'MatchFile'=>'edit/file.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'file'
)
),
'edit_forum_topic'=>
array(
'Source'=>'content/edit.tpl',
'MatchFile'=>'edit/forum_topic.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forum_topic'
)
),
'edit_forum_reply'=>
array(
'Source'=>'content/edit.tpl',
'MatchFile'=>'edit/forum_reply.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forum_reply'
)
),
'highlighted_object'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/highlighted_object.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'classification'=>'highlighted_object'
)
),
'embed_article'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/article.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'article'
)
),
'embed_banner'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/banner.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'banner'
)
),
'embed_file'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/file.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'file'
)
),
'embed_flash'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/flash.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'flash'
)
),
'itemized_sub_items'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/itemized_sub_items.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'classification'=>'itemized_sub_items'
)
),
'vertically_listed_sub_items'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/vertically_listed_sub_items.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'classification'=>'vertically_listed_sub_items'
)
),
'horizontally_listed_sub_items'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/horizontally_listed_sub_items.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'classification'=>'horizontally_listed_sub_items'
)
),
'itemized_subtree_items'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/itemized_subtree_items.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'classification'=>'itemized_subtree_items'
)
),
'embed_folder'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/folder.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'folder'
)
),
'embed_forum'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/forum.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forum'
)
),
'embed_gallery'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/gallery.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'gallery'
)
),
'embed_image'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/image.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'image'
)
),
'tiny_image' =>
array (
'Source' => 'content/view/tiny.tpl',
'MatchFile' => 'tiny_image.tpl',
'Subdir' => 'templates',
'Match' =>
array (
'class_identifier' => 'image',
)
),
'embed_poll'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/poll.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'poll'
)
),
'embed_product'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/product.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'product'
)
),
'embed_quicktime'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/quicktime.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'quicktime'
)
),
'embed_real_video'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/real_video.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'real_video'
)
),
'embed_windows_media'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/windows_media.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'windows_media'
)
),
'embed_inline_image'=>
array(
'Source'=>'content/view/embed-inline.tpl',
'MatchFile'=>'embed-inline/image.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'image'
)
),
'embed_itemizedsubitems_gallery'=>
array(
'Source'=>'content/view/itemizedsubitems.tpl',
'MatchFile'=>'itemizedsubitems/gallery.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'gallery'
)
),
'embed_itemizedsubitems_forum'=>
array(
'Source'=>'content/view/itemizedsubitems.tpl',
'MatchFile'=>'itemizedsubitems/forum.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'forum'
)
),
'embed_itemizedsubitems_folder'=>
array(
'Source'=>'content/view/itemizedsubitems.tpl',
'MatchFile'=>'itemizedsubitems/folder.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'folder'
)
),
'embed_itemizedsubitems_event_calendar'=>
array(
'Source'=>'content/view/itemizedsubitems.tpl',
'MatchFile'=>'itemizedsubitems/event_calendar.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'event_calendar'
)
),
'embed_itemizedsubitems_documentation_page'=>
array(
'Source'=>'content/view/itemizedsubitems.tpl',
'MatchFile'=>'itemizedsubitems/documentation_page.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'documentation_page'
)
),
'embed_itemizedsubitems_itemized_sub_items'=>
array(
'Source'=>'content/view/itemizedsubitems.tpl',
'MatchFile'=>'itemizedsubitems/itemized_sub_items.tpl',
'Subdir'=>'templates'
),
'embed_event_calendar'=>
array(
'Source'=>'content/view/embed.tpl',
'MatchFile'=>'embed/event_calendar.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'event_calendar'
)
),
'embed_horizontallylistedsubitems_article'=>
array(
'Source'=>'node/view/horizontallylistedsubitems.tpl',
'MatchFile'=>'horizontallylistedsubitems/article.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'article'
)
),
'embed_horizontallylistedsubitems_event'=>
array(
'Source'=>'node/view/horizontallylistedsubitems.tpl',
'MatchFile'=>'horizontallylistedsubitems/event.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'event'
)
),
'embed_horizontallylistedsubitems_image'=>
array(
'Source'=>'node/view/horizontallylistedsubitems.tpl',
'MatchFile'=>'horizontallylistedsubitems/image.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'image'
)
),
'embed_horizontallylistedsubitems_product'=>
array(
'Source'=>'node/view/horizontallylistedsubitems.tpl',
'MatchFile'=>'horizontallylistedsubitems/product.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'product'
)
),
'factbox'=>
array(
'Source'=>'content/datatype/view/ezxmltags/factbox.tpl',
'MatchFile'=>'datatype/ezxmltext/factbox.tpl',
'Subdir'=>'templates'
),
'quote'=>
array(
'Source'=>'content/datatype/view/ezxmltags/quote.tpl',
'MatchFile'=>'datatype/ezxmltext/quote.tpl',
'Subdir'=>'templates'
),
'table_cols'=>
array(
'Source'=>'content/datatype/view/ezxmltags/table.tpl',
'MatchFile'=>'datatype/ezxmltext/table_cols.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'classification'=>'cols'
)
),
'table_comparison'=>
array(
'Source'=>'content/datatype/view/ezxmltags/table.tpl',
'MatchFile'=>'datatype/ezxmltext/table_comparison.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'classification'=>'comparison'
)
),
'image_galleryline'=>
array(
'Source'=>'node/view/galleryline.tpl',
'MatchFile'=>'galleryline/image.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'image'
)
),
'image_galleryslide'=>
array(
'Source'=>'node/view/galleryslide.tpl',
'MatchFile'=>'galleryslide/image.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'image'
)
),
'article_listitem'=>
array(
'Source'=>'node/view/listitem.tpl',
'MatchFile'=>'listitem/article.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'article'
)
),
'image_listitem'=>
array(
'Source'=>'node/view/listitem.tpl',
'MatchFile'=>'listitem/image.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'image'
)
),
'billboard_banner'=>
array(
'Source'=>'content/view/billboard.tpl',
'MatchFile'=>'billboard/banner.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'banner'
)
),
'billboard_flash'=>
array(
'Source'=>'content/view/billboard.tpl',
'MatchFile'=>'billboard/flash.tpl',
'Subdir'=>'templates',
'Match'=>
array(
'class_identifier'=>'flash'
)
)


            )
        );
}

function eZSiteToolbarINISettings( $parameters )
{
    $toolbar = array( 'name' => 'toolbar.ini',
                  'reset_arrays' => true,
                  'settings' => array( 'Toolbar_right' => array( 'Tool' => array( 'node_list' ) ),
                                       'Toolbar_top' => array( 'Tool' => array( 'login', 'searchbox' ) ),
                                       'Toolbar_bottom' => array( 'Tool' => array() ),
                                       'Tool_right_node_list_1' => array( 'parent_node' => '2',
                                                                          'title' => 'Latest',
                                                                          'show_subtree' => '',
                                                                          'limit' => 5 ) ) );
    return $toolbar;
}



function eZSiteImageINISettings()
{
    $settings = array( 'name' => 'image.ini',
                       'reset_arrays' => true,
                       'settings' => array(
                           'AliasSettings'=>
array(
'AliasList'=>
array(
'0'=>'small',
'1'=>'medium',
'2'=>'listitem',
'3'=>'articleimage',
'4'=>'articlethumbnail',
'5'=>'gallerythumbnail',
'6'=>'galleryline',
'7'=>'imagelarge',
'8'=>'large',
'9'=>'rss',
'10'=>'infoboximage',
'11'=>'billboard'
)
),
'small'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scaledownonly=100;160'
)
),
'medium'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scaledownonly=200;290'
)
),
'large'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scaledownonly=360;440'
)
),
'rss'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scale=88;31'
)
),
'listitem'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scaledownonly=130;190'
)
),
'articleimage'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scaledownonly=170;350'
)
),
'articlethumbnail'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scaledownonly=70;150'
)
),
'gallerythumbnail'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scaledownonly=105;100'
)
),
'galleryline'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scaledownonly=70;150'
)
),
'imagelarge'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scaledownonly=550;730'
)
),
'infoboximage'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scalewidth=75'
)
),
'billboard'=>
array(
'Reference'=>'',
'Filters'=>
array(
'0'=>'geometry/scalewidth=764'
)
)
                                         ) );
    return $settings;
}


function eZSiteContentINISettings( $parameters )
{
    $designList = $parameters['design_list'];
    $settings = array( 'name' => 'content.ini',
                    'reset_arrays' => false,
                    'settings' => array( 'VersionView' => array( 'AvailableSiteDesignList' => array( "ezwebin" ) ),
                                         'ObjectRelationDataTypeSettings' => array( 'ClassAttributeStartNode' => array( '236;AddRelatedBannerImageToDataType' ) ) ) );

    return $settings;
}

function eZSiteBrowseINISettings( $parameters )
{
    $settings = array( 'name' => 'browse.ini',
                       'reset_arrays' => false,
                       'settings' => array( 'BrowseSettings' => array( 'AliasList' => array( 'banners' => '59' ) ),
                                            'AddRelatedBannerImageToDataType' => array( 'StartNode' => 'banners',
                                                                                        'SelectionType' => 'single',
                                                                                        'ReturnType' => 'ObjectID' ) ) );

    return $settings;
}


function eZSiteTemplateINISettings( $parameters )
{
    $settings = array( 'name' => 'template.ini',
                       'settings' => array( 'CharsetSettings' => array( 'DefaultTemplateCharset' => 'utf-8' ) ) );

    return $settings;
}

?>
