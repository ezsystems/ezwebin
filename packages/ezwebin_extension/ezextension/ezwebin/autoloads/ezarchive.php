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

class eZArchive
{
    function eZArchive()
    {
    }

    function operatorList()
    {
        return array( 'ezarchive' );
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array( 'ezarchive' => array( 'class_identifier' => array( 'type' => 'string',
                                                               'required' => true,
                                                               'default' => '' ),
                                                'parent_node_id' => array( 'type' => 'integer',
                                                                'required' => true,
                                                                'default' => 0 ) ) );
    }

    function modify( $tpl, $operatorName, $operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        $classIdentifier = $namedParameters['class_identifier'];
        $parentNodeID = $namedParameters['parent_node_id'];

        switch ( $operatorName )
        {
            case 'ezarchive':
            {
                include_once( 'lib/ezdb/classes/ezdb.php' );
                $db = eZDB::instance();
                $SQL = '';

                switch ( $db->databaseName() )
                {
                    case 'mysql':
                        $SQL = "SELECT MONTH( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) ) AS month,
                                       YEAR( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) ) AS year,
                                       UNIX_TIMESTAMP( CONCAT( YEAR( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) ) , '-', MONTH( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) ) , '-', 01 ) ) AS timestamp
                                FROM ezcontentobject_attribute,
                                     ezcontentclass,
                                     ezcontentclass_attribute,
                                     ezcontentobject_tree
                                WHERE ezcontentclass_attribute.contentclass_id = ezcontentclass.id
                                    AND ezcontentclass.identifier = '" . $classIdentifier ."'
                                    AND ezcontentclass_attribute.id = ezcontentobject_attribute.contentclassattribute_id
                                    AND ezcontentclass_attribute.identifier = 'publication_date'
                                    AND ezcontentobject_attribute.contentobject_id = ezcontentobject_tree.contentobject_id
                                    AND ezcontentobject_attribute.version = ezcontentobject_tree.contentobject_version
                                    AND ezcontentobject_tree.is_hidden = 0
                                    AND ezcontentobject_tree.parent_node_id = " . $parentNodeID . "
                                GROUP BY YEAR( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) ) DESC,
                                         MONTH( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) ) DESC,
                                         UNIX_TIMESTAMP( CONCAT( YEAR( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) ) , '-', MONTH( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) ) , '-', 01 ) ) DESC";
                        break;
                    case 'postgresql':
                        $SQL = "SELECT EXTRACT(MONTH FROM to_timestamp( ezcontentobject_attribute.data_int ) ) AS month,
                                       EXTRACT(YEAR FROM to_timestamp( ezcontentobject_attribute.data_int ) ) AS year,
                                       EXTRACT(EPOCH FROM DATE(EXTRACT(YEAR FROM to_timestamp( ezcontentobject_attribute.data_int ) ) || '-' || EXTRACT(MONTH FROM to_timestamp( ezcontentobject_attribute.data_int ) ) || '-' || '01' ) ) AS timestamp
                                FROM ezcontentobject_attribute,
                                     ezcontentclass,
                                     ezcontentclass_attribute,
                                     ezcontentobject_tree
                                WHERE ezcontentclass_attribute.contentclass_id = ezcontentclass.id
                                    AND ezcontentclass.identifier = '" . $classIdentifier ."'
                                    AND ezcontentclass_attribute.id = ezcontentobject_attribute.contentclassattribute_id
                                    AND ezcontentclass_attribute.identifier = 'publication_date'
                                    AND ezcontentobject_attribute.contentobject_id = ezcontentobject_tree.contentobject_id
                                    AND ezcontentobject_attribute.version = ezcontentobject_tree.contentobject_version
                                    AND ezcontentobject_tree.is_hidden = 0
                                    AND ezcontentobject_tree.parent_node_id = " . $parentNodeID . "
                                GROUP BY EXTRACT(YEAR FROM to_timestamp( ezcontentobject_attribute.data_int ) ),
                                         EXTRACT(MONTH FROM to_timestamp( ezcontentobject_attribute.data_int ) ),
                                         EXTRACT(EPOCH FROM DATE(EXTRACT(YEAR FROM to_timestamp( ezcontentobject_attribute.data_int ) ) || '-' || EXTRACT(MONTH FROM to_timestamp( ezcontentobject_attribute.data_int ) ) || '-' || '01' ) )
                                ORDER BY EXTRACT(YEAR FROM to_timestamp( ezcontentobject_attribute.data_int ) ) DESC, 
                                         EXTRACT(MONTH FROM to_timestamp( ezcontentobject_attribute.data_int ) ) DESC";
                        break;
                }

                $rs = $db->arrayQuery( $SQL );
                $operatorValue = $rs;
            } break;
        }
    }
}

?>
