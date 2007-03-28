<?php

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

    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        $classIdentifier = $namedParameters['class_identifier'];
        $parentNodeID = $namedParameters['parent_node_id'];

        switch ( $operatorName )
        {
            case 'ezarchive':
            {
                include_once( 'lib/ezdb/classes/ezdb.php' );
			    $db =& eZDB::instance();

				$rs = $db->arrayQuery( "SELECT MONTH( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) ) AS month, 
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
											AND ezcontentobject_tree.parent_node_id = " . $parentNodeID . "
											GROUP BY MONTH( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) ), 
														YEAR( FROM_UNIXTIME( ezcontentobject_attribute.data_int ) )" );
                $operatorValue = $rs;
            } break;
        }
    }
}

?>