﻿/*  Version: MPL 1.1/GPL 2.0/LGPL 2.1   The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at  http://www.mozilla.org/MPL/    Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the  License.    The Original Code is [maashaack framework].    The Initial Developers of the Original Code are  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.  Portions created by the Initial Developers are Copyright (C) 2006-2013  the Initial Developers. All Rights Reserved.    Contributor(s):    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.*/package graphics {    import core.reflect.getClassPath;        /**     * The four cardinal directions or cardinal points are the directions of north, south, east, and west, commonly denoted by their initials: N, S, E, W.      * They are mostly used for geographic orientation on Earth but may be calculated anywhere on a rotating astronomical body.     */    public class CardinalDirection    {        /**         * Creates a new CardinalDirection instance.         * @param value The value of the enumeration.         * @param name The name key of the enumeration.         */        public function CardinalDirection( value:Number = 0 , name:String = "" , azimut:Number = 0 )        {            _value  = value ;            _name   = name  ;            _azimut = azimut ;        }                /**         * Indicates the angular measurement in a spherical coordinate system (in degrees).         */        public function azimut():Number        {            return _azimut ;         }                /**         * Returns the source code String representation of the object.         * @return the source code String representation of the object.         */        public function toSource( indent:int = 0 ):String        {            var classname:String = getClassPath( this , true );            if( _name != "" )            {                return classname + "." + _name ;            }            return classname;        }                /**         * Returns the String representation of the object.         * @return the String representation of the object.         */        public function toString():String        {            return _name;        }                /**         * Returns the primitive value of the object.         * @return the primitive value of the object.         */        public function valueOf():Number        {            return _value;        }                /**         * @private         */        protected var _azimut:Number ;                /**         * @private         */        protected var _name:String ;                /**         * @private         */        protected var _value:Number ;                // enumerations                /**         * The East cardinal point "E" : Azimut:90° Radians:π/2         */        public static const E:CardinalDirection = new CardinalDirection( Math.PI / 2 , "E" , 90 ) ;                /**         * The East-North-East cardinal point "ENE" : Azimut:67.5° Radians:3π/8         */        public static const ENE:CardinalDirection = new CardinalDirection( 3 * Math.PI / 8 , "ENE" , 67.5 ) ;                /**         * The East-South-East cardinal point "ESE" : Azimut:112,5° Radians:5π/8         */        public static const ESE:CardinalDirection = new CardinalDirection( 5 * Math.PI / 8 , "ESE" , 112.5 ) ;                /**         * The North cardinal point "N" : Azimut:0° Radians:0         */        public static const N:CardinalDirection = new CardinalDirection( 0 , "N" , 0) ;                /**         * The North-East cardinal point "NE" : Azimut:45° Radians:π/4         */        public static const NE:CardinalDirection = new CardinalDirection( Math.PI / 4 , "NE" , 45 ) ;                /**         * The North-North-East cardinal point "NNE" : Azimut:22.5° Radians:π/8         */        public static const NNE:CardinalDirection = new CardinalDirection( Math.PI / 8 , "NNE" , 22.5 ) ;                /**         * The North-North-West cardinal point "NNW" : Azimut:337.5° Radians:15π/8         */        public static const NNW:CardinalDirection = new CardinalDirection( 15 * Math.PI / 8 , "NNW" , 337.5 ) ;                /**         * The North-West cardinal point "NW" : Azimut:315° Radians:7π/4         */        public static const NW:CardinalDirection = new CardinalDirection( 7 * Math.PI / 4 , "NW" , 315 ) ;                /**         * The South cardinal point "S" : Azimut:180° Radians:π         */        public static const S:CardinalDirection = new CardinalDirection( Math.PI , "S" , 180 ) ;                /**         * The South-East cardinal point "SE" : Azimut:135° Radians:3π/4         */        public static const SE:CardinalDirection = new CardinalDirection( 3 * Math.PI / 4 , "SE" , 135 ) ;                /**         * The South-South-East cardinal point "SSE" : Azimut:157.5° Radians:7π/8         */        public static const SSE:CardinalDirection = new CardinalDirection( 7 * Math.PI / 8 , "SSE" , 157.5 ) ;                /**         * The South-South-West cardinal point "SSW" : Azimut:202.5° Radians:9π/8         */        public static const SSW:CardinalDirection = new CardinalDirection( 9 * Math.PI / 8 , "SSW" , 202.5 ) ;                /**         * The South-West cardinal point "SW" : Azimut:225° Radians:5π/4         */        public static const SW:CardinalDirection = new CardinalDirection( 5 * Math.PI / 4 , "SW" , 225 ) ;                /**         * The West cardinal point "W" : Azimut:270° Radians:3π/2         */        public static const W:CardinalDirection = new CardinalDirection( 3 * Math.PI / 2 , "W" , 270 ) ;                /**         * The West-North-West cardinal point "WNW" : Azimut:292.5° Radians:13π/8         */        public static const WNW:CardinalDirection = new CardinalDirection( 13 * Math.PI / 8 , "WNW" , 292.5 ) ;                /**         * The West-South-West cardinal point "WSW" : Azimut:247.5° Radians:11π/8         */        public static const WSW:CardinalDirection = new CardinalDirection( 11 * Math.PI / 8 , "WSW" , 247.5 ) ;                /**         * The set of all diagonal directions (northeast, southeast, southwest, northwest).         */        public static const ALL:Array = [N,E,S,W,NE,SE,NW,SW,NNE,NNW,SSE,SSW,ENE,ESE,WNW,WSW] ;                /**         * The set of all diagonal directions (northeast, southeast, southwest, northwest).         */        public static const DIAGONALS:Array = [NE,SE,NW,SW] ;                /**         * The set of all orthogonals directions (north, south, south, north).         */        public static const ORTHOGONALS:Array = [N,E,S,W] ;                /**         * Returns true if this is a diagonal direction (northeast, southeast, southwest, northwest).         * @return true if this is a diagonal direction.         */        public static function isDiagonal( direction:CardinalDirection ):Boolean        {            return DIAGONALS.indexOf( direction ) > -1 ;        }                /**         * Returns true if this is an orthogonal direction (north, east, south, west).         * @return true if this is an orthogonal direction.         */        public static function isOrthogonal( direction:CardinalDirection ):Boolean        {            return ORTHOGONALS.indexOf( direction ) > -1 ;        }    }}