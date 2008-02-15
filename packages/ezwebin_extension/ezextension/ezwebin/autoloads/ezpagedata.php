<?php
//
// Definition of eZPageData class
//
// Created on: <18-Aug-2007 10:49:08 ar>
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Publish
// SOFTWARE RELEASE: 4.0.x
// COPYRIGHT NOTICE: Copyright (C) 1999-2008 eZ Systems AS
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//

/*
 Template operator to speed up page settings and style init time
 Gets its parameters directly from template.
 module_result.path | content_info | persistant_variable | menu.ini ++
 are all used to generate page data, what menues to show
 and so on.  
 
*/

class eZPageData
{
    function eZPageData()
    {
    }

    function operatorList()
    {
        return array( 'ezpagedata' );
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array( 'ezpagedata' => array( 'params' => array( 'type' => 'array',
                                              'required' => false,
                                              'default' => array() ) ) );
    }

    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters )
    {
        switch ( $operatorName )
        {
            case 'ezpagedata':
                {                    
                    $currentNodeId = 0;
                    $pageData       = array();
                    $moduleResult   = array();

                    // Fetching template_look
                    $pageData['template_look']   = false;
                    include_once( 'kernel/classes/ezcontentobjecttreenode.php' );
                    $classID = eZContentObjectTreeNode::classIDByIdentifier( 'template_look' );
                    $obj     = eZContentObject::fetchFilteredList( array( 'contentclass_id' => $classID ), 0, 1 );
                    if ( $obj )
                    {
                       $pageData['template_look'] = $obj[0];
                    }
                    

                    if ( $tpl->hasVariable('module_result') )
                    {
                       $moduleResult = $tpl->variable('module_result');
                    }

                    if ( $tpl->hasVariable('current_node_id') )
                    {
                       $currentNodeId = (int) $tpl->variable('current_node_id');
                    }
                    else if ( isset( $moduleResult['node_id'] ) )
                    {
                       $currentNodeId = (int) $moduleResult['node_id'];
                    }
                    else if ( isset( $moduleResult['path'][count( $moduleResult['path'] ) - 1]['node_id'] ) )
                    {
                       $currentNodeId = (int) $moduleResult['path'][count( $moduleResult['path'] ) - 1]['node_id'];
                    }

                    $pageData['node_id'] = $currentNodeId;
                    $ini             = eZINI::instance( 'site.ini' );
                    $menuIni         = eZINI::instance( 'menu.ini' );
                    $contentIni      = eZINI::instance( 'content.ini' );
                    $uiContext       = $tpl->variable('ui_context');
                    $reqUriString    = $tpl->variable('requested_uri_string');
                    $pageData['is_edit'] = ( $uiContext === 'edit' && strpos($reqUriString, 'user/edit') === false  );
                    $pageData['infobox_count']   = 0;
                    $pageData['page_root_depth'] = 0;
                    $pageData['content_info']    = array();
                    $pageData['page_depth']      = count( $moduleResult['path'] );
                    $pageData['root_node']      = (int) $contentIni->variable( 'NodeSettings', 'RootNode' );

                    /*
                      RootNodeDepth is a setting for letting you have a very simple multisite setup
                      The content of the menues will be the same on all system pages like user/login
                      and when you surf bellow the defined page_root_depth
                      The sites will also share siteaccess and thus also the same ez publish design and templates
                      You can however custimize the design with css using the class on div#page:
                      subtree_level_x_node_id_y class
                      It is recommended to turn it of by setting it to 0 for normal sites                       
                    */
                    if ( $currentNodeId &&
                         isset( $moduleResult['path'][0] ) &&
                         $moduleResult['path'][0]['node_id'] === 2 &&
                         $ini->hasVariable( 'SiteSettings', 'RootNodeDepth' ) &&
                         $ini->variable( 'SiteSettings', 'RootNodeDepth' ) !== '0' )
                    {
                        $pageData['page_root_depth']  = $ini->variable( 'SiteSettings', 'RootNodeDepth' ) -1;

                        if ( isset( $moduleResult['path'][ $pageData['page_root_depth'] ]['node_id'] ))
                        {
                            $pageData['root_node'] = $moduleResult['path'][$pageData['page_root_depth'] ]['node_id'];        
                        }
                    }

                    if ( isset( $moduleResult['content_info'] ))
                    {
                        $pageData['content_info'] = $moduleResult['content_info'];
                    }

                    $pageData['class_identifier'] = '';
                    if ( isset( $pageData['content_info']['class_identifier'] ) )
                    {
                        $pageData['class_identifier'] = $pageData['content_info']['class_identifier'];
                    }

                    $viewMode = '';
                    $persistentVariable = array();
                    $pageData['show_path'] = true;
                    $pageData['website_toolbar'] = false;
                    $pageData['persistent_variable'] = array();
                    if (  isset( $pageData['content_info']['viewmode'] ) )
                    {
                        $viewMode = $pageData['content_info']['viewmode'];
                    }

                    if ( isset( $pageData['content_info']['persistent_variable'] ) )
                    {
                        $persistentVariable = $pageData['content_info']['persistent_variable'];
                        $pageData['persistent_variable'] = $persistentVariable;
                    }

                    if ( isset( $persistentVariable['show_path'] ) )
                    {
                        $pageData['show_path'] = $persistentVariable['show_path'];
                    }

                    if ( $viewMode === 'sitemap' || $viewMode === 'tagcloud' )
                    {
                        $pageData['show_path'] = false;
                        $pageData['website_toolbar'] = false;
                    }
                    else if ( $tpl->hasVariable('current_user') )
                    {
                        $currentUser = $tpl->variable('current_user');
                        $pageData['website_toolbar'] = ( $currentNodeId && $currentUser->attribute('is_logged_in') );
                    }

                    /// Figgure out which menues to use
                    $pageData['top_menu']     = $menuIni->variable('SelectedMenu', 'TopMenu');
                    $pageData['left_menu']    = $menuIni->variable('SelectedMenu', 'LeftMenu');
                    $pageData['current_menu'] = $menuIni->variable('SelectedMenu', 'CurrentMenu');
                    $pageData['extra_menu']   = 'extra_info';

                    if ( isset( $persistentVariable['left_menu'] ) )
                    {
                        $pageData['left_menu'] = $persistentVariable['left_menu'];
                    }

                    if ( isset( $persistentVariable['extra_menu'] ) )
                    {
                        $pageData['extra_menu'] = $persistentVariable['extra_menu'];
                    }

                    if ( isset( $persistentVariable['top_menu'] ) )
                    {
                        $pageData['top_menu'] = $persistentVariable['top_menu'];
                    }

                    if ( $pageData['is_edit'] && strpos($reqUriString, 'content/versionview') === false )
                    {
                        $pageData['left_menu']  = false;
                        $pageData['extra_menu'] = false;
                    }
                    else if ( !$currentNodeId || $uiContext === 'browse' )
                    {
                        $pageData['left_menu']  = false;
                        $pageData['extra_menu'] = false;
                    }
                    // Depricated: Please use persistant variable instead since it's more flexible                
                    else if ( $menuIni->hasVariable('MenuSettings', 'HideLeftMenuClasses') &&
                              in_array( $pageData['content_info']['class_identifier'], $menuIni->variable('MenuSettings', 'HideLeftMenuClasses') ))
                    {
                        $pageData['left_menu']  = false;
                        $pageData['extra_menu'] = false;
                    }

                    if ( $pageData['extra_menu'] === 'extra_info' )
                    {
                        $pageData['infobox_count'] = eZContentObjectTreeNode::subTreeCountByNodeID( 
                                                 array( 'Depth' => 1,
                                                        'DepthOperator'    => 'eq',
                                                        'ClassFilterType'  => 'include',
                                                        'ClassFilterArray' => array('infobox')
                                                        ), $currentNodeId);
                        if ( !$pageData['infobox_count'] ) $pageData['extra_menu'] = false;
                    }

                    // Creating css classes for page div
                    $pageData['path_array']      = array();
                    $pageData['path_id_array']   = array();
                    $pageData['path_normalized'] = '';
                    $pageData['css_classes']     = $pageData['left_menu'] ? 'sidemenu' : 'nosidemenu';
                    $pageData['css_classes']    .= $pageData['extra_menu'] ? ' extrainfo' : ' noextrainfo';

                    if ( isset( $moduleResult['section_id'] ))
                    {
                        $pageData['css_classes'] .= ' section_id_' . $moduleResult['section_id'];
                    }
                    
                    $path = isset( $moduleResult['path'] ) ? $moduleResult['path'] : array();

                    foreach ( $path as $key => $item )
                    {
                        if ( $key >= $pageData['page_root_depth'])
                        {
                            $pageData['path_array'][] = $item;
                        }
                        if ( isset( $item['node_id'] ) )
                        {
                            $pageData['path_normalized'] .= ' subtree_level_' . $key . '_node_id_' . $item['node_id'];
                            $pageData['path_id_array'][] = $item['node_id'];
                        }
                    }
                    $pageData['css_classes'] .= $pageData['path_normalized'];

                    $operatorValue = $pageData;
                } break;
        }
    }
}

?>