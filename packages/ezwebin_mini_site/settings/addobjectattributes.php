<?php
//
// Created on: <20-Sept-2006 15:47:14 jkn>
//
// Copyright (C) 1999-2006 eZ systems as. All rights reserved.
//
// This source file is part of the eZ publish (tm) Open Source Content
// Management System.
//
// This file may be distributed and/or modified under the terms of the
// "GNU General Public License" version 2 as published by the Free
// Software Foundation and appearing in the file LICENSE.GPL included in
// the packaging of this file.
//
// Licencees holding valid "eZ publish professional licences" may use this
// file in accordance with the "eZ publish professional licence" Agreement
// provided with the Software.
//
// This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
// THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE.
//
// The "eZ publish professional licence" is available at
// http://ez.no/products/licences/professional/. For pricing of this licence
// please contact us via e-mail to licence@ez.no. Further contact
// information is available at http://ez.no/home/contact/.
//
// The "GNU General Public License" (GPL) is available at
// http://www.gnu.org/copyleft/gpl.html.
//
// Contact licence@ez.no if any conditions of this licencing isn't clear to
// you.
//

/*! \file addobjectattributes.php
*/

//TODO: this file can be made more efficient

include_once( 'kernel/classes/ezcontentobject.php' );
include_once( 'kernel/classes/ezcontentobjectattribute.php' );


function expandClass( $classIdentifierParam )
{
    /* INIT VARS */

    //contentclass vars
    $class = false;
    $classID = 0;

    //for attributes
    $currentAttributesArray = false;
    //$newAttributesArray = false;
    $attributeObject = false;
    $newAttributeObjectArr = array();
    $newAttributeIDArray = array();

    //get the class
    $class = eZContentClass::fetchByIdentifier( $classIdentifierParam, true, EZ_CLASS_VERSION_STATUS_TEMPORARY );

    if ( !$class )
    {
        addError( "Notice: TEMPORARY version for class id $classIdentifierParam does not exist.", false );
        $class = eZContentClass::fetchByIdentifier( $classIdentifierParam, true, EZ_CLASS_VERSION_STATUS_DEFINED );

        if ( !$class )
            addError( "Fatal error, DEFINED version for class id $classIdentifierParam does not exist.", true );
    }

    //get the class ID
    $classID = $class->attribute( 'id' );

    //building a matrix that is used as a ezmatrix attribute in class template_look
    $tempColumnDefinition = new eZMatrixDefinition();
    $tempColumnDefinition->addColumn( "Site URL", "site_url" );
    $tempColumnDefinition->addColumn( "Siteaccess", "siteaccess" );
    $tempColumnDefinition->addColumn( "Language name", "language_name" );
    $tempColumnDefinition->decodeClassAttribute( $tempColumnDefinition->xmlString() );
    addError( array("tempColumnDefinition" => $tempColumnDefinition ), false);

    $newAttributesArray = array( array( "data_type_string" => "ezurl",
                                        "name" => "Site map URL",
                                        "identifier" => "site_map_url",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "ezurl",
                                        "name" => "Tag Cloud URL",
                                        "identifier" => "tag_cloud_url",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "ezstring",
                                        "name" => "Login (label)",
                                        "identifier" => "login_label",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "ezstring",
                                        "name" => "Logout (label)",
                                        "identifier" => "logout_label",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "ezstring",
                                        "name" => "My profile (label)",
                                        "identifier" => "my_profile_label",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "ezstring",
                                        "name" => "Register new user (label)",
                                        "identifier" => "register_user_label",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "ezstring",
                                        "name" => "RSS feed",
                                        "identifier" => "rss_feed",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "ezstring",
                                        "name" => "Shopping basket (label)",
                                        "identifier" => "shopping_basket_label",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "ezstring",
                                        "name" => "Site settings (label)",
                                        "identifier" => "site_settings_label",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "ezmatrix",
                                        "name" => "Language settings",
                                        "identifier" => "language_settings",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0,
                                        "content" => $tempColumnDefinition ),
                                 array( "data_type_string" => "eztext",
                                        "name" => "Footer text",
                                        "identifier" => "footer_text",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "ezboolean",
                                        "name" => "Hide \"Powered by\"",
                                        "identifier" => "hide_powered_by",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ),
                                 array( "data_type_string" => "eztext",
                                        "name" => "Footer Javascript",
                                        "identifier" => "footer_script",
                                        "can_translate" => 1,
                                        "version" => 1,
                                        "is_required" => 0,
                                        "is_searchable" => 0 ) );


    //addError( array( "newAttributesArray", $newAttributesArray ), false );
    foreach ( $newAttributesArray as $newAttribute )
    {
        $attributeObject = eZContentClassAttribute::create( $classID,
                                                            $newAttribute["data_type_string"],
                                                            $newAttribute );

        if ( $newAttribute["data_type_string"] == "ezmatrix" )
        {
            $attributeObject->setContent( $newAttribute["content"] );
        }
        $attributeObject->store();

        $newAttributeObjectArr[] = $attributeObject->clone();

        $newAttributeIDArray[] = $attributeObject->attribute( 'id' );
    }

    //add attributes to class
    $currentAttributeObjectArray = false;
    $currentAttributeObjectArray = $class->fetchAttributes();

    //merge arrays with existing and new attributes
    $attributeObjectsToBeStored = array();
    $attributeObjectsToBeStored = array_merge( $currentAttributeObjectArray, $newAttributeObjectArr );

    //store attribute array
    if ( $class->attribute( 'version' ) == EZ_CLASS_VERSION_STATUS_DEFINED )
    {
        // if class was not temporary, copy class-group assignments as TEMPORARY
        // because DEFINED will be removed by storeDefined() method
        $classGroups = $class->fetchGroupList();
        foreach ( $classGroups as $classGroup )
        {
            $groupID = $classGroup->attribute( 'group_id' );
            $groupName = $classGroup->attribute( 'group_name' );
            $ingroup = eZContentClassClassGroup::create( $classID, EZ_CLASS_VERSION_STATUS_TEMPORARY, $groupID, $groupName );
            $ingroup->store();
        }
    }
    $class->storeDefined( $attributeObjectsToBeStored );

    $diff = getAttributeIdDiff( $currentAttributeObjectArray, $attributeObjectsToBeStored );

    $db =& eZDB::instance();
    foreach ( $diff as $id )
    {
        $queryResult = $db->query( "UPDATE ezcontentclass_attribute SET version=0 WHERE id=".$id );
        if ( !$queryResult ) addError( array("sqlupdate failed", $queryResult ), true );
    }

    return $diff;
}


