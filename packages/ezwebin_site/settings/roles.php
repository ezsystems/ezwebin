<?php
//
// Created on: <11-Jan-2006 18:52:01 ks>
//
// Copyright (C) 1999-2006 eZ systems as. All rights reserved.
//
// This source file is part of the eZ publish (tm) Open Source Content
// Management System.
//
// This file may be distributed and/or modified under the terms of the
// "GNU General Public License" version 2 as published by the Free
// Software Foundation and appearing in the file LICENSE included in
// the packaging of this file.
//
// Licencees holding a valid "eZ publish professional licence" version 2
// may use this file in accordance with the "eZ publish professional licence"
// version 2 Agreement provided with the Software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
// THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE.
//
// The "eZ publish professional licence" version 2 is available at
// http://ez.no/ez_publish/licences/professional/ and in the file
// PROFESSIONAL_LICENCE included in the packaging of this file.
// For pricing of this licence please contact us via e-mail to licence@ez.no.
// Further contact information is available at http://ez.no/company/contact/.
//
// The "GNU General Public License" (GPL) is available at
// http://www.gnu.org/copyleft/gpl.html.
//
// Contact licence@ez.no if any conditions of this licencing isn't clear to
// you.
//

// Stub for no extra common settings

function eZSiteRemoteObjectID( $parameters, $remoteID )
{
    $remoteMap = $parameters['object_remote_map'];
    if ( isset( $remoteMap[$remoteID] ) )
        return $remoteMap[$remoteID];
    return false;
}

function eZSiteRoles( $parameters )
{
    $roles = array();
    eZSiteCommonRoles( $roles, $parameters );
    return $roles;
}

function eZSiteCommonRoles( &$roles, $parameters )
{
    $guestAccountsID = eZSiteRemoteObjectID( $parameters, '5f7f0bdb3381d6a461d8c29ff53d908f' );
    $anonAccountsID = eZSiteRemoteObjectID( $parameters, '15b256dbea2ae72418ff5facc999e8f9' );

    // Add possibility to read rss by default for anonymous/guests
    $roles[] = array( 'name' => 'Anonymous',
                      'policies' => array( array( 'module' => 'rss',
                                                  'function' => 'feed' ) ),
                      'assignments' => array( array( 'user_id' => $guestAccountsID ),
                                              array( 'user_id' => $anonAccountsID ) ) );

    include_once( 'lib/ezutils/classes/ezsys.php' );

    // Make sure anonymous can only login to use side
    $roles[] = array( 'name' => 'Anonymous',
                      'policies' => array( array( 'module' => 'user',
                                                  'function' => 'login',
                                                  'limitation' => array( 'SiteAccess' => array( eZSys::ezcrc32( $parameters['user_siteaccess'] ) ) ) ) ) );
}

?>
