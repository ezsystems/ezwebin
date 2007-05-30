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


/*
    purpose: swap node locations
    returns: always true
    parameters: nodenames of the nodes to swap locations
    note: this method must be used with care it attempted used on User objects.
*/
function swapNodes( $nodeName1, $nodeName2 )
{
    //init vars
    $node1 = getNodeIdByName( $nodeName1 );
    $node2 = getNodeIdByName( $nodeName2 );

    addError( array('nodeName1'=>$nodeName1),false);
    addError( array('nodeName2'=>$nodeName2),false);

    addError( array('node1'=>$node1),false);
    addError( array('node2'=>$node2),false);

    //$nodeID = $module->actionParameter( 'NodeID' );
    $nodeID = $node1;
    $node = eZContentObjectTreeNode::fetch( $nodeID );

    if ( !$node )
        addError( "ingen node object motatt!",true);

    if ( !$node->canSwap() )
    {
        addError( "Cannot swap node $nodeID (no edit permission)",true);
    }

    $nodeParentNodeID = & $node->attribute( 'parent_node_id' );

    $object =& $node->object();
    if ( !$object )
        addError( "ingen object mottat!",true);

    $objectID = $object->attribute( 'id' );
    $objectVersion = $object->attribute( 'current_version' );
    $class =& $object->contentClass();
    $classID = $class->attribute( 'id' );

    //$selectedNodeID = $module->actionParameter( 'NewNode' );
    $selectedNodeID = $node2;

    $selectedNode = eZContentObjectTreeNode::fetch( $selectedNodeID );

    if ( !$selectedNode )
    {
        addError( "Content node with ID $selectedNodeID does not exist, cannot use that as exchanging node for node $nodeID",true);
    }

    if ( !$selectedNode->canSwap() )
    {
        addError( "Cannot use node $selectedNodeID as the exchanging node for $nodeID, the current user does not have edit permission for it",true);
    }

    // clear cache.
    include_once( 'kernel/classes/ezcontentcachemanager.php' );
    eZContentCacheManager::clearContentCacheIfNeeded( $objectID );

    $selectedObject =& $selectedNode->object();
    $selectedObjectID =& $selectedObject->attribute( 'id' );
    $selectedObjectVersion =& $selectedObject->attribute( 'current_version' );
    $selectedNodeParentNodeID=& $selectedNode->attribute( 'parent_node_id' );


    /* In order to swap node1 and node2 a user should have the following permissions:
     * 1. move_from: move node1
     * 2. move_from: move node2
     * 3. move_to: move an object of the same class as node2 under parent of node1
     * 4. move_to: move an object of the same class as node1 under parent of node2
     *
     * The First two has already been checked. Let's check the rest.
     */
    $nodeParent            =& $node->attribute( 'parent' );
    $selectedNodeParent    =& $selectedNode->attribute( 'parent' );
    $objectClassID         =& $object->attribute( 'contentclass_id' );
    $selectedObjectClassID =& $selectedObject->attribute( 'contentclass_id' );

    if ( !$nodeParent || !$selectedNodeParent )
        addError( "No $nodeParent or no !$selectedNodeParent received.",true);

    if ( !$nodeParent->canMoveTo( $selectedObjectClassID ) )
    {
        addError( "Cannot move an object of class $selectedObjectClassID to node $nodeParentNodeID (no create permission)",true);
    }

    if ( !$selectedNodeParent->canMoveTo( $objectClassID ) )
    {
        addError( "Cannot move an object of class $objectClassID to node $selectedNodeParentNodeID (no create permission)",true);
    }

    // exchange contentobject ids and versions.
    $node->setAttribute( 'contentobject_id', $selectedObjectID );
    $node->setAttribute( 'contentobject_version', $selectedObjectVersion );

    $db = eZDB::instance();
    $db->begin();
    $node->store();
    $selectedNode->setAttribute( 'contentobject_id', $objectID );
    $selectedNode->setAttribute( 'contentobject_version', $objectVersion );
    $selectedNode->store();

    // modify path string
    $changedOriginalNode = eZContentObjectTreeNode::fetch( $nodeID );
    $changedOriginalNode->updateSubTreePath();
    $changedTargetNode = eZContentObjectTreeNode::fetch( $selectedNodeID );
    $changedTargetNode->updateSubTreePath();

    // modify section
    if ( $changedOriginalNode->attribute( 'main_node_id' ) == $changedOriginalNode->attribute( 'node_id' ) )
    {
        $changedOriginalObject =& $changedOriginalNode->object();
        $parentObject =& $nodeParent->object();
        if ( $changedOriginalObject->attribute( 'section_id' ) != $parentObject->attribute( 'section_id' ) )
        {

            eZContentObjectTreeNode::assignSectionToSubTree( $changedOriginalNode->attribute( 'main_node_id' ),
                                                             $parentObject->attribute( 'section_id' ),
                                                             $changedOriginalObject->attribute( 'section_id' ) );
        }
    }
    if ( $changedTargetNode->attribute( 'main_node_id' ) == $changedTargetNode->attribute( 'node_id' ) )
    {
        $changedTargetObject =& $changedTargetNode->object();
        $selectedParentObject =& $selectedNodeParent->object();
        if ( $changedTargetObject->attribute( 'section_id' ) != $selectedParentObject->attribute( 'section_id' ) )
        {

            eZContentObjectTreeNode::assignSectionToSubTree( $changedTargetNode->attribute( 'main_node_id' ),
                                                             $selectedParentObject->attribute( 'section_id' ),
                                                             $changedTargetObject->attribute( 'section_id' ) );
        }
    }

    $db->commit();

    // clear cache for new placement.
    eZContentCacheManager::clearContentCacheIfNeeded( $objectID );

    return true;
}

