<?php
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Website Toolbar
// SOFTWARE RELEASE: 1.0-0
// COPYRIGHT NOTICE: Copyright (C) 1999-2009 eZ Systems AS
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

$Module = array( 'name' => 'Website Toolbar',
                 'variable_params' => true,
                 'functions' => array( 'use' ),
                 'function' => array( 'script' => 'websitetoolbar.php' ) );

$ViewList = array();

$ViewList['sort'] = array( 'functions' => array( 'use' ),
                           'script' => 'sort.php',
                           'params' => array( 'NodeID' ),
                           'unordered_params' => array( 'language' => 'Language',
                                                        'offset' => 'Offset',
                                                        'year' => 'Year',
                                                        'month' => 'Month',
                                                        'day' => 'Day' ) );

$FunctionList['use'] = array( 'Class' => array( 'name'=> 'Class',
                                                'values'=> array(),
                                                'path' => 'classes/',
                                                'file' => 'ezcontentclass.php',
                                                'class' => 'eZContentClass',
                                                'function' => 'fetchList',
                                                'parameter' => array( 0, false, false, array( 'name' => 'asc' ) ) ) );



?>
