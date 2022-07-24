package com.clubpenguin.tools.localtext.core.events
{
   import flash.events.Event;
   
   public class FontLibraryEvent extends Event
   {
      
      public static const LOAD_COMPLETE:String = "fontLibLoadComplete";
      
      public static const FONT_CHANGED:String = "fontChanged";
       
      
      private var _target:Object;
      
      public function FontLibraryEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Object = null)
      {
         super(param1,param2,param3);
         this._target = param4;
      }
      
      override public function get target() : Object
      {
         return this._target;
      }
      
      override public function clone() : Event
      {
         return new FontLibraryEvent(this.type,this.bubbles,this.cancelable,this.target);
      }
   }
}
