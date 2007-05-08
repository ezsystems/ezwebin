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

function eZSiteCommonINISettings( $parameters )
{
    $settings = array();
    $settings[] = eZCommonSiteINISettings( $parameters );
    $settings[] = eZCommonContentINISettings( $parameters );
    $settings[] = eZCommonMenuINISettings( $parameters );
    $settings[] = eZCommonViewCacheINISettings( $parameters );
    $settings[] = eZCommonForumINISettings( $parameters );
    return $settings;
}

function eZCommonSiteINISettings( $parameters )
{
    //setup vars
    $settings = array();
    $setupData = loadSetupData( $parameters );

    //set settings  ps: array_merge only accepts array parameters in PHP 5
    $settings['SiteAccessSettings'] = array( 'AvailableSiteAccessList' => $setupData['allSiteaccesses'] );

    $settings['SiteSettings'] = array( 'SiteList' => $setupData['allSiteaccesses'],
                                       'DefaultAccess' => $setupData['primaryLanguage'],
                                       'RootNodeDepth' => 1 );

    $settings['ExtensionSettings'] = array( 'ActiveExtensions' => $setupData['extensionsToActivate'] );
    $settings['UserSettings'] = array( 'LogoutRedirect' => '/' );
    $settings['EmbedViewModeSettings'] = array( 'AvailableViewModes' => array( 'embed',
                                                                               'embed-inline'),
                                                'InlineViewModes' => array ( 'embed-inline') );

    return array( 'name' => 'site.ini',
                  'settings' => $settings );
}


function eZCommonMenuINISettings( $parameters )
{
    //setup vars
    $settings = array();

    //comment out the line below in order to unlock all menus in ministration interface
    //$settings['TopAdminMenu'] = array( 'Tabs' => array( 'content', 'media', 'shop', 'my_account') );
    return array( 'name' => 'menu.ini',
                  'reset_arrays' => true,
                  'settings' => $settings );
}


function eZCommonContentINISettings( $parameters )
{
    $settings = array( 'object' => array( 'AvailableClasses' => array( '0' => 'itemized_sub_items',
                                                                       '1' => 'itemized_subtree_items',
                                                                       '2' => 'highlighted_object',
                                                                       '3' => 'vertically_listed_sub_items',
                                                                       '4' => 'horizontally_listed_sub_items' ),
                                          'ClassDescription' => array( 'itemized_sub_items' => 'Itemized Sub Items',
                                                                       'itemized_subtree_items' => 'Itemized Subtree Items',
                                                                       'highlighted_object' => 'Highlighted Object',
                                                                       'vertically_listed_sub_items' => 'Vertically Listed Sub Items',
                                                                       'horizontally_listed_sub_items' => 'Horizontally Listed Sub Items' ),
                                          'CustomAttributes' => array( '0' => 'offset',
                                                                       '1' => 'limit' ),
                                          'CustomAttributesDefaults' => array( 'offset' => '0',
                                                                               'limit' => '5' ) ),
                       'embed'=> array( 'AvailableClasses' => array( '0' => 'itemized_sub_items',
                                                                     '1' => 'itemized_subtree_items',
                                                                     '2' => 'highlighted_object',
                                                                     '3' => 'vertically_listed_sub_items',
                                                                     '4' => 'horizontally_listed_sub_items' ),
                                        'ClassDescription' => array( 'itemized_sub_items' => 'Itemized Sub Items',
                                                                     'itemized_subtree_items' => 'Itemized Subtree Items',
                                                                     'highlighted_object' => 'Highlighted Object',
                                                                     'vertically_listed_sub_items' => 'Vertically Listed Sub Items',
                                                                     'horizontally_listed_sub_items' => 'Horizontally Listed Sub Items' ),
                                        'CustomAttributes' => array( '0' => 'offset',
                                                                     '1' => 'limit' ),
                                        'CustomAttributesDefaults' => array( 'offset' => '0',
                                                                             'limit' => '5' ) ),
                       'table'=>
array(
'AvailableClasses'=>
array(
'0'=>'list',
'1'=>'cols',
'2'=>'comparison',
'3'=>'default'
),
'ClassDescription'=>
array(
'list'=>'List',
'cols'=>'Timetable',
'comparison'=>'Comparison Table',
'default'=>'Default'
),
'Defaults'=>
array(
'rows'=>'2',
'cols'=>'2',
'width'=>'100%',
'border'=>'0',
'class'=>'default'
)
),
'factbox'=>
array(
'CustomAttributes'=>
array(
'0'=>'align',
'1'=>'title'
),
'CustomAttributesDefaults'=>
array(
'align'=>'right',
'title'=>'factbox'
)
),
'quote'=>
array(
'CustomAttributes'=>
array(
'0'=>'align',
'1'=>'author'
),
'CustomAttributesDefaults'=>
array(
'align'=>'right',
'autor'=>'Quote author'
)
)
);//end root paranthesis

    return array( 'name' => 'content.ini',
                  'settings' => $settings );
}//end function

