<?php
//
// Definition of ClassTools class
//
// Created on: <19-July-2006 11:08:39 jkn>
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

/*! \file classtools.php
*/

/*!
  \class ClassTools classtools.php
  \brief The class ClassTools contains template operators that returns
   information about classes.

*/

class ClassTools
{
	var $Operators;
	
	function classTools()
	{
		$this->Operators = array( "getclassid" );
	}

	function &operatorList()
	{
		return $this->Operators;
	}
	
	function namedParameterPerOperator()
	{
		return true;
	}
	
	function namedparameterList()
	{

		return array( 'getclassid' => array(
											'class_identifier' => array(
																'type' => 'string',
                                                                'required' => true,
	                                                            'default' => '' ) ) );
	}
	
	function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
	{
		switch( $operatorName )
		{
			case "getclassid":
			{
				$operatorValue = $this->getClassID( $namedParameters["class_identifier"] );
				break;
			}
		}//end switch
	}
	
	
    function getClassID( $classNameParam )
    {
	        //initiating vars
            $returnVar = false;

            //fetching class info on class garticle
            $classInfo = eZContentClass::fetchByIdentifier( $classNameParam );

            //fetching $classID based on $classInfo
            if ( is_object( $classInfo ) )
            {
                if ( array_key_exists( "ID", $classInfo ) )
                {
                    $returnVar = $classInfo->ID;
                }
                else
                    eZDebug::writeWarning( '$classInfo does not contain ID key.' , $this->thisFile);
            }
            else
                eZDebug::writeWarning( "eZContentClass::fetchByIdentifier(".$classNameParam.") did not return an object" , $this->thisFile);
		return $returnVar;
    }//end method getClassID

}//end class
?>