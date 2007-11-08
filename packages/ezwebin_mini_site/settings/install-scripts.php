<?php
//
// Created on: <21-Oct-2006 11:26:42 jkn>
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

include_once( "lib/ezutils/classes/ezini.php" );
include_once( "lib/ezfile/classes/ezdir.php" );
include_once( "lib/ezdb/classes/ezdb.php" );
include_once( "lib/version.php" );
include_once( "kernel/classes/ezrole.php" );
include_once( "kernel/classes/ezcontentlanguage.php" );
include_once( "kernel/classes/ezcontentclassattribute.php" );
include_once( "kernel/classes/datatypes/ezmatrix/ezmatrix.php" );
include_once( "kernel/classes/datatypes/ezmatrix/ezmatrixdefinition.php" );
include_once( "kernel/classes/ezcontentobjecttreenodeoperations.php" );
include_once( 'kernel/classes/ezcontentobjecttreenode.php' );
include_once( 'kernel/classes/datatypes/ezuser/ezuser.php' );


//init global vars
$wcms_script_errors = array();
$newAttributesDataArray = array();

/*
This get called by ezstep_create_sites.php
*/
function eZSitePreInstall( )
{
    /*
    Extend folder class
    */
    $db = eZDB::instance();
    $db->begin();

    eZWebinInstaller::addClassAttribute( array( 'class_identifier' => 'folder',
                                                'attribute_identifier' => 'tags',
                                                'attribute_name' => 'Tags',
                                                'datatype' => 'ezkeyword' ) );

    eZWebinInstaller::addClassAttribute( array( 'class_identifier' => 'folder',
                                                'attribute_identifier' => 'publish_date',
                                                'attribute_name' => 'Publish date',
                                                'datatype' => 'ezdatetime',
                                                'default_value' => 0 ) );
    $db->commit();

    // hack for images/binaryfiles
    // need to set siteaccess to have correct placement(VarDir) for files.
    $ini = eZINI::instance();
    $ini->setVariable( 'FileSettings', 'VarDir', 'var/ezwebin_site' );
}


/*
This get called by ezstep_create_sites.php
*/
function eZSitePostInstall( &$parameters )
{
    //fetch eZp version
    $ezpVersionMajor = eZPublishSDK::majorVersion();
    $ezpVersionMinor = eZPublishSDK::minorVersion();

    if ( isset( $parameters['site_type'] ) )
    {
        // get locales chosen by user in the setup-wizard to create list of user siteaccess
        $userSiteaccesses = getSiteaccessNames( $parameters['all_language_codes'] );

        if ( $parameters['site_type']['access_type'] == 'port' )
        {
            $userSitePort = $parameters['site_type']['access_type_value'];
            $portMatchMapItems = array();

            foreach ( $parameters['access_map']['port'] as $port => $siteAccessName )
            {
                // skip user's siteaccesses
                if ( !in_array( $siteAccessName, $userSiteaccesses ) )
                {
                    $portMatchMapItems[$port] = $siteAccessName;
                }
            }

            // setup all user's siteaccesses.
            foreach ( $userSiteaccesses as $userSiteaccess )
            {
                while ( isset( $portMatchMapItems[$userSitePort] ) )
                {
                    ++$userSitePort;
                }

                $portMatchMapItems[$userSitePort] = $userSiteaccess;
            }

            $parameters['access_map']['port'] = $portMatchMapItems;
        }
        else if ( $parameters['site_type']['access_type'] == 'hostname' )
        {
            $hostMatchMapItems = array();

            $url = $parameters['site_type']['url'];
            if ( preg_match( "#^[a-zA-Z0-9]+://(.*)$#", $url, $matches ) )
            $url = $matches[1];

            foreach ( $parameters['access_map']['hostname'] as $hostName => $siteAccessName )
            {
                if ( !in_array( $siteAccessName, $userSiteaccesses ) )
                $hostMatchMapItems[ $hostName ] = $siteAccessName;
            }
            foreach ( $userSiteaccesses as $userSiteaccess )
            {
                $hostMatchMapItems[ $userSiteaccess . '.' . $url ] = $userSiteaccess;
            }
            $parameters['access_map']['hostname'] = $hostMatchMapItems;
        }
    }

    //init global vars
    global $newAttributesDataArray;

    //initialize global data array
    loadNewAttributesData( $parameters );

    //fetch setup data
    $setupData = loadSetupData( $parameters );

    //set solution version in database
    setVersions( $setupData );

    //debug
    addError( $newAttributesDataArray, false );

    //setup siteaccesses
    eZSetupAdminSiteAccess( $parameters );
    eZSetupUserSiteaccess( $parameters );
    eZSetupTranslationSiteAccesses( $parameters, $setupData );

    $classIdentifier = 'template_look';
    //update template_look class
    $newAttributeIdArr = expandClass( $classIdentifier );
    foreach ( $newAttributeIdArr as $id )
    {
        updateObject( $classIdentifier, $id );
    }

    //get the class
    $class = eZContentClass::fetchByIdentifier( $classIdentifier, true, EZ_CLASS_VERSION_STATUS_TEMPORARY );
    if ( !$class )
    {
        addError( "Warning, TEMPORARY version for class id $classIdentifier does not exist.", false );
        $class = eZContentClass::fetchByIdentifier( $classIdentifier, true, EZ_CLASS_VERSION_STATUS_DEFINED );
        if ( !$class )
        {
            addError( "Warning, DEFINED version for class id $classIdentifier does not exist.", true );
        }
    }

    //get the class ID
    $classId = $class->attribute( 'id' );
    //get the ObjectList of class
    $objects = eZContentObject::fetchSameClassList( $classId );
    if ( !count( $objects ) )
    {
        addError( "Warning, object for class $classIdentifier does not exist.", true );
    }

    $templateLookObject = $objects[0];
    addData( $templateLookObject->attribute( 'id' ), $newAttributesDataArray );

    //move imported banners folder node to media node
    //moveTreeNode( "Banners", "Media" );

    //swap current root node with imported node "Home"
    swapNodes( "eZ publish", "Home" );

    //delete "eZ publish" contentobject
    doRemoveContentObject( 'eZ publish' );

    if ( $ezpVersionMajor == 3 && $ezpVersionMinor >= 9 )
    {
        $installer = new eZWebinInstaller( $parameters );
        $installer->postInstall();
    }
}


