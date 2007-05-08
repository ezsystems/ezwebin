<?php

include_once( 'kernel/classes/ezcontentclass.php' );

class eZCreateClassListGroups
{
    function eZCreateClassListGroups()
    {
    }

    function operatorList()
    {
        return array( 'ezcreateclasslistgroups' );
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array( 'ezcreateclasslistgroups' => array( 'can_create_class_list' => array( 'type' => 'array',
                                                          'required' => true,
                                                          'default' => array() ) ) );
    }

    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        $canCreateClassList = $namedParameters['can_create_class_list'];

        switch ( $operatorName )
        {
            case 'ezcreateclasslistgroups':
            {
                $groupArray = array();

                foreach ( $canCreateClassList as $class )
                {
                    $contentClass = eZContentClass::fetch( $class['id'] );

                    if ( !$contentClass )
                        return false;

                    foreach ( $contentClass->fetchGroupList() as $group )
                    {
                        if ( array_key_exists( $group->attribute( 'group_id' ), $groupArray ) )
                        {
                            $groupArray[$group->attribute( 'group_id' )]['items'][] = $contentClass;
                        }
                        else
                        {
                            $groupArray[$group->attribute( 'group_id' )]['items'] = array( $contentClass );
                            $groupArray[$group->attribute( 'group_id' )]['group_name'] = $group->attribute( 'group_name' );
                        }
                    }
                }
                $operatorValue = $groupArray;
            } break;
        }
    }
}

?>