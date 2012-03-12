<?php
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Publish Website Interface
// SOFTWARE RELEASE: 1.4-0
// COPYRIGHT NOTICE: Copyright (C) 1999-2012 eZ Systems AS
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

$eZTemplateOperatorArray = array();

$eZTemplateOperatorArray[] = array( 'script' => 'extension/ezwebin/autoloads/ezkeywordlist.php',
                                    'class' => 'eZKeywordList',
                                    'operator_names' => array( 'ezkeywordlist' ) );
$eZTemplateOperatorArray[] = array( 'script' => 'extension/ezwebin/autoloads/ezarchive.php',
                                    'class' => 'eZArchive',
                                    'operator_names' => array( 'ezarchive' ) );
$eZTemplateOperatorArray[] = array( 'script' => 'extension/ezwebin/autoloads/eztagcloud.php',
                                    'class' => 'eZTagCloud',
                                    'operator_names' => array( 'eztagcloud' ) );
$eZTemplateOperatorArray[] = array( 'script' => 'extension/ezwebin/autoloads/ezpagedata.php',
                                    'class' => 'eZPageData',
                                    'operator_names' => array( 'ezpagedata', 'ezpagedata_set', 'ezpagedata_append' ) );
?>
