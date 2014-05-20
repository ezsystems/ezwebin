<?php
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Publish Website Interface
// SOFTWARE RELEASE: 1.4-0
// COPYRIGHT NOTICE: Copyright (C) 1999-2014 eZ Systems AS
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

class eZKeywordList
{
    function eZKeywordList()
    {
    }

    function operatorList()
    {
        return array( 'ezkeywordlist' );
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array( 'ezkeywordlist' => array( 'class_identifier' => array( 'type'     => 'mixed',
                                                                             'required' => true,
                                                                             'default'  => ''
                                                                           ),
                                                'parent_node_id'   => array( 'type'     => 'integer',
                                                                             'required' => true,
                                                                             'default'  => 0
                                                                           ),
                                                'depth'            => array( 'type'     => 'integer',
                                                                             'required' => false,
                                                                             'default'  => 0
                                                                           ),
                                              )
        );
    }

    function modify( $tpl, $operatorName, $operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        $parentNodeID = $namedParameters['parent_node_id'];

        switch ( $operatorName )
        {
            case 'ezkeywordlist':
            {
                include_once( 'lib/ezdb/classes/ezdb.php' );
                $db = eZDB::instance();
                
                if( $parentNodeID )
                {
                    $node = eZContentObjectTreeNode::fetch( $parentNodeID );
                    if ( $node )
                        $pathString = "AND ezcontentobject_tree.path_string like '" . $node->attribute( 'path_string' ) . "%'";
                    $parentNodeIDSQL = "AND ezcontentobject_tree.node_id != " . (int)$parentNodeID;
                }

                $limitation = false;
                $sqlPermissionChecking = eZContentObjectTreeNode::createPermissionCheckingSQL( eZContentObjectTreeNode::getLimitationList( $limitation ) );

                // eZContentObjectTreeNode::classIDByIdentifier() might need to be used for eZ Publish < 4.1
                $classIDs = eZContentClass::classIDByIdentifier( $namedParameters['class_identifier'] );

                $operatorValue = $db->arrayQuery(
                    "SELECT DISTINCT ezkeyword.keyword
                     FROM ezkeyword
                          JOIN ezkeyword_attribute_link ON ezkeyword.id = ezkeyword_attribute_link.keyword_id
                          JOIN ezcontentobject_attribute ON ezkeyword_attribute_link.objectattribute_id = ezcontentobject_attribute.id
                          JOIN ezcontentobject ON ezcontentobject_attribute.contentobject_id = ezcontentobject.id
                          JOIN ezcontentobject_name ON ezcontentobject.id = ezcontentobject_name.contentobject_id
                          JOIN ezcontentobject_tree ON ezcontentobject_name.contentobject_id = ezcontentobject_tree.contentobject_id AND ezcontentobject_name.content_version = ezcontentobject_tree.contentobject_version
                          $sqlPermissionChecking[from]
                     WHERE " . eZContentLanguage::languagesSQLFilter( 'ezcontentobject' ) . "
                         AND " . eZContentLanguage::sqlFilter( 'ezcontentobject_name', 'ezcontentobject' ) .
                         ( empty( $classIDs ) ? '' : ( ' AND ' . $db->generateSQLINStatement( $classIDs, 'ezkeyword.class_id' ) ) ) . "
                         $pathString
                         $parentNodeIDSQL " .
                         ( $namedParameters['depth'] > 0 ? ("AND ezcontentobject_tree.depth=" . (int)$namedParameters['depth']) : '' ) . "
                         " . eZContentObjectTreeNode::createShowInvisibleSQLString( true, false ) . "
                         $sqlPermissionChecking[where]
                     ORDER BY ezkeyword.keyword ASC" );
            } break;
        }
    }
}

?>
