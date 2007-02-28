<?php

class eZTagCloud
{
    function eZTagCloud()
    {
    }

    function operatorList()
    {
        return array( 'eztagcloud' );
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array( 'eztagcloud' => array( 'class_identifier' => array( 'type' => 'string',
                                                               'required' => false,
                                                               'default' => '' ),
                                                'parent_node_id' => array( 'type' => 'integer',
                                                                'required' => false,
                                                                'default' => 0 ) ) );
    }

    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        $classIdentifier = $namedParameters['class_identifier'];
        $parentNodeID = $namedParameters['parent_node_id'];

        switch ( $operatorName )
        {
            case 'eztagcloud':
            {
			
				$tags = array();
				$tagCloud = array();
				
				include_once( 'lib/ezdb/classes/ezdb.php' );
				$db =& eZDB::instance();
			
				if( $classIdentifier )
					$classIdentifierSQL = "AND ezcontentclass.identifier = '" . $classIdentifier . "'";
			
				if( $parentNodeID )
					$parentNodeIDSQL = "AND ezcontentobject_tree.parent_node_id = " . (int)$parentNodeID;

				$rs = $db->arrayQuery( "SELECT ezkeyword.keyword, 
												count( ezkeyword.keyword ) AS count 
											FROM ezkeyword, 
													ezkeyword_attribute_link, 
													ezcontentobject_attribute, 
													ezcontentobject_tree, 
													ezcontentclass
											WHERE ezkeyword.id = ezkeyword_attribute_link.keyword_id 
												AND ezkeyword_attribute_link.objectattribute_id = ezcontentobject_attribute.id 
												AND ezcontentobject_attribute.contentobject_id = ezcontentobject_tree.contentobject_id 
												AND ezkeyword.class_id = ezcontentclass.id
												$parentNodeIDSQL
												$classIdentifierSQL
											GROUP BY ezkeyword.keyword
											ORDER BY ezkeyword.keyword ASC" );
											
				
				foreach( $rs as $row )
				{
					$tags[$row['keyword']] = $row['count'];
				}
				
				$maxFontSize = 200;
				$minFontSize = 100;
				
				$maxCount = 0;
				$minCount = 0;
				
				if( count( $tags ) != 0 )
				{
					$maxCount = max( array_values( $tags ) );
					$minCount = min( array_values($tags ) );
				}
				
				$spread = $maxCount - $minCount;
				if ( $spread == 0 )
					$spread = 1;
					
				$step = ( $maxFontSize - $minFontSize )/( $spread );
				
				foreach ($tags as $key => $value) 
				{
					$size = $minFontSize + ( ( $value - $minCount ) * $step );
					$tagCloud[] = array( 'font_size' => $size, 
											'count' => $value, 
											'tag' => $key );
				}

				include_once( 'kernel/common/template.php' );
				$tpl =& templateInit();
				$tpl->setVariable( 'tag_cloud', $tagCloud );

                $operatorValue = $tpl->fetch( 'design:tagcloud/tagcloud.tpl' );
            } break;
        }
    }
}

?>