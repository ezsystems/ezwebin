<?php
//
// Definition of eZContentLanguage class
//
// Created on: <27-Jul-2006 14:14:13 ce>
//
// SOFTWARE NAME: eZ publish
// SOFTWARE RELEASE: 3.8.1
// BUILD VERSION: 16284
// COPYRIGHT NOTICE: Copyright (C) 1999-2006 eZ systems AS
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

include_once( 'kernel/classes/ezpersistentobject.php' );
include_once( 'kernel/classes/ezcontentlanguage.php' );
include_once( 'lib/ezlocale/classes/ezlocale.php' );

define( 'CONTENT_LANGUAGES_MAX_COUNT', 30 );

class eZContentLanguageSiteAccess extends eZContentLanguage
{
    /**
     * Fetches the list of the prioritized languages (in the correct order).
     *
     * \param languageList Optional. If specified, this array of locale codes with will override the INI
     *                     settings. Usage of this parameter is restricted to methods of this class!
     *                     See eZContentLanguage::setPrioritizedLanguages().
     * \param siteaccess Defines which siteaccess to use.
     * \return Array of the eZContentLanguage objects of the prioritized languages.
     * \static 
     */
    function prioritizedLanguages( $languageList = false, $siteaccess )
    {
        $return = array();

        if ( is_file ( "settings/siteaccess/$siteaccess/site.ini.append.php" ) )
        {
            $siteaccessINI =& eZINI::instance( "site.ini.append.php", "settings/siteaccess/$siteaccess/", null, false, null, true );
            $overrideSiteINI =& eZINI::instance( "site.ini.append.php", "settings/override/", null, false, null, true );

            if ( !$languageList && $siteaccessINI->hasVariable( 'RegionalSettings', 'SiteLanguageList' ) )
            {
                $languageList = array_merge( $siteaccessINI->variable( 'RegionalSettings', 'SiteLanguageList' ),
                                             $overrideSiteINI->variable( 'RegionalSettings', 'SiteLanguageList' ) );
            }

            if ( !$languageList )
            {
                $languageList = array( $siteaccessINI->variable( 'RegionalSettings', 'ContentObjectLocale' ) );
            }

            $processedLocaleCodes = array();
            foreach ( $languageList as $localeCode )
            {
                if ( in_array( $localeCode, $processedLocaleCodes ) )
                {
                    continue;
                }
                $processedLocaleCodes[] = $localeCode;
                $language = eZContentLanguage::fetchByLocale( $localeCode );
                if ( $language )
                {
                    $return[] = $language;
                }
                else
                {
                    eZDebug::writeWarning( "Language '$localeCode' does not exist or is not used!", 'eZContentLanguage::prioritizedLanguages' );
                }
            }
        }
        else
        {
            $return =& parent::prioritizedLanguages( $languageList );
        }
        return $return;
    }

    /**
     * Returns the array of the locale codes of the prioritized languages (in the correct order).
     *
     * \param siteaccess Defines which siteaccess to use.
     * \return Array of the locale codes of the prioritized languages (in the correct order).
     * \see eZContentLanguage::prioritizedLanguages()
     * \static 
     */
    function prioritizedLanguageCodes( $siteaccess )
    {
        $languages = eZContentLanguageSiteAccess::prioritizedLanguages( false, $siteaccess );
        $localeList = array();

        foreach ( $languages as $language )
        {
            $localeList[] = $language->attribute( 'locale' );
        }

        return $localeList;
    }

    /**
     * Overrides the prioritized languages set by INI settings with the specified languages.
     *
     * \param siteaccess Defines which siteaccess to use.
     * \param languages Locale codes of the languages which will override the prioritized languages 
     *                  (the order is relevant).
     * \static 
     */
    function setPrioritizedLanguages( $languages, $siteaccess )
    {
        unset( $GLOBALS['eZContentLanguagePrioritizedLanguages'] );
        eZContentLanguageSiteAccess::prioritizedLanguages( $languages, null );

        // Write to siteaccess
        if( is_file( "settings/siteaccess/$siteaccess/site.ini.append.php" ) )
        {
            $siteaccessINI =& eZINI::instance( "site.ini.append.php", "settings/siteaccess/$siteaccess/", null, false, null, true );
            $siteaccessINI->setVariable( "RegionalSettings", "SiteLanguageList", $languages );
            $siteaccessINI->save(  false, false, false, false, true, true );
        }
    }
}

?>
