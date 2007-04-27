<?php
//
// Created on: <13-Nov-2006 15:00:00 dl>
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ publish
// SOFTWARE RELEASE: 3.9.x
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
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//

include_once( 'kernel/classes/ezcontentobjectattribute.php' );

define( 'EZWEBIN_INSTALLER_ERR_OK', 0 );
define( 'EZWEBIN_INSTALLER_ERR_ABORT', 1 );
define( 'EZWEBIN_INSTALLER_ERR_CONTINUE', 2);

class eZWebinInstaller
{
    function eZWebinInstaller( $parameters = false )
    {
        $this->initSettings();
        $this->initSteps();

        if ( isset( $parameters['package_object'] ) )
            $this->addSetting( 'package_object', $parameters['package_object'] );

        $this->LastErrorCode = EZWEBIN_INSTALLER_ERR_OK;
    }

    function initSettings()
    {
        $classIdentifier = 'template_look';
        //get the class
        $class = eZContentClass::fetchByIdentifier( $classIdentifier, true, EZ_CLASS_VERSION_STATUS_TEMPORARY );
        if ( !$class )
        {
            $class = eZContentClass::fetchByIdentifier( $classIdentifier, true, EZ_CLASS_VERSION_STATUS_DEFINED );
            if ( !$class )
            {
                eZDebug::writeError( "Warning, DEFINED version for class identifier $classIdentifier does not exist." );
                return;
            }
        }

        $classId = $class->attribute( 'id' );
        $this->Settings['template_look_class_id'] = $classId;

        $objects = eZContentObject::fetchSameClassList( $classId );
        if ( !count( $objects ) )
        {
            eZDebug::writeError( "Object of class $classIdentifier does not exist." );
            return;
        }

        $templateLookObject = $objects[0];
        $this->Settings['template_look_object_id'] = $templateLookObject->attribute( 'id' );
    }