//update the specified contentobject with all versions and translations with the changes in the attributes in the contentclass
function updateObject( $classIdentifierParam = false, $newAttributeIdArrParam = false )
{

    if ( !$classIdentifierParam )
        addError( array( "function:updateObject", "error:function paramater classIdentiferParam invalid!" ), true );

    if ( !$newAttributeIdArrParam )
        addError( array( "function:updateClass", "error:function paramater newAttributeIdArrParam invalid!" ), true );


    /* INIT VARS */
    $newAttributeIdArr = $newAttributeIdArrParam;
    $class = false;

    //the data to put in the new attribute
    /*$contentContainer = "";
    $content = "";

    if ( $dataArr != false)
    {
        $contentContainer = $dataArr['container'];
        $content = $dataArr['data'];
    }*/

    //get the class
    $class = eZContentClass::fetchByIdentifier( $classIdentifierParam, true, EZ_CLASS_VERSION_STATUS_TEMPORARY );
    if ( !$class )
    {
        addError( "Notice: TEMPORARY version for class id $classIdentifierParam does not exist.", false );
        $class = eZContentClass::fetchByIdentifier( $classIdentifierParam, true, EZ_CLASS_VERSION_STATUS_DEFINED );
        if ( !$class )
        {
            addError( "Fatal error, DEFINED version for class id $classIdentifierParam does not exist.", true );
        }
    }

    //get the class ID
    $classId = $class->attribute( 'id' );

    $objectLimit = 1000;
    $objectOffset = 0;

    $conditions = array( 'contentclass_id' => $classId );

    $totalObjectCount = eZContentObject::fetchListCount( $conditions );

    $objects = eZContentObject::fetchList( true, $conditions, $objectOffset, $objectLimit );


    $totalObjectMod = intVal( $totalObjectCount / 1000 );

    $newAttributeId = $newAttributeIdArr;

    //foreach ( $newAttributeIdArr as $newAttributeId )
    //{
                while ( count( $objects ) > 0 )
                {
                    // add new attributes for all versions and translations of all objects
                    foreach ( $objects as $object )
                    {
                        $contentobjectID =& $object->attribute( 'id' );
                        $objectVersions =& $object->versions();


                        foreach ( $objectVersions as $objectVersion )
                        {
                            $translations =& $objectVersion->translations( false );
                            //addError( array( "translations", $translations ), false );
                            $version =& $objectVersion->attribute( 'version' );
                            //addError( array( "version", $version ), false );
                            foreach ( $translations as $translation )
                            {
                                //$objectAttribute = eZContentObjectAttribute::create( $newClassAttributeID, $contentobjectID, $version );
                                $objectAttribute = eZContentObjectAttribute::create( $newAttributeId, $contentobjectID, $version );

                                $objectAttribute->setAttribute( 'language_code', $translation );

                                $objectAttribute->initialize(); //initialize attribute value

                                $objectAttribute->store();
                                unset( $objectAttribute );
                            }
                            unset( $version );
                        }

                        unset( $contentobjectID );
                        unset( $objectVersions );
                        unset( $translation );
                    }

                    unset( $objects );
                    $objectOffset += $objectLimit;
                    $objects = eZContentObject::fetchList( true, $conditions, $objectOffset, $objectLimit );
                }

    //}
    //$class->store();
    //$myContentObjectAttributes =& $class->ContentObjectAttributes();

    return true;

}


