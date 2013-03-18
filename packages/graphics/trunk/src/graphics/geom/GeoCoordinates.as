﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2013
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package graphics.geom 
{
    import graphics.Geometry;
    import core.reflect.getClassName;
    import core.reflect.getClassPath;
    
    /**
     * The geographic coordinates of a place or event, based on the standard ontology defines by <a href="http://schema.org/GeoCoordinates">http://schema.org/GeoCoordinates</a>.
     */
    public class GeoCoordinates implements Geometry
    {
        /**
         * Creates a new GeoCoordinates instance.
         * @param latitude The latitude of a location. For example 37.42242.
         * @param longitude The longitude of a location. For example -122.08585.
         * @param elevation The elevation of a location.
         */
        public function GeoCoordinates( latitude:Number = 0 , longitude:Number = 0 , elevation:Number = 0 )
        {
            this.elevation = elevation ;
            this.latitude  = latitude  ;
            this.longitude = longitude ;
        }
        
        /**
         * The elevation of a location.
         */
        public var elevation:Number ;
        
        /**
         * The latitude of a location. For example 37.42242.
         */
        public var latitude:Number ;
        
        /**
         * The longitude of a location. For example -122.08585.
         */
        public var longitude:Number ;
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new GeoCoordinates(latitude, longitude, elevation) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o is GeoCoordinates )
            {
                return (o as GeoCoordinates).latitude  == latitude
                    && (o as GeoCoordinates).longitude == longitude 
                    && (o as GeoCoordinates).elevation == elevation ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            return { latitude:latitude , longitude:longitude , elevation:elevation } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new " + getClassPath(this, true) + "(" + latitude.toString() + "," + longitude.toString() + "," + elevation.toString() + ")" ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @param verbose Indicates if the string expression display the elevation value.
         * @return the string representation of this instance.
         */
        public function toString( verbose:Boolean = false ):String 
        {
            return "[" + getClassName(this) + " latitude:" + latitude + " longitude:" + longitude + ( verbose ? " elevation:" + elevation : "" ) + "]" ;
        }
    }
}