function loadSetupData( $parameters )
{
    //init vars
    $glob_setupData = array();
    $solutionExtensionName = "ezwebin";
    $solutionExtensionVersion = "1.0.0";

    // get locales chosen by user in the setup-wizard to create list of user siteaccess
    $glob_setupData['locales'] = $parameters['all_language_codes'];

    if ( count( $glob_setupData['locales'] ) < 1 )
        addError("Error in 'install-scripts.php'. Variable 'locales' value is less than 1", true);

    $glob_setupData['primaryLocale'] = $glob_setupData['locales'][0];
    $glob_setupData['secondaryLocale'] = "eng-GB";

    //get languages
    $glob_setupData['localeArr'] = array();
    $glob_setupData['languages'] = array();

    foreach ( $glob_setupData['locales'] as $locale )
    {
        $glob_setupData['languages'][] = getLanguage( $locale );
        $glob_setupData['localeArr'][$locale] = getLanguage( $locale );
    }

    $glob_setupData['primaryLanguage'] = getLanguage( $glob_setupData['primaryLocale'] );
    $glob_setupData['secondaryLanguage'] = getLanguage( $glob_setupData['secondaryLocale'] );

    //diverse vars
    $glob_setupData['mainSiteDesign'] = $solutionExtensionName;
    $glob_setupData['user_siteaccess'] = $parameters['user_siteaccess'];
    $glob_setupData['admin_siteacces'] = $parameters['admin_siteaccess'];
    $glob_setupData['extensionsToActivate'] = array( $solutionExtensionName );
    $glob_setupData['versions'][ $solutionExtensionName ] = $solutionExtensionVersion;

    //get siteaccesses
    $glob_setupData['allSiteaccesses'] = array_merge( $glob_setupData['languages'], $glob_setupData['user_siteaccess'], $glob_setupData['admin_siteacces'] );
    $glob_setupData['allUserSiteaccesses'] = array_merge($glob_setupData['user_siteaccess'], $glob_setupData['languages'] );
    $glob_setupData['allAdminSiteaccesses'] = $glob_setupData['admin_siteacces'];
    $glob_setupData['siteaccessURLs'] = isset( $parameters['siteaccess_urls'] ) ? $parameters['siteaccess_urls'] : array();

    return $glob_setupData;
}


function testAccess( $dirNameParam )
{
    if ( !file_exists( $dirNameParam ) )
    {
        ezDir::mkdir( $dirNameParam );
    }
    $canWrite = ezDir::isWriteable( $dirNameParam );
    if ( !$canWrite )
    {
        echo "FATAL ERROR! The webserver does not have write-access to the folder $dirNameParam.\n";
        echo "If you do not know how to fix this, try these suggestions:\n";
        echo "1. Contact your hosting provider support and ask them to give the webserver access to this folder under the eZ publish root.\n";
        echo "2. Contact your eZ provider if you have a support agreement, and ask them for help.\n";
        echo "3. You may also try to get some help from the eZ publish community forum on http://ez.no/community/forum .\n";
        echo "The installation script failed in package ezwebcms_site.ezpkg, script install-scripts.php, function testAccess.\n";
        exit;
    }
    return $canWrite;
}