//provide an array of attribute Id's that was added
function getAttributeIdDiff( $arr1, $arr2 )
{

    $before = array();
    foreach ( $arr1 as $object )
    {
        $before[] = $object->attribute('id');
    }

    $after = array();
    foreach ( $arr2 as $object )
    {
            $after[] = $object->attribute('id');
    }

    $diff = array_diff( $after, $before );

    return $diff;
}


function addData( $contentObjectIdParam = false, $dataArrParam = false )
{
    //check parameter 1
    if ( !$contentObjectIdParam )
    {
        addError( array( "function:updateObject", "error:function parameter classIdentiferParam invalid!" ), true );
    }
    else
    {
        $myContentObject = eZContentObject::fetch( $contentObjectIdParam );
        if ( !$myContentObject )
            addError( "Fatal error! could not fetch contentObject based on $contentObjectIdParam!", true );
    }

    //check parameter 2
    if ( !$dataArrParam )
    {
        addError( array( "function:updateObject", "error:function parameter dataArrParam invalid!" ), true );
    }
    else
    {
        $dataArr = $dataArrParam;
    }

    //get datamap
    $myContentObjectDataMap =& $myContentObject->dataMap();

    foreach ( $dataArr as $index => $value )
    {
        $myContentObjectAttribute =& $myContentObjectDataMap[ $index ];
        if ( !$myContentObjectAttribute )
        {
            addError( "Fatal error! could not acquire myContentObjectAttribute with index $index.", false );
            continue;
        }

        //get datatype name
        $myDataTypeString = $myContentObjectAttribute->attribute( 'data_type_string' );

        switch ( $myDataTypeString )
        {
            case 'ezstring':
            {
                $myContentObjectAttribute->setAttribute( "data_text", $value['DataText']);
            } break;

            case 'ezxmltext':
            {
                $xml = '<?xml version="1.0" encoding="utf-8"?>'."\n".
                       '<section xmlns:image="http://ez.no/namespaces/ezpublish3/image/"'."\n".
                       '         xmlns:xhtml="http://ez.no/namespaces/ezpublish3/xhtml/"'."\n".
                       '         xmlns:custom="http://ez.no/namespaces/ezpublish3/custom/">'."\n".
                       '  <section>'."\n";
                {
                    $xml .= '    <paragraph>';
                    $numSentences = mt_rand( ( int ) $attributeParameters['min_sentences'], ( int ) $attributeParameters['max_sentences'] );
                    for ( $sentence = 0; $sentence < $numSentences; $sentence++ )
                    {
                        if ( $sentence != 0 )
                        {
                            $xml .= ' ';
                        }
                        $xml .= eZLoremIpsum::generateSentence();
                    }
                    $xml .= "</paragraph>\n";
                }
                $xml .= "  </section>\n</section>\n";

                $myContentObjectAttribute->setAttribute( 'data_text', $xml );
            } break;

            case 'eztext':
            {
                $myContentObjectAttribute->setAttribute( 'data_text', $value['DataText'] );
            } break;

            case 'ezmatrix':
            {
                $columnsCount = count( $value["MatrixDefinition"]->attribute( 'columns' ) );
                if ( $columnsCount > 0 )
                {
                    $rowsCount = count( $value["MatrixCells"] ) / $columnsCount;

                    $tempMatrix = new eZMatrix( $value["MatrixTitle"], $rowsCount, $value["MatrixDefinition"] );
                    $tempMatrix->Cells = $value["MatrixCells"];

                    $myContentObjectAttribute->setAttribute( 'data_text', $tempMatrix->xmlString() );
                    $tempMatrix->decodeXML( $myContentObjectAttribute->attribute( 'data_text' ) );

                    $myContentObjectAttribute->setContent( $tempMatrix );
                }
                else
                {
                    addError( "function 'addData': 'ezmatrix' - number of columns should be greater then zero", false );
                }

            } break;

            case 'ezboolean':
            {
                $myContentObjectAttribute->setAttribute( 'data_int', $value['DataInt'] );
            } break;

            case 'ezinteger':
            {
                $myContentObjectAttribute->setAttribute( 'data_int', $value['DataInt'] );
            } break;

            case 'ezfloat':
            {
                $power = 100;
                $float = mt_rand( $power * ( int ) $attributeParameters['min'], $power * ( int ) $attributeParameters['max'] );
                $float = $float / $power;
                $myContentObjectAttribute->setAttribute( 'data_float', $float );
            } break;

            case 'ezprice':
            {
                $power = 10;
                $price = mt_rand( $power * ( int ) $attributeParameters['min'], $power * ( int ) $attributeParameters['max'] );
                $price = $price / $power;
                $myContentObjectAttribute->setAttribute( 'data_float', $price );
            } break;

            case 'ezurl':
            {
                $myContentObjectAttribute->setContent( $value['Content'] );
                $myContentObjectAttribute->setAttribute( "data_text", $value['DataText']);
                //addError( array("setting ezurl values..." => array( $value['Content'], $value['DataText'] ) ), false);
            } break;

            case 'ezuser':
            {
                $user =& $attribute->content();
                if ( $user === null )
                {
                    $user = eZUser::create( $objectID );
                }

                $user->setInformation( $objectID,
                                       md5( mktime() . '-' . mt_rand() ),
                                       md5( mktime() . '-' . mt_rand() ) . '@ez.no',
                                       'publish',
                                       'publish' );
                $user->store();
            } break;
        }
        $myContentObjectAttribute->store();
    }

    $myContentObject->store();

    return true;
}

function setEZXMLAttribute( &$attribute, &$attributeValue, $link = false )
{
    include_once( 'kernel/classes/datatypes/ezxmltext/handlers/input/ezsimplifiedxmlinputparser.php' );
    $contentObjectID = $attribute->attribute( "contentobject_id" );
    $parser = new eZSimplifiedXMLInputParser( $contentObjectID, false, 0 );

    $attributeValue = str_replace( "\r", '', $attributeValue );
    $attributeValue = str_replace( "\n", '', $attributeValue );
    $attributeValue = str_replace( "\t", ' ', $attributeValue );

    $document = $parser->process( $attributeValue );
    /*
    if ( !is_object( $document ) )
    {
        $cli =& eZCLI::instance();
        $cli->output( 'Error in xml parsing' );
        return;
    }
    */
    $domString = eZXMLTextType::domString( $document );

    $attribute->setAttribute( 'data_text', $domString );
    $attribute->store();
}

?>