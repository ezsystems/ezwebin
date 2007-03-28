<?php

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
        return array( 'ezkeywordlist' => array( 'class_identifier' => array( 'type' => 'string',
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
            case 'ezkeywordlist':
            {
                include_once( 'lib/ezdb/classes/ezdb.php' );
			    $db =& eZDB::instance();

				$rs = $db->arrayQuery( "SELECT DISTINCT ezkeyword.keyword
											FROM ezkeyword_attribute_link, 
												 ezkeyword, 
												 ezcontentobject_attribute, 
												 ezcontentobject_tree, 
												 ezcontentclass
											WHERE ezkeyword.id = ezkeyword_attribute_link.keyword_id
												AND ezkeyword_attribute_link.objectattribute_id = ezcontentobject_attribute.id
												AND ezcontentobject_tree.contentobject_id = ezcontentobject_attribute.contentobject_id
												AND ezkeyword.class_id = ezcontentclass.id
												AND ezcontentobject_tree.parent_node_id = " . (int)$parentNodeID . "
												AND ezcontentclass.identifier = '" . $classIdentifier . "' 
											ORDER BY ezkeyword.keyword ASC" );
                $operatorValue = $rs;
            } break;
        }
    }
}

?>