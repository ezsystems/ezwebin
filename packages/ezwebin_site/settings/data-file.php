<?php
//
// Created on: <21-Sept-2006 11:26:42 jkn>
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

//the new attributes. ps: this needs to be updated when class template_look is expanded in the svn.


function loadNewAttributesData( $parameters )
{
    //init global vars
    global $newAttributesDataArray;

    //init local vars
    $siteaccessAliasTable = array();

    //get siteaccessnames
    $locales = getColumn( "locale", "ezcontent_language");
    $locales = getLocales( $locales );
    $siteaccessNames = getSiteaccessNames( $locales );

    $sys =& eZSys::instance();
    $host = $sys->hostname();

    $indexFile = eZSys::wwwDir() . eZSys::indexFileName();

    if ( isset( $parameters['site_type'] ) && $parameters['site_type']['access_type'] == 'port' )
    {
        $pos = strpos( $host, ':' );
        if ( $pos !== false )
        {
            $host = substr( $host, 0, $pos );
        }
        foreach( $parameters['access_map']['port'] as $port => $siteaccess )
            $siteaccessURI[$siteaccess] = "$host:$port" . $indexFile;
    }
    else if ( isset( $parameters['site_type'] )
              && $parameters['site_type']['access_type'] == 'hostname' )
    {
        foreach ( $parameters['access_map']['hostname'] as $hostName => $siteAccessName )
        {
            $siteaccessURI[ $siteAccessName ] = $hostName . $indexFile;
        }
    }
    else
    {
        foreach ( $siteaccessNames as $siteaccess )
            $siteaccessURI[$siteaccess] = $host . $indexFile . '/' . $siteaccess;
    }

    //create siteaccess alias table array
    foreach ( $siteaccessNames as $siteaccessName )
    {
        $siteaccessAliasTable[] = $siteaccessURI[$siteaccessName];
        $siteaccessAliasTable[] = $siteaccessName;
        $siteaccessAliasTable[] = ucfirst( $siteaccessName );
    }


    //building a matrix that is used as a ezmatrix attribute in class template_look
    $tempColumnDefinition = new eZMatrixDefinition();
    $tempColumnDefinition->addColumn( "Site URL", "site_url" );
    $tempColumnDefinition->addColumn( "Siteaccess", "siteaccess" );
    $tempColumnDefinition->addColumn( "Language name", "language_name" );
    $tempColumnDefinition->decodeClassAttribute( $tempColumnDefinition->xmlString() );

    //create data array
    $newAttributesDataArray = array( "site_map_url" => array( "DataText" => "Site map",
                                                              "Content" => "/content/view/sitemap/2" ),
                                     "tag_cloud_url" => array( "DataText" => "Tag cloud",
                                                              "Content" => "/content/view/tagcloud/2" ),
                                     "login_label" => array( "DataText" => "Login" ),
                                     "logout_label" => array( "DataText" => "Logout" ),
                                     "my_profile_label" => array( "DataText" => "My profile" ),
                                     "register_user_label" => array( "DataText" => "Register" ),
                                     "rss_feed" => array( "DataText" => $siteaccessURI[$siteaccess] . "/rss/feed/my_feed" ),
                                     "shopping_basket_label" => array( "DataText" => "Shopping basket" ),
                                     "site_settings_label" => array( "DataText" => "Site settings" ),
                                     "language_settings" => array( "MatrixTitle" => "Language settings",
                                                                   "MatrixDefinition" => $tempColumnDefinition,
                                                                   "MatrixCells" => $siteaccessAliasTable ),
									 "footer_text" => array( "DataText" => "Copyright &#169; 2007 eZ systems AS. All rights reserved." ),
                                     "hide_powered_by" => array( "DataInt" => 0 ),
									 "footer_script" => array( "DataText" => "" ) );
    return true;
}


function setVersions( $setupData )
{
    foreach ( $setupData['versions'] as $software => $version )
    {
        setVersion( $software, $version );
    }
    return true;
}


function setVersion( $nameParam = false, $versionParam = false )
{
    $db =& eZDB::instance();

    $result = $db->query("INSERT INTO ezsite_data VALUES ('$nameParam', '$versionParam')");

    return $result;
}
?>