function eZCommonViewCacheINISettings( $parameters )
{
    return array( 'name' => 'viewcache.ini',
                  'settings' => array( 'ViewCacheSettings'=>
array(
'SmartCacheClear'=>'enabled'
),
'forum_reply' => array( 'DependentClassIdentifier' => array( 'forum_topic', 'forum' ),
                        'ClearCacheMethod' => array( '0' => 'object', '1' => 'parent', '2' => 'relating', '3' => 'siblings') ),

'forum_topic' => array( 'DependentClassIdentifier' => array( 'forum' ),
                        'ClearCacheMethod' => array( '0' => 'object', '1' => 'parent', '2' => 'relating', '3' => 'siblings') ),

'folder'=> array( 'DependentClassIdentifier'=> array( '0'=>'folder' ),
                  'ClearCacheMethod'=> array( '0'=>'object', '1'=>'parent', '2'=>'relating' ) ),
'gallery'=>
array(
'DependentClassIdentifier'=>
array(
'0'=>'folder'
),
'ClearCacheMethod'=>
array(
'0'=>'object',
'1'=>'parent',
'2'=>'relating'
)
),
'image'=>
array(
'DependentClassIdentifier'=>
array(
'0'=>'gallery'
),
'ClearCacheMethod'=>
array(
'0'=>'object',
'1'=>'parent',
'2'=>'relating',
'3'=>'siblings'
)
),
'event'=>
array(
'DependentClassIdentifier'=>
array(
'0'=>'event_calender'
),
'ClearCacheMethod'=>
array(
'0'=>'object',
'1'=>'parent',
'2'=>'relating'
)
),
'article'=>
array(
'DependentClassIdentifier'=>
array(
'0'=>'folder'
),
'ClearCacheMethod'=>
array(
'0'=>'object',
'1'=>'parent',
'2'=>'relating'
)
),
'product'=>
array(
'DependentClassIdentifier'=>
array(
'0'=>'folder',
'1'=>'frontpage'
),
'ClearCacheMethod'=>
array(
'0'=>'object',
'1'=>'parent',
'2'=>'relating'
)
),
'infobox'=>
array(
'DependentClassIdentifier'=>
array(
'0'=>'folder'
),
'ClearCacheMethod'=>
array(
'0'=>'object',
'1'=>'parent',
'2'=>'relating'
)
),
'documentation_page'=>
array(
'DependentClassIdentifier'=>
array(
'0'=>'documentation_page'
),
'ClearCacheMethod'=>
array(
'0'=>'object',
'1'=>'parent',
'2'=>'relating'
)
),
'banner'=>
array(
'DependentClassIdentifier'=>
array(
'0'=>'frontpage'
),
'ClearCacheMethod'=>
array(
'0'=>'object',
'1'=>'parent',
'2'=>'relating'
)
)
)
);//close root paranthesis

}//end function


function eZCommonForumINISettings( $parameters )
{
    //setup vars
    $settings = array();

    $settings['ForumSettings'] = array( 'StickyUserGroupArray' => array( 12 ) );

    return array( 'name' => 'forum.ini',
                  'reset_arrays' => false,
                  'settings' => $settings );
}//end function


?>
