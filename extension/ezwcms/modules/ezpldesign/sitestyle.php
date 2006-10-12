<?php
//
// Definition of Toolbar class
//
// Created on: <12-Jul-2006 11:40:59 ce>
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

/*! \file toolbar.php
*/

$http =& eZHTTPTool::instance();
$module =& $Params["Module"];

include_once( "kernel/common/template.php" );
include_once( 'lib/ezutils/classes/ezhttptool.php' );
include_once( 'kernel/classes/ezcontentbrowse.php' );
include_once( 'kernel/classes/ezpackage.php' );

$http =& eZHTTPTool::instance();

$siteini =& eZINI::instance();
$tpl =& templateInit();

if ( $http->hasPostVariable( "ChangeStyle" ) )
{
    $currentSiteAccess = $http->postVariable( "CurrentSiteAccess" );
    if ( $http->hasPostVariable( "PackageName" ) )
    {
        $packageName = $http->postVariable( "PackageName" );
        $package = eZPackage::fetch( $packageName );
        if ( $package )
        {
            $fileList = $package->fileList( 'default' );
            foreach ( array_keys( $fileList ) as $key )
            {
                $file =& $fileList[$key];
                $fileIdentifier = $file["variable-name"];
                if ( $fileIdentifier == 'sitecssfile' )
                {
                    $siteCSS = $package->fileItemPath( $file, 'default' );
                }
                else if ( $fileIdentifier == 'classescssfile' )
                {
                    $classesCSS = $package->fileItemPath( $file, 'default' );
                }
            }

            if ( $http->hasPostVariable( "CurrentSiteAccess" ) )
            {
                // This should get the extension ini if it exists..
                $currentSiteAccess = $http->postVariable( "CurrentSiteAccess" );
                $iniPath = "settings/siteaccess/$currentSiteAccess";
                $designINI =& eZIni::instance( "design.ini.append", $iniPath, null, false, null, true, true );
            }
            else
            {
                $iniPath = 'settings/override';
                $designINI =& eZIni::instance( 'design.ini.append.php', $iniPath, null, false, null, true );
            }

            $designINI->setVariable( 'StylesheetSettings', 'PageStyle', $packageName ); 
            $designINI->setVariable( 'StylesheetSettings', 'SiteCSS', $siteCSS );
            $designINI->setVariable( 'StylesheetSettings', 'ClassesCSS', $classesCSS );
            $designINI->save( false, false, false );
        }
    }
}


$Result = array();
$Result['content'] =& $tpl->fetch( "design:sitestyle.tpl" );
$Result['path'] = array( array( 'url' => 'ezwcms/sitestyle',
                                'text' => ezi18n( 'kernel/design', 'Sitestyle' ) ) );

?>
