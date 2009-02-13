<?php

$eZTemplateOperatorArray = array();
$eZTemplateOperatorArray[] = array( 'script' => 'extension/ezwebin/autoloads/ezcreateclasslistgroups.php',
                                    'class' => 'eZCreateClassListGroups',
                                    'operator_names' => array( 'ezcreateclasslistgroups' ) );
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