<?php
//
// Created on: <30-Oct-2008 09:31:00 ar>
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Website Toolbar
// SOFTWARE RELEASE: 1.0-0
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

include_once( 'kernel/common/template.php' );

$nodeID = isset( $Params['NodeID'] ) ? (int) $Params['NodeID'] : 0;
$Result = array();
$node   = false;
$viewParameters = array( 'offset' => $Params['Offset'],
                         'year' => $Params['Year'],
                         'month' => $Params['Month'],
                         'day' => $Params['Day'],
                         'namefilter' => false );

if ( isset( $Params['UserParameters'] ) )
{
    $viewParameters = array_merge( $viewParameters, $Params['UserParameters'] );
}

if ( $nodeID !== 0 )
{
    $node = eZContentObjectTreeNode::fetch( $nodeID );
}

if ( !$node instanceof eZContentObjectTreeNode )
{
    $Result['content'] = ezi18n( 'design/standard/websitetoolbar/sort', 'Invalid or missing parameter: %parameter', null, array( '%parameter' => 'NodeID' ) );
    return $Result;
}

$tpl = templateInit();
$tpl->setVariable( 'node', $node );
$tpl->setVariable( 'view_parameters', $viewParameters );
$tpl->setVariable( 'persistent_variable', false );

$parents = $node->attribute( 'path' );

$path = array();
$titlePath = array();
foreach ( $parents as $parent )
{
    $path[] = array( 'text' => $parent->attribute( 'name' ),
                     'url' => '/content/view/full/' . $parent->attribute( 'node_id' ),
                     'url_alias' => $parent->attribute( 'url_alias' ),
                     'node_id' => $parent->attribute( 'node_id' ) );
}

$titlePath = $path;
$path[] = array( 'text' => $node->attribute( 'name' ),
                 'url' => false,
                 'url_alias' => false,
                 'node_id' => $node->attribute( 'node_id' ) );

$titlePath[] = array( 'text' => $node->attribute( 'name' ),
                      'url' => false,
                      'url_alias' => false );

$tpl->setVariable( 'node_path', $path );


$Result['content'] = $tpl->fetch( 'design:parts/websitetoolbar/sort.tpl' );
$Result['path'] = $path;
$Result['title_path'] = $titlePath;

$contentInfoArray = array();
$contentInfoArray['persistent_variable'] = $tpl->variable( 'persistent_variable' );
$Result['content_info'] = $contentInfoArray;

return $Result;

?>