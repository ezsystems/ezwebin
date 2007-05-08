<?php
//
// Created on: <21-Jul-2006 11:26:42 ce>
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

/*
    Modify user_siteaccess so it is ready to be copied by the translationsiteaccesses
*/
function eZSetupUserSiteaccess( $parameters )
{
    $setupData = loadSetupData( $parameters );

    $settings =& eZINI::instance( "site.ini.append.php", "settings/siteaccess/".$setupData['user_siteaccess'], null, false, null, true );
    $settings->setVariable( "DesignSettings", "SiteDesign", $setupData["mainSiteDesign"] );
    $settings->setVariable( "SiteAccessSettings", "RelatedSiteAccessList", $setupData["allSiteaccesses"] );
    $settings->save( false, false, false, false, true, true );
    unset( $settings );

    return true;
}

/*
   Make siteaccess for each translation that was added.
 */
function eZSetupTranslationSiteAccesses( $parameters, $setupDataParam )
{
    //initiate variables
    $setupData = $setupDataParam;

    $languageArr = $setupData['languages'];
    $localeArr = $setupData['locales'];

    foreach ( $setupData['localeArr'] as $locale => $language )
    {
        // Do not override site.ini override, since ini-common.ini will do it
        createSiteAccess( $language, $locale, $setupData['user_siteaccess'], $setupData['locales'], false, $setupData['primaryLocale'], $setupData );
    }

    return true;
}


/*
   Copy the database settings from the admin user site to the default admin site
 */
function eZSetupAdminSiteAccess( $parameters )
{
    $setupData = loadSetupData( $parameters );

    $adminSiteINI =& eZINI::instance( "site.ini.append.php", "settings/siteaccess/" . $parameters["admin_siteaccess"], null, false, null, true );
//    $adminINI =& eZINI::instance( "site.ini.append.php", "settings/siteaccess/admin", null, false, null, true );
//    $adminINI->setVariables( array( "DatabaseSettings" => $adminSiteINI->group( "DatabaseSettings" ) ) );
    $adminSiteINI->setVariable( "DesignSettings", "SiteDesign", $parameters["admin_siteaccess"] );
    $adminSiteINI->setVariable( "DesignSettings", "AdditionalSiteDesignList", array( "admin" ) );
    $adminSiteINI->setVariable( "SiteAccessSettings", "RelatedSiteAccessList", $setupData["allSiteaccesses"] );
//    $adminINI->save();
    $adminSiteINI->save();
}


/*
  \param $siteaccessNameParam the name of the siteaccess to be created
  \param $localeCodeParam represent a localeCode string containg language
  and country, i.e eng-GB
  \param $sourceParam an string of the source directory which should be copy
  \param $localeCodesArrParam an array of all available localecodes
  \param $addOverride if true then add it to availablesiteaccesses in site.ini override
 */
function createSiteAccess( $siteaccessNameParam,
                           $localeCodeParam,
                           $sourceParam,
                           $localeCodesArrParam,
                           $addOverride,
                           $secondaryLocaleParam = "eng-GB",
                           $setupDataParam )
{
    //get global vars
    $setupData = $setupDataParam;
    //if ( count( $setupData['user_siteacess'] ) < 1 ) addError( "line 448", true );
    //addError( array("createsiteaccess" => $setupData ), false );

    // Grab the site.ini for the user siteaccess
    $userSiteINI =& eZINI::instance( "site.ini.append.php", "settings/siteaccess/" . $sourceParam, null, false, null, true );

    //get  params
    $siteaccessName = $siteaccessNameParam;
    $localeCode = $localeCodeParam;
    $source = $sourceParam;

    $sortedLocales = sortLocales( $localeCodesArrParam, $localeCode, $secondaryLocaleParam );

    //test params
    if ( strlen($siteaccessName)<1 ) addError( "siteaccessname does not contain anything", true );

    // Create the siteaccess translation directory
    $source = "settings/siteaccess/" . $source;
    $destination = "settings/siteaccess/" . $siteaccessName;
    eZDir::mkdir( $destination, false, true );
    eZDir::copy( $source, $destination, false, true );

    // Modify the ini settings, the ini-common.php will add
    // the site to AvailableSiteAccessList in override
    // site.ini
    $siteINIFile = $destination . "/site.ini.append.php";
    if( is_file( $siteINIFile ) )
    {
        $translationSiteINI =& eZINI::instance( "site.ini.append.php", $destination, null, false, null, true );
        $translationSiteINI->setVariable( "RegionalSettings", "Locale", $localeCode );

        if ( $localeCode != 'eng-GB' )
            $translationSiteINI->setVariable( "RegionalSettings", "TextTranslation", 'enabled' );
        else
            $translationSiteINI->setVariable( "RegionalSettings", "TextTranslation", 'disabled' );

        //use only translated content in current locale, OR default locale (check if they are the same first)
        if ( $localeCode == $setupData['primaryLocale'] )
            $translationSiteINI->setVariable( "RegionalSettings", "SiteLanguageList", array( $localeCode ) );
        else
            $translationSiteINI->setVariable( "RegionalSettings", "SiteLanguageList", array( $localeCode, $setupData['primaryLocale'] ) );

        $translationSiteINI->setVariable( "RegionalSettings", "ContentObjectLocale", $localeCode );

        $translationSiteINI->save(  false, false, false, false, true, true );
        unset( $translationSiteINI );
    }

    // Create roles
    $role = eZRole::fetchByName( "Anonymous" );
    $role->appendPolicy( "user", "login", array( "SiteAccess" => array( eZSys::ezcrc32( $siteaccessName ) ) ) );
    $role->store();
}

?>