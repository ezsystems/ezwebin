<?php
//
// Created on: <06-Jul-2006 14:58:04 ce>
//
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

$Module = array( "name" => "eZLightning" );

$ViewList = array();

$ViewList["sitestyle"] = array(
    "script" => "sitestyle.php",
    'default_navigation_part' => 'ezlightningnavigationpart',
    "params" => array() );

$ViewList['translations'] = array(
    'functions' => array( 'translations' ),
    'ui_context' => 'administration',
    'default_navigation_part' => 'ezsetupnavigationpart',
    'script' => 'translations.php',
    'single_post_actions' => array( 'RemoveButton' => 'Remove',
                                    'StoreButton' => 'StoreNew',
                                    'NewButton' => 'New',
                                    'UpdatePriority' => 'Update',
                                    'ConfirmButton' => 'Confirm' ),
    'post_action_parameters' => array( 'StoreNew' => array( 'LocaleID' => 'LocaleID',
                                                            'TranslationName' => 'TranslationName',
                                                            'TranslationLocale' => 'TranslationLocale' ),
                                       'Remove' => array( 'SelectedTranslationList' => 'DeleteIDArray' ),
                                       'Confirm' => array( 'ConfirmList' => 'ConfirmTranlationID' ) ),
    'params' => array( 'TranslationID' ) );


?>
