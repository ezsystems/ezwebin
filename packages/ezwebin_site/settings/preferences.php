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

/*function eZSiteRemoteObjectID( $parameters, $remoteID )
{
    $remoteMap = $parameters['object_remote_map'];
    if ( isset( $remoteMap[$remoteID] ) )
        return $remoteMap[$remoteID];
    return false;
}*/

function eZSitePreferences( $parameters )
{
    $adminAccountID = eZSiteRemoteObjectID( $parameters, '1bb4fe25487f05527efa8bfd394cecc7' );

    $preferences = array();

    // Make sure admin starts with:
    // - The 'preview' window set as open by default
    // - The 'content structure' tool is open by default
    // - The 'bookmarks' tool is open by default
    // - The 'roles' and 'policies' windows are open by default
    // - The child list limit is 25 by default
    $preferences[] = array( 'user_id' => $adminAccountID,
                            'preferences' => array( array( 'name' => 'admin_navigation_content',
                                                           'value' => '1' ),
                                                    array( 'name' => 'admin_navigation_roles',
                                                           'value' => '1' ),
                                                    array( 'name' => 'admin_navigation_policies',
                                                           'value' => '1' ),
                                                    array( 'name' => 'admin_list_limit',
                                                           'value' => '2' ),
                                                    array( 'name' => 'admin_treemenu',
                                                           'value' => '1' ),
                                                    array( 'name' => 'admin_bookmark_menu',
                                                           'value' => '1' ) ) );
    return $preferences;
}

?>
