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
        return array( 'eztagcloud' => array( 'params' => array( 'type' => 'array',
                        'required' => false,
                        'default' => array() ) ) );
    }

    function modify( $tpl, $operatorName, $operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        switch ( $operatorName )
        {
            case 'eztagcloud':
            {

                $tags = array();
                $tagCloud = array();
                $parentNodeID = 0;
                $classIdentifier = '';
                $classIdentifierSQL = '';
                $pathString = '';
                $parentNodeIDSQL = '';

                if ( isset( $namedParameters['params']['class_identifier'] ) )
                    $classIdentifier = $namedParameters['params']['class_identifier'];

                if ( isset( $namedParameters['params']['parent_node_id'] ) )
                    $parentNodeID = $namedParameters['params']['parent_node_id'];

                $db = eZDB::instance();

                if( $classIdentifier )
                {
                    $classID = eZContentClass::classIDByIdentifier( $classIdentifier );
                    $classIdentifierSQL = "AND ezcontentobject.contentclass_id = '" . $classID . "'";
                }

                if( $parentNodeID )
                {
                    $node = eZContentObjectTreeNode::fetch( $parentNodeID );
                    if ( $node )
                        $pathString = "AND ezcontentobject_tree.path_string like '" . $node->attribute( 'path_string' ) . "%'";
                    $parentNodeIDSQL = 'AND ezcontentobject_tree.node_id != ' . (int)$parentNodeID;
                }

                $showInvisibleNodesCond = eZContentObjectTreeNode::createShowInvisibleSQLString( true, false );
                $limitation = false;
                $limitationList = eZContentObjectTreeNode::getLimitationList( $limitation );
                $sqlPermissionChecking = eZContentObjectTreeNode::createPermissionCheckingSQL( $limitationList );

                $languageFilter = 'AND ' . eZContentLanguage::languagesSQLFilter( 'ezcontentobject' );

                $rs = $db->arrayQuery( "SELECT ezkeyword.keyword, count(*) as keyword_count
                                        FROM ezkeyword,
                                            ezkeyword_attribute_link,
                                            ezcontentobject,
                                            ezcontentobject_attribute,
                                            ezcontentobject_tree
                                            $sqlPermissionChecking[from]
                                        WHERE ezkeyword.id = ezkeyword_attribute_link.keyword_id
                                            AND ezkeyword_attribute_link.objectattribute_id = ezcontentobject_attribute.id
                                            AND ezcontentobject_attribute.contentobject_id = ezcontentobject_tree.contentobject_id
                                            AND ezcontentobject_attribute.contentobject_id = ezcontentobject.id
                                            AND ezcontentobject.status = ".eZContentObject::STATUS_PUBLISHED."
                                            AND ezcontentobject_attribute.version = ezcontentobject.current_version
                                            AND ezcontentobject_tree.main_node_id = ezcontentobject_tree.node_id
                                            $pathString
                                            $parentNodeIDSQL
                                            $classIdentifierSQL
                                            $showInvisibleNodesCond
                                            $sqlPermissionChecking[where]
                                            $languageFilter
                						GROUP BY ezkeyword.id
                                        ORDER BY ezkeyword.keyword ASC" );

                foreach( $rs as $row )
                {
                    $tags[$row['keyword']] = $row['keyword_count'];
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

                require_once( 'kernel/common/template.php' );
                $tpl = templateInit();
                $tpl->setVariable( 'tag_cloud', $tagCloud );

                $operatorValue = $tpl->fetch( 'design:tagcloud/tagcloud.tpl' );
            } break;
        }
    }
}

?>