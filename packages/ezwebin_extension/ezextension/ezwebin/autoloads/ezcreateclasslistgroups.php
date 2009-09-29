<?php
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Publish Website Interface
// SOFTWARE RELEASE: 1.4-3
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

    function modify( $tpl, $operatorName, $operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
        $canCreateClassList = $namedParameters['can_create_class_list'];

        switch ( $operatorName )
        {
            case 'ezcreateclasslistgroups':
            {
                $groupArray = array();

                $ini = eZINI::instance( 'websitetoolbar.ini' );

                foreach ( $canCreateClassList as $class )
                {
                    $contentClass = eZContentClass::fetch( $class['id'] );

                    if ( !$contentClass )
                        return false;

                    foreach ( $contentClass->fetchGroupList() as $group )
                    {
                        $isHidden = false;

                        if ( in_array( $contentClass->attribute('identifier'), $ini->variable( 'WebsiteToolbarSettings', 'HiddenContentClasses' ) ) )
                        {
                            $isHidden = true;
                        }

                        if ( array_key_exists( $group->attribute( 'group_id' ), $groupArray ) )
                        {
                            if( !$isHidden )
                            {
                                 $groupArray[$group->attribute( 'group_id' )]['items'][] = $contentClass;
                            }
                        }
                        else
                        {
                            if( !$isHidden )
                            {
                                $groupArray[$group->attribute( 'group_id' )]['items'] = array( $contentClass );
                                $groupArray[$group->attribute( 'group_id' )]['group_name'] = $group->attribute( 'group_name' );
                            }
                        }
                    }
                }
                $operatorValue = $groupArray;
            } break;
        }
    }
}

?>