/*
    returns nodeId
    parameter: $nodeNameParam = name of node
    option: $contentClassIdParam = use if you know what class the nodeobject is based on
*/
function getNodeIdByName( $nodeNameParam, $contentClassIdParam = false )
{
    //TODO: this code was copied from another function, and may need some rewrite to make sense to a developer
    //init vars
    $returnVar = false;

    //build up the conditions
    $conditions = array( 'name' => $nodeNameParam );

    if ( $contentClassIdParam )
        array_merge( $conditions, array( 'contentclass_id' => $contentClassIdParam ) );

    addError( array("conditions"=>$conditions), false);
    //fetch the treenode to move
    $moveTheseContentObjects = eZContentObject::fetchList( true, $conditions, 0, 1 );
    addError( array("movethesecontentobjects"=>$moveTheseContentObjects), false);
    $returnVar = $moveTheseContentObjects[0]->mainNodeID();

    return $returnVar;
}


/*
    returns nothing. removes contentobject.
    parameter: $contentObjectNameParam = name of contentobject to remove
    option: $contentClassIdParam = use if you know what class the nodeobject is based on
*/
function doRemoveContentObject( $contentObjectNameParam, $contentClassId = false )
{
    $contentObjectNodeId = getNodeIdByName( $contentObjectNameParam, $contentClassId );
    $contentObject =& eZContentObject::fetchByNodeID( $contentObjectNodeId );
    $contentObject->purge();

    return true;
}


function moveTreeNode( $treeNodeNameParam, $parentNodeNameParam )
{
    //fetch the treenode to move
    $conditions = array('contentclass_id' => 1, 'name' => $treeNodeNameParam );
    $moveTheseContentObjects = eZContentObject::fetchList( true, $conditions, 0, 1 );
    $moveThisContentObjectMainNodeId = $moveTheseContentObjects[0]->mainNodeID();

    //fetch the treenode to move to
    $conditions = array('contentclass_id' => 1, 'name' => $parentNodeNameParam );
    $moveToHereContentObjects = eZContentObject::fetchList( true, $conditions, 0, 1 );
    $moveToHereContentObjectMainNodeId = $moveToHereContentObjects[0]->mainNodeID();

    $result = eZContentObjectTreeNodeOperations::move( $moveThisContentObjectMainNodeId, $moveToHereContentObjectMainNodeId );
    return $result;
}


?>
