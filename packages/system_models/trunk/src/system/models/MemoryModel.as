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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package system.models
{
    import system.errors.NoSuchElementError;
    
    /**
     * This model can keep a serie of objects in memory and emit messages if this object is changing.
     * @example Example
     * <listing version="3.0">
     * <code class="prettyprint">
     * import system.models.MemoryModel ;
     * 
     * var before:Function = function( value:* , model:MemoryModel ):void
     * {
     *     trace( "before current:" + value  + " length:" + model.length ) ;
     * }
     * 
     * var change:Function = function( value:* , model:MemoryModel ):void
     * {
     *     trace( "change current:" + value  + " length:" + model.length ) ;
     * }
     * 
     * var clear:Function = function( model:MemoryModel ):void
     * {
     *     trace( "clear length:" + model.length ) ;
     * }
     * 
     * var model:MemoryModel = new MemoryModel() ;
     * 
     * // model.enableErrorChecking = true ;
     * 
     * model.current = "home" ;
     * model.current = "near" ;
     * model.current = "search" ;
     * model.current = "place" ;
     * model.current = "events" ;
     * model.current = "map" ;
     * model.current = "test" ;
     * 
     * trace( "model size:" + model.length ) ;
     * 
     * model.beforeChanged.connect( before ) ;
     * model.changed.connect( change ) ;
     * model.cleared.connect( clear ) ;
     * 
     * trace( "-- back" ) ;
     * model.back() ;
     * 
     * trace( "-- backTo" ) ;
     * 
     * trace( "remove : " + model.backTo( 2 ) ) ;
     * 
     * trace( "-- home" ) ;
     * 
     * model.home() ;
     * 
     * trace( "--" ) ;
     * 
     * model.clear() ;
     * </code>
     * </listing>
     */
    public class MemoryModel extends ChangeModel 
    {
        /**
         * Creates a new MemoryModel instance.
         */
        public function MemoryModel()
        {
            header = new MemoryEntry() ;
            header.next = header.previous = header ;
        }
        
        /**
         * Indicates if the model throws errors.
         */
        public var enableErrorChecking:Boolean ;
        
        /**
         * Determinates the selected value in this model.
         */
        public override function get current():*
        {
            return _current ;
        }
        
        /**
         * @private
         */
        public override function set current( o:* ):void
        {
            if ( o == _current && security )
            {
                return ;
            }
            
            if( o )
            {
                validate( o ) ;
            }
            
            const old:* = _current ;
            
            if ( old )
            {
                notifyBeforeChange( old ) ;
            }
            
            _current = o ;
            
            if( _current )
            {
                add( _current ) ;
                notifyChange( _current );
            }
        }
        
        /**
         * Indicates in the beforeChange signal if the model is reduced (use the back or the backTo method). 
         * This property is true only before the change of the new position in the model.
         */
        public function get reduced():Boolean
        {
            return _reduced ;
        }
        
        /**
         * Returns the number of elements in memory.
         * @return the number of elements in memory.
         */
        public function get length():uint
        {
            return size ;
        }
        
        /**
         * Go back in the memory and removes the last element in the memory model.
         * @return The last removed element in the memory.
         */
        public function back():*
        {
            const old:* = last() ;
            
            _reduced = true ;
            
            if ( old != null )
            {
                notifyBeforeChange( old ) ;
            }
            
            _reduced = false ;
            
            removeLast() ;
            
            _current = last() ;
            
            if ( _current != null )
            {
                notifyChange( _current );
            }
            
            return old ;
        }
        
        /**
         * Go back in the memory and removes the all the element in the memory model to a specific position.
         * @param pos The position to back in memory.
         * @return The Array representation of all removed element in memory.
         */
        public function backTo( pos:uint = 1 ):*
        {
            if( pos < 1 )
            {
                pos = 1 ;
            }
            if( size > 1 )
            {
                if( pos < size )
                {
                    _reduced = true ;
                    
                    var old:* = last() ;
                    
                    if ( old )
                    {
                        notifyBeforeChange( old ) ;
                    }

                    while( pos != size )
                    {
                        removeLast() ;
                    }
                    
                    _reduced = false ;
                    
                    _current = last() ;
                    
                    if ( _current != null )
                    {
                        notifyChange( _current );
                    }
                    
                    return old ;
                }
                else
                {
                    if( enableErrorChecking )
                    {
                        throw new RangeError( this + " backTo failed, the passed-in index '" + pos + "' is out of bounds (" + size + "." ) ;
                    }
                    else
                    {
                        return null ;
                    }
                }
            }
            else
            {
                if( enableErrorChecking )
                {
                    throw new NoSuchElementError( this + " backTo failed, the length of the memory model must be greater than 1 element.");
                }
                else
                {
                    return null ;
                }
            }
        }
        
        /**
         * Clear the model.
         */
        public override function clear():void
        {
            if( size > 0 )
            {
                var e:MemoryEntry = header.next;
                var next:MemoryEntry ;
                while ( e != header ) 
                {
                    next = e.next ;
                    e.next = e.previous = null ;
                    e.element = null ;
                    e = next ;
                }
                header.next = header.previous = header ;
                size = 0 ;
            }
            super.clear() ;
        }
        
        /**
         * Returns the first element in memory.
         * @return the first element in this list.
         * @throws NoSuchElementError if this list is empty.
         */
        public function first():*
        {
            if (size > 0 )
            {
                return header.next.element ;
            }
            else
            {
                if( enableErrorChecking )
                {
                    throw new NoSuchElementError( this + " first method failed, the memory is empty.") ;
                }
                else
                {
                    return null ;
                }
            }
        }

        /**
         * Go home in the memory, select the first element in the memory and remove all other elements. This method work only if the memory length is greater than 1.
         */
        public function home():*
        {
            if( size > 1 )
            {
                var old:* = header.previous.element ;
                
                if ( old != null )
                {
                    notifyBeforeChange( old ) ;
                }
                
                var top:MemoryEntry = header.next ;
                
                while( header.previous != top )
                {
                    removeEntry( header.previous ) ;
                }
                
                _current = last() ;
                
                if ( _current != null )
                {
                    notifyChange( _current );
                }
                
                return old ;
            }
            else
            {
                if( enableErrorChecking )
                {
                    throw new NoSuchElementError( this + " home failed, the length of the memory model must be greater than 1 element.");
                }
                else
                {
                    return null ;
                }
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this memory model is empty.
         * @return <code class="prettyprint">true</code> if this memory model is empty.
         */
        public function isEmpty():Boolean 
        {
            return size == 0 ;
        }
        
        /**
         * Returns the last element in memory.
         * @return the last element in this list.
         * @throws NoSuchElementError if this list is empty.
         */
        public function last():*
        {
            if ( size > 0 )
            {
                return header.previous.element ;
            }
            else
            {
                if( enableErrorChecking )
                {
                    throw new NoSuchElementError( this + " last method failed, the memory is empty.") ;
                }
                else
                {
                    return null ;
                }
            }
        }
        
        /**
         * The internal header of this memory model.
         */
        protected var header:MemoryEntry ;
        
        /**
         * @private
         */
        protected var _reduced:Boolean ;
        
        /**
         * The internal size of the list.
         */
        protected var size:uint ;
        
        /**
         * Appends the specified element to the end of this list.
         * @param element The element to be appended to this list.
         */
        protected function add( element:* ):*
        {
            addBefore( element , header ) ;
            return element ;
        }
        
        /**
         * Inserts the given element in the memory before the given entry.
         */
        protected function addBefore( element:* , entry:MemoryEntry ):MemoryEntry
        {
            var e:MemoryEntry = new MemoryEntry( element, entry, entry.previous ) ;
            e.previous.next = e ;
            e.next.previous = e ;
            size ++ ;
            return e ;
        }
        
        /**
         * Removes a specific entry in memory.
         */
        protected function removeEntry( entry:MemoryEntry ):*
        {
            if ( entry == header )
            {
                if( enableErrorChecking )
                {
                    throw new NoSuchElementError( this + " removeEntry failed.");
                }
                else
                {
                    return null ;
                }
            }
            
            var result:* = entry.element ;
            
            entry.previous.next = entry.next ;
            entry.next.previous = entry.previous ;
            entry.next = entry.previous = null ;
            entry.element = null ;
            
            size-- ;
            
            return result ;
        }
        
        /**
         * Removes and returns the last element from this list.
         * @return The last removed element from this list.
         */
        protected function removeLast():*
        {
            return removeEntry( header.previous );
        }
    }
}
