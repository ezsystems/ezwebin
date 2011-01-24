<?php
//
// Definition of eZPageData class
//
// Created on: <18-Aug-2007 10:49:08 ar>
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Publish Website Interface
// SOFTWARE RELEASE: 1.4-0
// COPYRIGHT NOTICE: Copyright (C) 1999-2009 eZ Systems AS
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
        return array( 'ezpagedata', 'ezpagedata_set', 'ezpagedata_append' );
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array( 'ezpagedata' => array(
                           'params' => array( 'type' => 'array',
                                              'required' => false,
                                              'default' => array() ) ),
                      'ezpagedata_set' => array(
                              'key' => array( 'type' => 'string',
                                              'required' => true,
                                              'default' => false ),
                            'value' => array( 'type' => 'mixed',
                                              'required' => true,
                                              'default' => false ) ),
                      'ezpagedata_append' => array(
                              'key' => array( 'type' => 'string',
                                              'required' => true,
                                              'default' => false ),
                            'value' => array( 'type' => 'mixed',
                                              'required' => true,
                                              'default' => false ) ) );
    }

    function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters )
    {
        switch ( $operatorName )
        {
            // note: these functions are not cache-block safe
            // as in: if called inside a cache-block then they will not be called when cache is used.
            case 'ezpagedata_set':
            case 'ezpagedata_append':
            {
                self::setPersistentVariable( $namedParameters['key'], $namedParameters['value'], $tpl, $operatorName === 'ezpagedata_append' );
            }break;
            case 'ezpagedata':
            {
                $currentNodeId = 0;
                $pageData      = array();
                $parameters    = $namedParameters['params'];

                // Get module_result for later use
                if ( $tpl->hasVariable('module_result') )
                {
                   $moduleResult = $tpl->variable('module_result');
                }
                else
                {
                    $moduleResult = array();
                }

                if ( isset( $moduleResult['content_info'] ) )
                {
                    $contentInfo = $moduleResult['content_info'];
                }
                else
                {
                    $contentInfo = array();
                }

                // Get persistent_variable
                if ( isset( $contentInfo['persistent_variable'] ) && is_array( $contentInfo['persistent_variable'] ) )
                {
                    $pageData['persistent_variable'] = $contentInfo['persistent_variable'];
                }
                else
                {
                     $pageData['persistent_variable'] = self::getPersistentVariable();
                     if ( $pageData['persistent_variable'] === null )
                     {
                         $pageData['persistent_variable'] = array();
                     }
                }

                // Merge parameters with persistent_variable
                $parameters = array_merge( $parameters, $pageData['persistent_variable'] );

                // Figgure out current node id
                if ( isset( $parameters['current_node_id'] ) )
                {
                   $currentNodeId = (int) $parameters['current_node_id'];

                   // Allow parameters to set current path
                   if ( isset( $parameters['set_current_node_path'] ) && $parameters['set_current_node_path'] )
                   {
                       if ( $setPath = self::getNodePath( $currentNodeId ) )
                       {
                           $moduleResult['path'] = $setPath['path'];
                           $moduleResult['title_path'] = $setPath['title_path'];
                           $tpl->setVariable( 'module_result', $moduleResult );
                       }
                       else
                       {
                           eZDebug::writeWarning( "Could not fetch 'current_node_id'", 'eZPageData::getNodePath()' );
                       }
                   }
                }
                else if ( $tpl->hasVariable('current_node_id') )
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

                // Init variables and return values
                $ini                      = eZINI::instance( 'site.ini' );
                $menuIni                  = eZINI::instance( 'menu.ini' );
                $contentIni               = eZINI::instance( 'content.ini' );
                $uiContext                = $tpl->variable('ui_context');
                $uriString                = $tpl->variable('uri_string');
                $pageData['main_node_id'] = isset( $contentInfo['main_node_id'] ) ? $contentInfo['main_node_id'] : $currentNodeId;
                $pageData['show_path']           = 'path';
                $pageData['website_toolbar']     = false;
                $pageData['node_id']             = $currentNodeId;
                $pageData['is_edit']             = false;
                $pageData['page_root_depth']     = 0;
                $pageData['page_depth']          = count( $moduleResult['path'] );
                $pageData['root_node']           = (int) $contentIni->variable( 'NodeSettings', 'RootNode' );
                $pageData['canonical_url']       = false;
                $pageData['canonical_language_url'] = false;

                // is_edit if not on user/edit and not on content/action when
                // you get info collector warning about missing attributes
                if ( $uiContext === 'edit'
                  && strpos( $uriString, 'user/edit' ) === false
                  && ( empty( $contentInfo ) || strpos( $uriString, 'content/action' ) === false ) )
                {
                    $pageData['is_edit'] = true;
                }

                if ( isset( $contentInfo['viewmode'] ) )
                {
                    $viewMode = $contentInfo['viewmode'];
                }
                else
                {
                    $viewMode = '';
                }

                // Get custom template_look object. false|eZContentObject (set as parameter from caller)
                if ( isset( $parameters['template_look'] ) )
                {
                    $pageData['template_look'] = $parameters['template_look'];
                }
                else
                {
                    // Get template_look eZContentObject
                    if ( !isset( $parameters['template_look_class'] ) )
                    {
                        $parameters['template_look_class'] = 'template_look';
                    }

                    $templateLookClassID    = eZContentObjectTreeNode::classIDByIdentifier( $parameters['template_look_class'] );
                    $templateLookObjectList = eZContentObject::fetchFilteredList( array( 'contentclass_id' => $templateLookClassID ), 0, 1 );

                    if ( $templateLookObjectList )
                    {
                       $pageData['template_look'] = $templateLookObjectList[0];
                    }
                    else
                    {
                        $pageData['template_look'] = false;
                    }
                }

                // canonical url, to let search engines know about main location on content with multiple locations
                if ( isset( $parameters['canonical_url'] ) )
                {
                    $pageData['canonical_url'] = $parameters['canonical_url'];
                }
                elseif ( isset( $contentInfo['main_node_url_alias'] ) && $contentInfo['main_node_url_alias'] )
                {
                    $pageData['canonical_url'] = $contentInfo['main_node_url_alias'];
                }
                elseif ( isset( $contentInfo['current_language'] )
                      && $contentInfo['current_language'] !== $ini->variable( 'RegionalSettings', 'ContentObjectLocale' ) )
                {
                    $siteaccess = eZSiteAccess::saNameByLanguage( $contentInfo['current_language'] );
                    if ( $siteaccess !== null )
                    {
                        $lang = eZContentLanguage::fetchByLocale( $ini->variable( 'RegionalSettings', 'ContentObjectLocale' ) );
                        if ( ( $contentInfo['language_mask'] & $lang->attribute('id') ) < 1 )
                        {
                            $handlerOptions = new ezpExtensionOptions();
                            $handlerOptions->iniFile = 'site.ini';
                            $handlerOptions->iniSection = 'RegionalSettings';
                            $handlerOptions->iniVariable = 'LanguageSwitcherClass';
                            $handlerOptions->handlerParams = array( array( 'Parameters' => array( 'sa', $currentNodeId ),
                                                                           'UserParameters' => array() ) );
                            $langSwitch = eZExtension::getHandlerClass( $handlerOptions );

                            $langSwitch->setDestinationSiteAccess( $siteaccess );
                            $langSwitch->process();
                            $pageData['canonical_language_url'] = $langSwitch->destinationUrl();
                        }
                    }
                }

                /*
                  RootNodeDepth is a setting for letting you have a very simple multisite, single database and singe siteaccess setup.
                  The content of the menues will be the same on all system pages like user/login, content/edit
                  and so on, and also when you surf bellow the defined page_root_depth.
                  The sites will also share siteaccess and thus also the same ez publish design and templates.
                  You can however custimize the design with css using the class on div#page html output:
                  subtree_level_x_node_id_y class

                  Note: It is recommended to turn it of by setting it to 0 for normal sites!

                  Example having 2 or more 'sub-sites' with RootNodeDepth=2:
                    root (menu shows sub sites as menu choices like it will on system pages)
                    - sub site 1 (menu show content of this sub site)
                    - sub site 2 (-- " --)
                    - sub site 3 (-- " --)
                    - sub site 4 (-- " --)
                    - sub site 5 (-- " --)
                */
                if ( $currentNodeId &&
                     isset( $moduleResult['path'][0]['node_id'] ) &&
                     $moduleResult['path'][0]['node_id'] == '2' &&
                     $ini->hasVariable( 'SiteSettings', 'RootNodeDepth' ) &&
                     $ini->variable( 'SiteSettings', 'RootNodeDepth' ) !== '0' )
                {
                    $pageData['page_root_depth']  = $ini->variable( 'SiteSettings', 'RootNodeDepth' ) -1;

                    if ( isset( $moduleResult['path'][ $pageData['page_root_depth'] ]['node_id'] ))
                    {
                        $pageData['root_node'] = $moduleResult['path'][$pageData['page_root_depth'] ]['node_id'];
                    }
                }

                // Get class identifier for easier access in tempaltes
                $pageData['class_identifier'] = '';
                if ( isset( $contentInfo['class_identifier'] ) )
                {
                    $pageData['class_identifier'] = $contentInfo['class_identifier'];
                }

                // Use custom path template. bool|string ( default: path )
                if ( isset( $parameters['show_path'] ) )
                {
                    $pageData['show_path'] = $parameters['show_path'] === true ? 'path' : $parameters['show_path'];
                }
                else if ( $viewMode === 'sitemap' || $viewMode === 'tagcloud' )
                {
                    $pageData['show_path'] = false;
                }

                // See if we should show website toolbar. bool ( default: false )
                if ( isset( $parameters['website_toolbar'] ) )
                {
                    $pageData['website_toolbar'] = $parameters['website_toolbar'];
                }
                else if ( $viewMode === 'sitemap' || $viewMode === 'tagcloud' || strpos( $uriString, 'content/versionview' ) === 0 )
                {
                    $pageData['website_toolbar'] = false;
                }
                else if ( $tpl->hasVariable('current_user') )
                {
                    $currentUser = $tpl->variable('current_user');
                    $pageData['website_toolbar'] = ( $currentNodeId && $currentUser->attribute('is_logged_in') );
                }

                // Init default menu settings
                $pageData['top_menu']     = $menuIni->variable('SelectedMenu', 'TopMenu');
                $pageData['left_menu']    = $menuIni->variable('SelectedMenu', 'LeftMenu');
                $pageData['current_menu'] = $menuIni->variable('SelectedMenu', 'CurrentMenu');
                $pageData['extra_menu']   = 'extra_info';
                $pageData['extra_menu_node_id']    = $currentNodeId;
                $pageData['extra_menu_subitems']   = 0;
                $pageData['extra_menu_class_list'] = array( 'infobox' );

                // BC: Setting to hide left and extra menu by class identifier
                if ( $menuIni->hasVariable('MenuSettings', 'HideLeftMenuClasses') )
                {
                    $hideMenuClasses = in_array( $pageData['class_identifier'], $menuIni->variable('MenuSettings', 'HideLeftMenuClasses') );
                }
                else
                {
                    $hideMenuClasses = false;
                }

                // Use custom top menu template. bool|string ( default: from menu.ini[SelectedMenu]TopMenu )
                if ( isset( $parameters['top_menu'] ) && $parameters['top_menu'] !== true )
                {
                    $pageData['top_menu'] = $parameters['top_menu'];
                }

                // Use custom left menu template. bool|string ( default: from menu.ini[SelectedMenu]LeftMenu )
                if ( isset( $parameters['left_menu'] ) )
                {
                    if ( $parameters['left_menu'] !== true )
                        $pageData['left_menu'] = $parameters['left_menu'];
                }
                else if ( $hideMenuClasses )
                {
                    $pageData['left_menu'] = false;
                }

                // Use custom extra menu template. bool|string (default: extra_info)
                if ( isset( $parameters['extra_menu'] ) )
                {
                   if ( $parameters['extra_menu'] !== true )
                        $pageData['extra_menu'] = $parameters['extra_menu'];
                }
                else if ( $hideMenuClasses )
                {
                    $pageData['extra_menu'] = false;
                }

                // Use custom node id. int|array (default: current node id)
                if ( isset( $parameters['extra_menu_node_id'] ) )
                {
                    $pageData['extra_menu_node_id'] = $parameters['extra_menu_node_id'];
                }

                // Use custom extra menu identifier list. false|array (default: infobox)
                if ( isset( $parameters['extra_menu_class_list'] ) )
                {
                    $pageData['extra_menu_class_list'] = $parameters['extra_menu_class_list'];
                }
                else if ( $menuIni->hasVariable('MenuContentSettings', 'ExtraIdentifierList') )
                {
                    $pageData['extra_menu_class_list'] = $menuIni->variable('MenuContentSettings', 'ExtraIdentifierList');
                }

                if ( $menuIni->variable( 'MenuSettings', 'AlwaysAvailable' ) === 'false' )
                {
                    // A set of cases where left/extra menu's are hidden unless set by parameters
                    if ( $pageData['is_edit'] || strpos( $uriString, 'content/versionview' ) === 0 )
                    {
                        if ( !isset( $parameters['left_menu'] ) ) $pageData['left_menu']  = false;
                        if ( !isset( $parameters['extra_menu'] ) ) $pageData['extra_menu'] = false;
                    }
                    else if ( !$currentNodeId || $uiContext === 'browse' )
                    {
                        if ( !isset( $parameters['left_menu'] ) ) $pageData['left_menu']  = false;
                        if ( !isset( $parameters['extra_menu'] ) ) $pageData['extra_menu'] = false;
                    }
                }

                // Count extra menu objects if all extra menu settings are present
                if ( isset( $parameters['extra_menu_subitems'] ) )
                {
                    $pageData['extra_menu_subitems'] = $parameters['extra_menu_subitems'];
                    if ( !$pageData['extra_menu_subitems'] ) $pageData['extra_menu'] = false;
                }
                else if ( $pageData['extra_menu'] && $pageData['extra_menu_class_list'] && $pageData['extra_menu_node_id'] )
                {
                    if ( $menuIni->variable( 'MenuContentSettings', 'ExtraMenuSubitemsCheck' ) === 'enabled' )
                    {
                        $pageData['extra_menu_subitems'] = eZContentObjectTreeNode::subTreeCountByNodeID( array( 'Depth' => 1,
                                                                                                                 'DepthOperator'    => 'eq',
                                                                                                                 'ClassFilterType'  => 'include',
                                                                                                                 'ClassFilterArray' => $pageData['extra_menu_class_list'] ),
                                                                                                          $pageData['extra_menu_node_id'] );
                        if ( !$pageData['extra_menu_subitems'] ) $pageData['extra_menu'] = false;
                    }
                }

                // Init path parameters
                $pageData['path_array']      = array();
                $pageData['path_id_array']   = array();
                $pageData['path_normalized'] = '';

                // Creating menu css classes for div#page
                $pageData['css_classes']     = $pageData['left_menu'] ? 'sidemenu' : 'nosidemenu';
                $pageData['css_classes']    .= $pageData['extra_menu'] ? ' extrainfo' : ' noextrainfo';

                // Add section css class for div#page
                if ( isset( $moduleResult['section_id'] ))
                {
                    $pageData['css_classes'] .= ' section_id_' . $moduleResult['section_id'];
                }

                // Generate relative path array as well full path id array and path css classes for div#page
                $path = ( isset( $moduleResult['path'] ) && is_array( $moduleResult['path'] ) ) ? $moduleResult['path'] : array();
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

                if ( isset( $pageData['persistent_variable']['pagestyle_css_classes'] )
                        && is_array( $pageData['persistent_variable']['pagestyle_css_classes'] ) )
                {
                    $pageData['css_classes'] .= ' ' . implode( ' ', $pageData['persistent_variable']['pagestyle_css_classes'] );
                }

                $operatorValue = $pageData;
            } break;
        }
    }

    // function to generate path and title_path from node id
    static public function getNodePath( $nodeId )
    {
        if ( !$nodeId or !is_numeric( $nodeId ) )
        {
            return false;
        }

        $node = eZContentObjectTreeNode::fetch( $nodeId );

        if ( !$node or !$node instanceof eZContentObjectTreeNode )
        {
            return false;
        }

        $parents = $node->attribute( 'path' );
        $path    = array( 'path' => array(), 'title_path' => array() );
        foreach ( $parents as $parent )
        {
            $path['path'][] = array( 'text' => $parent->attribute( 'name' ),
                             'url' => '/content/view/full/' . $parent->attribute( 'node_id' ),
                             'url_alias' => $parent->attribute( 'url_alias' ),
                             'node_id' => $parent->attribute( 'node_id' ) );
        }

        $path['title_path'] = $path['path'];
        $path['path'][] = array( 'text' => $node->attribute( 'name' ),
                         'url' => false,
                         'url_alias' => false,
                         'node_id' => $node->attribute( 'node_id' ) );

        $path['title_path'][] = array( 'text' => $node->attribute( 'name' ),
                              'url' => false,
                              'url_alias' => false );
        return $path;
    }

    /**
     * @uses ezjscPackerTemplateFunctions::setPersistentArray()
     *
     * @deprecated
     * @param string $key Key to store values on
     * @param string|array $value Value(s) to store
     * @param object $tpl Template object to get values from
     * @param bool $append Append or set value?
     * @return array
     */
    static public function setPersistentVariable( $key, $value, $tpl, $append = false )
    {
        if ( $append )
            return ezjscPackerTemplateFunctions::setPersistentArray( $key, $value, $tpl, $append );
        else// if not, then override value
            return ezjscPackerTemplateFunctions::setPersistentArray( $key, $value, $tpl, $append, false, false, true );
    }

    /**
     * @uses ezjscPackerTemplateFunctions::getPersistentVariable()
     *
     * @deprecated
     * @param string $key Optional, return all values if null
     * @return array|string
     */
    static public function getPersistentVariable( $key = null )
    {
        return ezjscPackerTemplateFunctions::getPersistentVariable( $key );
    }
}

?>