    function initSteps()
    {
        $postInstallSteps = array( array( '_function' => 'dbBegin',
                                          '_params' => array() ),
                                   array( '_function' => 'removeClassAttribute',
                                          '_params' => array( 'class_id' => $this->setting( 'template_look_class_id' ),
                                                              'attribute_identifier' => 'id' ) ),
                                   array( '_function' => 'updateObjectAttributeFromString',
                                          '_params' => array( 'object_id' => $this->setting( 'template_look_object_id' ),
                                                              'class_attribute_identifier' => 'image',
                                                              'string' => array( '_function' => 'packageFileItemPath',
                                                                                 '_params' => array( 'collection' => 'default',
                                                                                                     'file_item' => array( 'type' => 'image',
                                                                                                                           'name' => 'logo.png' ) ) ) ) ),
                                   array( '_function' => 'createContentSection',
                                          '_params' => array( 'name' => 'Restricted',
                                                              'navigation_part_identifier' => 'ezcontentnavigationpart' ) ),
                                   array( '_function' => 'addPoliciesForRole',
                                          '_params' => array( 'role_name' => 'Anonymous',
                                                              'policies' => array( array( 'module' => 'content',
                                                                                          'function' => 'read',
                                                                                          'limitation' => array( 'Class' =>   array( array( '_function' => 'classIDbyIdentifier',
                                                                                                                                            '_params' => array( 'class_identifier' => 'image' ) ),
                                                                                                                                     array( '_function' => 'classIDbyIdentifier',
                                                                                                                                            '_params' => array( 'class_identifier' => 'banner' ) ),
                                                                                                                                     array( '_function' => 'classIDbyIdentifier',
                                                                                                                                            '_params' => array( 'class_identifier' => 'flash' ) ),
                                                                                                                                     array( '_function' => 'classIDbyIdentifier',
                                                                                                                                            '_params' => array( 'class_identifier' => 'real_video' ) ),
                                                                                                                                     array( '_function' => 'classIDbyIdentifier',
                                                                                                                                            '_params' => array( 'class_identifier' => 'windows_media' ) ),
                                                                                                                                     array( '_function' => 'classIDbyIdentifier',
                                                                                                                                            '_params' => array( 'class_identifier' => 'quicktime' ) ) ),
                                                                                                                 'Section' => array( '_function' => 'sectionIDbyName',
                                                                                                                                     '_params' => array( 'section_name' => 'Media' ) ) ) ) ) ) ),
                                   array( '_function' => 'removePoliciesForRole',
                                          '_params' => array( 'role_name' => 'Editor',
                                                              'policies' => array( array( 'module' => 'content',
                                                                                          'function' => '*' ) ) ) ),
                                   array( '_function' => 'addPoliciesForRole',
                                          '_params' => array( 'role_name' => 'Editor',
                                                              'policies' => array( array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'folder' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'link' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'file' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'product' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'feedback_form' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'frontpage' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'article' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'article_mainpage' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'article_subpage' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'blog' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'poll' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'multicalendar' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'documentation_page' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'infobox' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'flash' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'quicktime' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'windows_media' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'real_video' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'gallery' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'forum' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'forums' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'event_calendar' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'banner' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'image' ) ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                         '_params' => array( 'class_identifier' => 'folder' ) ) ) ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                   '_params' => array( 'class_identifier' => 'blog_post' ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                         '_params' => array( 'class_identifier' => 'blog' ) ) ) ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                   '_params' => array( 'class_identifier' =>  'forum_topic' ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                         '_params' => array( 'class_identifier' => 'forum' ) ) ) ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                   '_params' => array( 'class_identifier' => 'event' ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                         '_params' => array( 'class_identifier' => 'event_calendar' ) ) ) ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                   '_params' => array( 'class_identifier' => 'image' ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                         '_params' => array( 'class_identifier' => 'gallery' ) ) ) ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'folder' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'link' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'feedback_form' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'frontpage' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'documentation_page' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'gallery' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'event_calendar' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'multicalendar' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'forums' ) ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                         '_params' => array( 'class_identifier' => 'frontpage' ) ) ) ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'edit' ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'read',
                                                                                          'limitation' => array( 'Section' => array( array( '_function' => 'sectionIDbyName',
                                                                                                                                            '_params' => array( 'section_name' => 'Standard' ) ),
                                                                                                                                     array( '_function' => 'sectionIDbyName',
                                                                                                                                            '_params' => array( 'section_name' => 'Restricted' ) ),
                                                                                                                                     array( '_function' => 'sectionIDbyName',
                                                                                                                                            '_params' => array( 'section_name' => 'Media' ) ) ) ) ) ) ) ),

                                   array( '_function' => 'addPoliciesForRole',
                                          '_params' => array( 'role_name' => 'Editor',
                                                              'policies' => array( array( 'module' => 'notification',
                                                                                          'function' => 'use' ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'manage_locations' ),
                                                                                   array( 'module' => 'ezodf',
                                                                                          'function' => '*' ),
                                                                                   array( 'module' => 'shop',
                                                                                          'function' => 'administrate' ) ) ) ),
                                   array( '_function' => 'createContentObject',
                                          '_params' => array( 'class_identifier' => 'user_group',
                                                              'location' => 'users',
                                                              'attributes' => array( 'name' => 'Partners',
                                                                                     'description' => '' ) ) ),
                                   array( '_function' => 'addPoliciesForRole',
                                          '_params' => array( 'role_name' => 'Partner',
                                                              'policies' => array( array( 'module' => 'content',
                                                                                          'function' => 'read',
                                                                                          'limitation' => array( 'Section' => array( '_function' => 'sectionIDbyName',
                                                                                                                                     '_params' => array( 'section_name' => 'Restricted' ) ) ) ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'forum_topic' ) ),
                                                                                                                 'Section' => array( '_function' => 'sectionIDbyName',
                                                                                                                                     '_params' => array( 'section_name' => 'Restricted' ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                                '_params' => array( 'class_identifier' => 'forum' ) ) ) ),

                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                   '_params' => array( 'class_identifier' => 'forum_reply' ) ),
                                                                                                                 'Section' => array( '_function' => 'sectionIDbyName',
                                                                                                                                     '_params' => array( 'section_name' => 'Restricted' ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                         '_params' => array( 'class_identifier' => 'forum_topic' ) ) ) ),

                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                   '_params' => array( 'class_identifier' => 'comment' ) ),
                                                                                                                 'Section' => array( '_function' => 'sectionIDbyName',
                                                                                                                                     '_params' => array( 'section_name' => 'Restricted' ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                         '_params' => array( 'class_identifier' => 'article'  ) ) ) ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'edit',
                                                                                          'limitation' => array( 'Class' => array( array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'comment' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'forum_topic' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'forum_reply' ) ) ),
                                                                                                                 'Section' => array( array( '_function' => 'sectionIDbyName',
                                                                                                                                            '_params' => array( 'section_name' => 'Restricted' ) ) ),
                                                                                                                 'Owner' => 1 ) ), // self
                                                                                   array( 'module' => 'user',
                                                                                          'function' => 'selfedit' ),
                                                                                   array( 'module' => 'notification',
                                                                                          'function' => 'use' ),
                                                                                   array( 'module' => 'shop',
                                                                                          'function' => 'administrate' ) ) ) ),
                                   array( '_function' => 'renameContentObject',
                                          '_params' => array( 'contentobject_id' => '11',// 11 is id of "Guest accounts"
                                                              'new_name' => 'Members',
                                                              ) ),
                                   array( '_function' => 'addPoliciesForRole',
                                          '_params' => array( 'role_name' => 'Member',
                                                              'policies' => array( array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'forum_topic' ) ),
                                                                                                                 'Section' => array( '_function' => 'sectionIDbyName',
                                                                                                                                     '_params' => array( 'section_name' => 'Standard' ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                                '_params' => array( 'class_identifier' => 'forum' ) ) ) ),

                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                   '_params' => array( 'class_identifier' => 'forum_reply' ) ),
                                                                                                                 'Section' => array( '_function' => 'sectionIDbyName',
                                                                                                                                     '_params' => array( 'section_name' => 'Standard' ) ),
                                                                                                                 'ParentClass' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                         '_params' => array( 'class_identifier' => 'forum_topic' ) ) ) ),
                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'create',
                                                                                          'limitation' => array( 'Class' => array( '_function' => 'classIDbyIdentifier',
                                                                                                                                   '_params' => array( 'class_identifier' => 'comment' ) ),
                                                                                                                 'Section' => array( '_function' => 'sectionIDbyName',
                                                                                                                                     '_params' => array( 'section_name' => 'Standard' ) ),
                                                                                                                 'ParentClass' => array( array( '_function' => 'classIDbyIdentifier',
                                                                                                                                                '_params' => array( 'class_identifier' => 'article' ) ),
                                                                                                                                         array( '_function' => 'classIDbyIdentifier',
                                                                                                                                                '_params' => array( 'class_identifier' => 'blog' ) ),
                                                                                                                                         array( '_function' => 'classIDbyIdentifier',
                                                                                                                                                '_params' => array( 'class_identifier' => 'article_mainpage' ) ) ) ) ),

                                                                                   array( 'module' => 'content',
                                                                                          'function' => 'edit',
                                                                                          'limitation' => array( 'Class' => array( array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'comment' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'forum_topic' ) ),
                                                                                                                                   array( '_function' => 'classIDbyIdentifier',
                                                                                                                                          '_params' => array( 'class_identifier' => 'forum_reply' ) ) ),
                                                                                                                 'Section' => array( array( '_function' => 'sectionIDbyName',
                                                                                                                                            '_params' => array( 'section_name' => 'Standard' ) ) ),
                                                                                                                 'Owner' => 1 ) ), // self


                                                                                   array( 'module' => 'user',
                                                                                          'function' => 'selfedit' ),
                                                                                   array( 'module' => 'notification',
                                                                                          'function' => 'use' ),
                                                                                   array( 'module' => 'shop',
                                                                                          'function' => 'buy' ),
                                                                                   array( 'module' => 'user',
                                                                                          'function' => 'password' )
                                                                                   )
                                                              ) ),
                                   array( '_function' => 'assignUserToRole',
                                          '_params' => array( 'location' => 'users/members',
                                                              'role_name' => 'Member' ) ),
                                   array( '_function' => 'assignUserToRole',
                                          '_params' => array( 'location' => 'users/partners',
                                                              'role_name' => 'Partner' ) ),
                                   array( '_function' => 'assignUserToRole',
                                          '_params' => array( 'location' => 'users/partners',
                                                              'role_name' => 'Member' ) ),
                                   array( '_function' => 'assignUserToRole',
                                          '_params' => array( 'location' => 'users/partners',
                                                              'role_name' => 'Anonymous' ) ),
                                   array( '_function' => 'assignUserToRole',
                                          '_params' => array( 'location' => 'users/editors',
                                                              'role_name' => 'Member' ) ),
                                   array( '_function' => 'addClassAttribute',
                                          '_params' => array( 'class_identifier' => 'user_group',
                                                              'attribute_identifier' => 'website_toolbar_access',
                                                              'attribute_name' => 'Website Toolbar access',
                                                              'datatype' => 'ezboolean',
                                                              'default_value' => 0 ) ),
                                   array( '_function' => 'updateObjectAttributeFromString',
                                          '_params' => array( 'location' => 'users/editors',
                                                              'class_attribute_identifier' => 'website_toolbar_access',
                                                              'string' => '1' ) ),
                                   array( '_function' => 'updateObjectAttributeFromString',
                                          '_params' => array( 'location' => 'users/administrator_users',
                                                              'class_attribute_identifier' => 'website_toolbar_access',
                                                              'string' => '1' ) ),
                                   array( '_function' => 'updateClassAttribute',
                                          '_params' => array( 'class_identifier' => 'folder',
                                                              'class_attribute_identifier' => 'short_description',
                                                              'name' => 'Summary' ) ),
                                   array( '_function' => 'updateClassAttribute',
                                          '_params' => array( 'class_identifier' => 'folder',
                                                              'class_attribute_identifier' => 'show_children',
                                                              'name' => 'Display sub items' ) ),
                                   array( '_function' => 'setRSSExport',
                                          '_params' => array( 'creator' => '14',
                                                              'access_url' => 'my_feed',
                                                              'main_node_only' => '1',
                                                              'number_of_objects' => '10',
                                                              'rss_version' => '2.0',
                                                              'status' => '1',
                                                              'title' => 'My RSS Feed',
                                                              'rss_export_itmes' => array( 0 => array( 'class_id' => '16',
                                                                                                       'description' => 'intro',
                                                                                                       'source_node_id' => '64',
                                                                                                       'status' => '1',
                                                                                                       'title' => 'title' ) ) ) ),
                                   array( '_function' => 'dbCommit',
                                          '_params' => array() ) );


        $this->Steps['post_install'] = $postInstallSteps;
    }

    function addSetting( $name, $value )
    {
        $this->Settings[$name] = $value;
    }

    function setting( $name )
    {
        $value = false;
        if ( $this->hasSetting( $name ) )
            $value = $this->Settings[$name];

        return $value;
    }

    function hasSetting( $name )
    {
        $hasSetting = false;
        if ( isset( $this->Settings[$name] ) )
            $hasSetting = true;

        return $hasSetting;
    }

    function postInstallSteps()
    {
        return $this->Steps['post_install'];
    }

    function postInstall()
    {
        $steps = $this->postInstallSteps();
        $stepNum = 1;
        foreach( $steps as $step )
        {
            $this->execFunction( $step );
            if ( $this->lastErrorCode() == EZWEBIN_INSTALLER_ERR_ABORT )
            {
                $this->reportError( "Abortin execution on step number $stepNum: '". $step['_function'] ."'", 'eZWebinInstaller::postInstall' );
                break;
            }

            ++$stepNum;
        }
    }

    function execFunction( $function )
    {
        $functionName = $function['_function'];

        $this->buildFunctionParams( $function['_params'] );

        $result = $this->$functionName( $function['_params'] );

        return $result;
    }

    function buildFunctionParams( &$params )
    {
        foreach ( array_keys( $params ) as $paramKey )
        {
            if ( $this->isFunctionParam( $params[$paramKey] ) )
            {
                $params[$paramKey] = $this->execFunction( $params[$paramKey] );
            }
            else if ( is_array( $params[$paramKey] ) )
            {
                $this->buildFunctionParams( $params[$paramKey] );
            }
        }
    }

    function isFunctionParam( $param )
    {
        $isFunction = false;
        if ( is_array( $param) && isset( $param['_function'] ) )
            $isFunction = true;

        return $isFunction;
    }

    function nodePathStringByURL( $params )
    {
        include_once( 'kernel/classes/ezcontentobjecttreenode.php' );

        $pathString = '';

        $node = $this->nodeByUrl( $params );

        if ( is_object( $node ) )
        {
            $pathString = $node->attribute( 'path_string' );
        }

        return $pathString;
    }

    function nodeByUrl( $params )
    {
        include_once( 'kernel/classes/ezcontentobjecttreenode.php' );

        $path_identification_string = $params['location'];

        $node = eZContentObjectTreeNode::fetchByURLPath( $path_identification_string );

        if ( !is_object( $node ) )
        {
            $this->reportError( "The node '$path_identification_string' doesn't exist", 'eZWebinInstaller::nodeByUrl' );
        }

        return $node;
    }

    function classIDbyIdentifier( $params )
    {
        $classID = false;

        $contentClass = eZWebinInstaller::classByIdentifier( $params );

        if ( is_object( $contentClass ) )
        {
            $classID = $contentClass->attribute( 'id' );
        }

        return $classID;
    }

    function classByIdentifier( $params )
    {
        include_once( 'kernel/classes/ezcontentclass.php' );

        $classIdentifier = $params['class_identifier'];

        $contentClass = eZContentClass::fetchByIdentifier( $classIdentifier );
        if ( !is_object( $contentClass ) )
        {
            eZDebug::writeWarning( "Content class with identifier '$classIdentifier' doesn't exist.", 'eZWebinInstaller::classByIdentifier' );
        }

        return $contentClass;
    }

    function sectionIDbyName( $params )
    {
        include_once( 'kernel/classes/ezsection.php' );

        $sectionID = false;
        $sectionName = $params['section_name'];

        $sectionList = eZSection::fetchFilteredList( array( 'name' => $sectionName ), false, false, true );

        if ( is_array( $sectionList ) && count( $sectionList ) > 0 )
        {
            $section = $sectionList[0];
            if ( is_object( $section ) )
            {
                $sectionID = $section->attribute( 'id' );
            }
        }

        return $sectionID;
    }

    function packageFileItemPath( $params )
    {
        $collection = $params['collection'];
        $fileItem = $params['file_item'];

        $filePath = $fileItem['name'];

        $package = $this->setting( 'package_object' );
        if ( is_object( $package ) )
        {
            $filePath = $package->fileItemPath( $fileItem, $collection );
        }
        else
        {
            eZDebug::writeWarning( "'Package' object is not set", 'eZWebinInstaller::packageFileItemPath' );
        }

        return $filePath;

    }

    function dbBegin( $params )
    {
        $db =& eZDB::instance();
        $db->begin();
    }

    function dbCommit( $params )
    {
        $db =& eZDB::instance();
        $db->commit();
    }

    function removeClassAttribute( $params )
    {
        include_once( 'kernel/classes/ezcontentclassattribute.php' );

        $contentClassID = $params['class_id'];
        $classAttributeIdentifier = $params['attribute_identifier'];

        // get attributes of 'temporary' version as well
        $classAttributeList =& eZContentClassAttribute::fetchFilteredList( array( 'contentclass_id' => $contentClassID,
                                                                                  'identifier' => $classAttributeIdentifier ),
                                                                           true );

        $validation = array();
        foreach( $classAttributeList as $classAttribute )
        {
            $dataType = $classAttribute->dataType();
            if ( $dataType->isClassAttributeRemovable( $classAttribute ) )
            {
                $objectAttributes = eZContentObjectAttribute::fetchSameClassAttributeIDList( $classAttribute->attribute( 'id' ) );
                foreach ( $objectAttributes as $objectAttribute )
                {
                    $objectAttributeID = $objectAttribute->attribute( 'id' );
                    $objectAttribute->remove( $objectAttributeID );
                }

                $classAttribute->remove();
            }
            else
            {
                $removeInfo = $dataType->classAttributeRemovableInformation( $classAttribute );
                if ( $removeInfo === false )
                    $removeInfo = "Unknow reason";

                $validation[] = array( 'id' => $classAttribute->attribute( 'id' ),
                                       'identifier' => $classAttribute->attribute( 'identifier' ),
                                       'reason' => $removeInfo );
            }
        }

        if ( count( $validation ) > 0 )
        {
            $this->reportError( $validation, 'eZWebinInstaller::removeClassAttribute: Unable to remove eZClassAttribute(s)' );
        }

    }

    function addClassAttribute( $params )
    {
        include_once( 'kernel/classes/ezcontentclassattribute.php' );

        $classIdentifier = $params['class_identifier'];
        $classAttributeIdentifier = $params['attribute_identifier'];
        $classAttributeName = $params['attribute_name'];
        $datatype = $params['datatype'];
        $defaultValue = isset( $params['default_value'] ) ? $params['default_value'] : false;

        $classID = eZWebinInstaller::classIDbyIdentifier( $params );
        if ( $classID )
        {
            $newAttribute = eZContentClassAttribute::create( $classID, $datatype, array( 'identifier' => $classAttributeIdentifier,
                                                                                         'name' => $classAttributeName )  );

            $dataType = $newAttribute->dataType();
            $dataType->initializeClassAttribute( $newAttribute );

            // not all datatype can have 'default_value'. do check here.
            if ( $defaultValue !== false  )
            {
                switch ( $datatype )
                {
                    case 'ezboolean':
                    {
                        $newAttribute->setAttribute( 'data_int3', $defaultValue );
                    }
                    break;

                    default:
                        break;
                }
            }

            // store attribute, update placement, etc...
            $class = eZWebinInstaller::classByIdentifier( $params );
            $attributes =& $class->fetchAttributes();
            $attributes[] =& $newAttribute;

            $newAttribute->setAttribute( 'version', EZ_CLASS_VERSION_STATUS_DEFINED );
            $newAttribute->setAttribute( 'placement', count( $attributes ) );

            $class->adjustAttributePlacements( $attributes );
            foreach( array_keys( $attributes ) as $attributeKey )
            {
                $attribute =& $attributes[$attributeKey];
                $attribute->storeDefined();
            }

            // update objects
            $classAttributeID = $newAttribute->attribute( 'id' );
            $objects = eZContentObject::fetchSameClassList( $classID );
            foreach( $objects as $object )
            {
                $contentobjectID = $object->attribute( 'id' );
                $objectVersions =& $object->versions();
                foreach ( $objectVersions as $objectVersion )
                {
                    $translations = $objectVersion->translations( false );
                    $version = $objectVersion->attribute( 'version' );
                    foreach ( $translations as $translation )
                    {
                        $objectAttribute = eZContentObjectAttribute::create( $classAttributeID, $contentobjectID, $version );
                        $objectAttribute->setAttribute( 'language_code', $translation );
                        $objectAttribute->initialize();
                        $objectAttribute->store();
                        $objectAttribute->postInitialize();
                    }
                }
            }
        }
    }

    function updateClassAttribute( $params )
    {
        include_once( 'kernel/classes/ezcontentclassattribute.php' );

        $classIdentifier = $params['class_identifier'];
        $attributeIdentifier = $params['class_attribute_identifier'];
        $name = isset( $params['name'] ) ? $params['name'] : false;

        $contentClassID = eZWebinInstaller::classIDbyIdentifier( $params );
        if ( $contentClassID )
        {
            $classAttributeList =& eZContentClassAttribute::fetchFilteredList( array( 'contentclass_id' => $contentClassID,
                                                                                      'identifier' => $attributeIdentifier ),
                                                                               true );

            foreach( $classAttributeList as $attribute )
            {
                if ( $name !== false )
                {
                    $attribute->setName( $name );
                }

                $attribute->store();
            }
        }
    }

    function updateObjectAttributeFromString( $params )
    {
        $objectID = isset( $params['object_id'] ) ? $params['object_id'] : false;
        $location = isset( $params['location'] ) ? $params['location'] : false;
        $classAttrIdentifier = $params['class_attribute_identifier'];
        $stringParam = $params['string'];

        $contentObject = false;
        if ( $objectID )
        {
            $contentObject =& eZContentObject::fetch( $objectID );
            if ( !is_object( $contentObject ) )
            {
                $this->reportError( "Content object with id '$objectID' doesn't exist." , 'eZWebinInstaller::updateObjectAttributeFromString' );
            }
        }
        else if ( $location )
        {
            $contentObject = $this->contentObjectByUrl( array( 'location' => $location ) );
        }

        if ( is_object( $contentObject ) )
        {
            $attributes =& $contentObject->contentObjectAttributes();
            if ( count( $attributes ) > 0 )
            {
                $objectAttribute = false;
                foreach ( array_keys( $attributes ) as $attributeKey )
                {
                    if ( $attributes[$attributeKey]->attribute( 'contentclass_attribute_identifier' ) == $classAttrIdentifier )
                    {
                        $objectAttribute = $attributes[$attributeKey];
                        break;
                    }
                }

                if ( is_object( $objectAttribute ) )
                {
                    $objectAttribute->fromString( $stringParam );
                    $objectAttribute->store();
                }
                else
                {
                    $this->reportError( "Content object with id '$objectID' doesn't have attribute with contentClassAttribute identifier '$classAttrIdentifier'." , 'eZWebinInstaller::updateObjectAttributeFromString' );
                }
            }
            else
            {
                $this->reportError( "Content object with id '$objectID' doesn't have attributes." , 'eZWebinInstaller::updateObjectAttributeFromString' );
            }
        }
    }

    function contentObjectByUrl( $params )
    {
        $object = false;

        $node = $this->nodeByUrl( $params );
        if ( is_object( $node ) )
        {
            $object =& $node->object();
        }

        return $object;
    }

    function addPoliciesForRole( $params )
    {
        include_once( 'kernel/classes/ezrole.php' );

        $roleName = $params['role_name'];
        $policiesDefinition = $params['policies'];
        $createRoleIfNotExists = isset( $params['create_role'] ) ? $params['create_role'] : true;

        $role = eZRole::fetchByName( $roleName );
        if ( is_object( $role ) || $createRoleIfNotExists )
        {
            if ( !is_object( $role ) )
            {
                $role = eZRole::create( $roleName );
                $role->store();
            }

            $roleID = $role->attribute( 'id' );
            if ( count( $policiesDefinition ) > 0 )
            {
                foreach ( $policiesDefinition as $policyDefinition )
                {
                    if ( isset( $policyDefinition['limitation'] ) )
                    {
                        $role->appendPolicy( $policyDefinition['module'], $policyDefinition['function'], $policyDefinition['limitation'] );
                    }
                    else
                    {
                        $role->appendPolicy( $policyDefinition['module'], $policyDefinition['function'] );
                    }
                }
            }
        }
        else
        {
            $this->reportError( "Role '$roleName' doesn't exist." , 'eZWebinInstaller::addPoliciesToRole' );
        }
    }

    function removePoliciesForRole( $params )
    {
        include_once( 'kernel/classes/ezrole.php' );

        $roleName = $params['role_name'];
        $policiesDefinition = $params['policies'];
        $removeRoleIfEmpty = isset( $params['remove_role'] ) ? $params['remove_role'] : true;

        $role = eZRole::fetchByName( $roleName );
        if ( is_object( $role ) )
        {
            foreach( $policiesDefinition as $policyDefinition )
            {
                $role->removePolicy( $policyDefinition['module'], $policyDefinition['function'] );
            }

            if ( $removeRoleIfEmpty && count( $role->policyList() ) == 0 )
            {
                $role->remove();
            }
        }
        else
        {
            $this->reportError( "Role '$roleName' doesn't exist." , 'eZWebinInstaller::removePoliciesForRole' );
        }
    }

    function createContentSection( $params )
    {
        include_once( 'kernel/classes/ezsection.php' );

        $section = false;

        $sectionName = $params['name'];
        $navigationPart = $params['navigation_part_identifier'];

        $section = new eZSection( array() );
        $section->setAttribute( 'name', $sectionName );
        $section->setAttribute( 'navigation_part_identifier', $navigationPart );
        $section->store();

        return $section;
    }

    function createContentObject( $params )
    {
        include_once( 'kernel/classes/ezcontentfunctions.php' );

        $objectID = false;

        $classIdentifier = $params['class_identifier'];
        $location = $params['location'];
        $attributesData = $params['attributes'];

        $parentNode = $this->nodeByUrl( $params );
        if ( is_object( $parentNode ) )
        {
            $parentNodeID = $parentNode->attribute( 'node_id' );
            $object = eZContentFunctions::createAndPublishObject( array( 'parent_node_id' => $parentNodeID,
                                                                         'class_identifier' => $classIdentifier,
                                                                         'attributes' => $attributesData ) );

            if ( is_object( $object ) )
            {
                $objectID = $object->attribute( 'id' );
            }
        }

        return $objectID;
    }

    function setSection( $params )
    {
        $location = $params['location'];
        $sectionName = $params['section_name'];

        $sectionID = $this->sectionIDbyName( $params );
        if ( $sectionID )
        {
            $rootNode = $this->nodeByUrl( $params );
            if ( is_object( $rootNode ) )
            {
                eZContentObjectTreeNode::assignSectionToSubTree( $rootNode->attribute( 'node_id' ), $sectionID );
            }
        }

    }

    function assignUserToRole( $params )
    {
        include_once( 'kernel/classes/ezrole.php' );

        $location = $params['location'];
        $roleName = $params['role_name'];

        $node = $this->nodeByUrl( $params );
        if ( is_object( $node ) )
        {
            $role = eZRole::fetchByName( $roleName );
            if ( is_object( $role ) )
            {
                $userObject = $node->attribute( 'object' );
                if ( is_object( $userObject ) )
                {
                    $role->assignToUser( $userObject->attribute( 'id' ) );
                }
            }
        }
    }

    function setLastErrorCode( $errCode )
    {
        $this->LastErrorCode = $errCode;
    }

    function setRSSExport( $params )
    {
        include_once( 'kernel/classes/ezrssexport.php' );
        include_once( 'kernel/classes/ezrssexportitem.php' );
        include_once( 'kernel/common/i18n.php' );

        // Create default rssExport object to use
        $rssExport = eZRSSExport::create( $params['creator'] );
        $rssExport->setAttribute( 'access_url', $params['access_url'] );
        $rssExport->setAttribute( 'main_node_only', $params['main_node_only'] );
        $rssExport->setAttribute( 'number_of_objects', $params['number_of_objects'] );
        $rssExport->setAttribute( 'rss_version', $params['rss_version'] );
        $rssExport->setAttribute( 'status', $params['status'] );
        $rssExport->setAttribute( 'title', $params['title'] );
        $rssExport->store();

        $rssExportID = $rssExport->attribute( 'id' );

        foreach ( $params['rss_export_itmes'] as $item )
        {
            // Create One empty export item
            $rssExportItem = eZRSSExportItem::create( $rssExportID );
            $rssExportItem->setAttribute( 'class_id', $item['class_id'] );
            $rssExportItem->setAttribute( 'description', $item['description'] );
            $rssExportItem->setAttribute( 'source_node_id', $item['source_node_id'] );
            $rssExportItem->setAttribute( 'status', $item['status'] );
            $rssExportItem->setAttribute( 'title', $item['title'] );
            $rssExportItem->store();
        }
    }

    function lastErrorCode()
    {
        return $this->LastErrorCode;
    }

    function reportError( $text, $caption, $errCode = EZWEBIN_INSTALLER_ERR_ABORT )
    {
        eZDebug::writeDebug( $text, $caption );

        $this->setLastErrorCode( $errCode );
    }

    function renameContentObject( $params )
    {
        include_once( 'kernel/classes/ezcontentobject.php' );
        $contentObjectID = $params['contentobject_id'];
        $newName = $params['new_name'];
        $object = eZContentObject::fetch( $contentObjectID );
        if ( !is_object( $object ) )
            return false;
        $object->rename( $newName );
    }

    var $Settings;
    var $Steps;
    var $LastErrorCode;

}

?>
