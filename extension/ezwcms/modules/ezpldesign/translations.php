<?php
//
// Definition of Translations class
//
// Created on: <26-Jul-2006 11:21:21 ce>
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

/*! \file translations.php
*/

/*!
   Copy of kernel/content/translations.php, just added creation of
   siteaccess when a new translation is added
*/


include_once( 'kernel/common/template.php' );
include_once( 'kernel/classes/ezcontentlanguage.php' );
include_once( 'kernel/classes/ezcontentobject.php' );
include_once( 'extension/ezwcms/classes/ezcontentlanguagesiteaccess.php' );
include_once( 'lib/ezdb/classes/ezdb.php' );

$tpl =& templateInit();
$http =& eZHTTPTool::instance();
$Module =& $Params['Module'];
$error = false;

$tpl->setVariable( 'module', $Module );


if ( $Module->isCurrentAction( 'New' ) /*or
     $Module->isCurrentAction( 'Edit' )*/ )
{
    $tpl->setVariable( 'is_edit', $Module->isCurrentAction( 'Edit' ) );
    $Result['content'] =& $tpl->fetch( 'design:content/translationnew.tpl' );
    $Result['path'] = array( array( 'text' => ezi18n( 'translation', 'Translation' ),
                                    'url' => false ),
                             array( 'text' => 'New',
                                    'url' => false ) );
    return;
}

if ( $Module->isCurrentAction( 'StoreNew' ) /* || $http->hasPostVariable( 'StoreButton' ) */ )
{
    $localeID = $Module->actionParameter( 'LocaleID' );
    $translationName = '';
    $translationLocale = '';
    eZDebug::writeDebug( $localeID, 'localeID' );
    if ( $localeID != '' and
         $localeID != -1 )
    {
        $translationLocale = $localeID;
        $localeInstance =& eZLocale::instance( $translationLocale );
        $translationName = $localeInstance->internationalLanguageName();
    }
    else
    {
        $translationName = $Module->actionParameter( 'TranslationName' );
        $translationLocale = $Module->actionParameter( 'TranslationLocale' );
        eZDebug::writeDebug( $translationName, 'translationName' );
        eZDebug::writeDebug( $translationLocale, 'translationLocale' );
    }

    include_once( 'lib/ezlocale/classes/ezlocale.php' );
    // Make sure the locale string is valid, if not we try to extract a valid part of it
    if ( !preg_match( "/^" . eZLocale::localeRegexp( false, false ) . "$/", $translationLocale ) )
    {
        if ( preg_match( "/(" . eZLocale::localeRegexp( false, false ) . ")/", $translationLocale, $matches ) )
        {
            $translationLocale = $matches[1];
        }
        else
        {
            // The locale cannot be used so we show the edit page again.
            $tpl->setVariable( 'is_edit', $Module->isCurrentAction( 'Edit' ) );
            $Result['content'] =& $tpl->fetch( 'design:content/translationnew.tpl' );
            $Result['path'] = array( array( 'text' => ezi18n( 'translation', 'Translation' ),
                                            'url' => false ),
                                     array( 'text' => 'New',
                                            'url' => false ) );
            return;
        }
    }

    if ( !eZContentLanguage::fetchByLocale( $translationLocale ) )
    {
        $locale =& eZLocale::instance( $translationLocale );
        if ( $locale->isValid() )
        {
            $translation = eZContentLanguage::addLanguage( $locale->localeCode(), $translationName );
            include_once( "extension/ezpl/packages/ezecms_site/settings/install-scripts.php" );
            createSiteAccess( $locale->localeCode(), "ezpecms", eZContentLanguage::fetchLocaleList(), true );
        }
        else
        {
            // The locale cannot be used so we show the edit page again.
            $tpl->setVariable( 'is_edit', $Module->isCurrentAction( 'Edit' ) );
            $Result['content'] =& $tpl->fetch( 'design:content/translationnew.tpl' );
            $Result['path'] = array( array( 'text' => ezi18n( 'translation', 'Translation' ),
                                            'url' => false ),
                                     array( 'text' => 'New',
                                            'url' => false ) );
            return;
        }
    }
}

if ( $Module->isCurrentAction( 'Update' ) )
{
    $parameterError = false;
    if( $http->hasPostVariable( 'Priority' ) && $http->hasPostVariable( 'CurrentSiteAccess' ))
    {
        $siteaccess = $http->postVariable( 'CurrentSiteAccess' );
        $priorityArray = $http->postVariable( 'Priority' );
        foreach( $priorityArray as $key )
        {
            if ( (int) $key < 1 )
                $parameterError = true;
        }
        $prioritizedLanguages =& eZContentLanguageSiteAccess::prioritizedLanguageCodes( $siteaccess );
        if ( count( $priorityArray ) === count( $prioritizedLanguages ) &&
             count( $priorityArray ) === count( array_unique( $priorityArray ) ) &&
             !$parameterError )
        {
            $newPriorityArray = array();
            foreach( $priorityArray as $key )
            {
                $newPriorityArray[$key] = current( $prioritizedLanguages );
                next( $prioritizedLanguages );
            }
            ksort( $newPriorityArray );
            eZContentLanguageSiteAccess::setPrioritizedLanguages( $newPriorityArray, $siteaccess );
        }
        else
        {
            $error = true;
        }
    }
}

if ( $Module->isCurrentAction( 'Remove' ) )
{
    $seletedIDList = $Module->actionParameter( 'SelectedTranslationList' );

    $db =& eZDB::instance();

    $db->begin();
    foreach ( $seletedIDList as $translationID )
    {
        eZContentLanguage::removeLanguage( $translationID );
    }
    $db->commit();
}


if ( $Params['TranslationID'] )
{
    $translation = eZContentLanguage::fetch( $Params['TranslationID'] );

    if( !$translation )
    {
        return $Module->handleError( EZ_ERROR_KERNEL_NOT_AVAILABLE, 'kernel' );
    }

    $tpl->setVariable( 'translation',  $translation );

    $Result['content'] =& $tpl->fetch( 'design:content/translationview.tpl' );
    $Result['path'] = array( array( 'text' => ezi18n( 'translation', 'Content translations' ),
                                    'url' => 'content/translations' ),
                             array( 'text' => $translation->attribute( 'name' ),
                                    'url' => false ) );
    return;
}

if( $http->hasPostVariable( 'CurrentSiteAccess' ) )
{
    $availableTranslations = eZContentLanguageSiteAccess::prioritizedLanguages( false, $http->postVariable( 'CurrentSiteAccess' ));
}
else
$availableTranslations = null;


$tpl->setVariable( "error", $error );
$tpl->setVariable( 'available_translations', $availableTranslations );

$Result['content'] =& $tpl->fetch( 'design:content/translations.tpl' );
$Result['path'] = array( array( 'text' => ezi18n( 'translation', 'Languages' ),
                                'url' => 'ezwcms/translations' ) );

?>