/*
\brief collects error messages and halts script if wanted. uses global var $wcms_script_errors.
\param $errorStrParam string with error message
\param $exitbool if set to true, then output all collected error messages and halts script
*/
function addError( $errorStrParam, $exitBoolParam = false )
{
    global $wcms_script_errors;

    $wcms_script_errors[ count( $wcms_script_errors ) ] = $errorStrParam;

    if ( $exitBoolParam )
    {
        echo "<br />SCRIPT WAS GIVEN INSTRUCTION TO HALT!<br />";
        echo "<br />Dumping error array:<br />";

        foreach ( $wcms_script_errors as $errorMessage )
        {
            echo "<br /><pre>";
            var_dump( $errorMessage );
            echo "</pre><br />";
        }

        exit();
    }

    return true;
}


/*
retrieve array of locales in the database
returns raw sql result in an array
*/
function getColumn( $column, $table)
{
    // Find out the translations that are availalble
    $db = eZDB::instance();
    $result = array();
    $result = $db->arrayQuery( "SELECT ".$column." FROM ".$table );

    return $result;
}


/*
retrieve array of locales in the database
*/
function getLocales()
{
    $locales = array();
    $result = getColumn( "locale", "ezcontent_language");

    foreach ($result as $item)
    {
        array_push( $locales, $item["locale"] );
    }

    return $locales;
}


/*
returns a array with locales, sorted with the primary locale first, and the optional secondary locale second
*/
function sortLocales( $localesParam, $defaultLocaleParam , $secondDefaultLocaleParam = "eng-GB" )
{
    //init vars
    $returnVar = array();
    $tempVar1 = array();
    $tempVar2 = array();
    $defaultLocale = $defaultLocaleParam;
    $secondDefaultLocale = $secondDefaultLocaleParam;

    //find the default locale and place it first in the new array
    foreach ( $localesParam as $locale )
    {
        if ( $locale == $defaultLocale )
        $returnVar[] = $locale;
        else
        $tempVar1[] = $locale;
    }

    //if the locale array contains a secondary favoured language, place it second, unless it is already placed first
    if ( ( !in_array( $secondDefaultLocale , $returnVar ) ) && ( in_array( $secondDefaultLocale , $tempVar1 ) ) )
    {
        foreach ( $tempVar1 as $locale )
        {
            if ( $locale == $secondDefaultLocale )
            {
                $returnVar[] = $locale;
            }
            else
            {
                $tempVar2[] = $locale;
            }
        }
        $returnVar = array_merge( $returnVar, $tempVar2 );
    }
    else
    {
        $returnVar = array_merge( $returnVar, $tempVar1 );
    }

    return $returnVar;

}


/*
separates language code from country code in locale code
returns languagecodes in an arry
*/
function getSiteaccessNames( $localesParam )
{
    $returnVar = array();

    foreach( $localesParam as $locale )
    {
        //extract the language code
        $languageCodePos = strpos( $locale , "-");
        $languageCode = substr( $locale , 0, $languageCodePos );
        array_push( $returnVar, $languageCode );
    }

    return $returnVar;
}


function getLanguage( $languageCodeParam )
{
    //init vars
    $returnVar = false;

    //extract the language code
    $languageCodePos = strpos( $languageCodeParam , "-");
    $languageCode = substr( $languageCodeParam , 0, $languageCodePos );
    $returnVar = $languageCode;

    return $returnVar;
}


function getPersistenceList()
{
    $persistenceList = array();
    include_once( 'lib/ezutils/classes/ezhttptool.php' );
    $http = eZHTTPTool::instance();
    $postVariables = $http->attribute( 'post' );

    foreach ( $postVariables as $name => $value )
    {
        if ( preg_match( '/^P_([a-zA-Z0-9_]+)-([a-zA-Z0-9_]+)$/', $name, $matches ) )
        {
            $persistenceGroup = $matches[1];
            $persistenceName = $matches[2];
            $persistenceList[$persistenceGroup][$persistenceName] = $value;
        }
    }

    return $persistenceList;
}


/*
\return a string with the primary language code
*/
/*DEPRECATED
function getPrimaryLocale()
{
//init vars
$persistenceList = getPersistenceList();

return $persistenceList['regional_info']['primary_language'];
}
*/

?>
