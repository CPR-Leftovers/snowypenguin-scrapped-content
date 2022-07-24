package com.clubpenguin.tools.localtext.core
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.Font;
   import flash.utils.describeType;
   
   public class FontLibrary extends EventDispatcher
   {
       
      
      private var _allFonts:Vector.<Font>;
      
      private var lang:String;
      
      private var fontNamesList:Array;
      
      private var _loadComplete:Boolean;
      
      public function FontLibrary(param1:String)
      {
         super();
         this.lang = param1;
         this.fontNamesList = new Array();
      }
      
      public function load(param1:String) : void
      {
         var _loc2_:Loader = new Loader();
         var _loc3_:LoaderContext = new LoaderContext();
         _loc3_.applicationDomain = ApplicationDomain.currentDomain;
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onFontLoadComplete);
         _loc2_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,dispatchEvent);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,dispatchEvent);
         _loc2_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,dispatchEvent);
         _loc2_.load(new URLRequest(param1),_loc3_);
      }
      
      private function onFontLoadComplete(param1:Event) : void
      {
         var fontLib:Class = null;
         var i:int = 0;
         var fontClass:Class = null;
         var event:Event = param1;
         var loader:LoaderInfo = event.target as LoaderInfo;
         loader.removeEventListener(Event.COMPLETE,this.onFontLoadComplete);
         loader.removeEventListener(ProgressEvent.PROGRESS,dispatchEvent);
         loader.removeEventListener(IOErrorEvent.IO_ERROR,dispatchEvent);
         loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,dispatchEvent);
         try
         {
            fontLib = LoaderInfo(event.target).applicationDomain.getDefinition("com.clubpenguin.fonts." + this.lang + ".FontLibrary") as Class;
         }
         catch(e:Error)
         {
            throw new Error("Could not load FontLibrary for language: \'" + lang + "\'.");
         }
         var description:XMLList = describeType(fontLib)..variable;
         this._loadComplete = true;
         try
         {
            while(i < description.length())
            {
               fontClass = fontLib[description[i].@name] as Class;
               Font.registerFont(fontClass);
               this.fontNamesList.push(description[i].@name);
               i++;
            }
         }
         catch(error:Error)
         {
            throw new Error("Error registering loaded fonts: " + error.message);
         }
         this._allFonts = Vector.<Font>(Font.enumerateFonts());
         dispatchEvent(event);
      }
      
      public function get isLoadComplete() : Boolean
      {
         return this._loadComplete;
      }
      
      public function getFontNamesList() : Array
      {
         return this.fontNamesList;
      }
      
      public function fontHasGlyphs(param1:String, param2:String) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc5_:Font = null;
         var _loc4_:String = param2.replace(/[\r\n]/g,"");
         for each(_loc5_ in this._allFonts)
         {
            if(_loc5_.fontName == param1)
            {
               _loc3_ = _loc5_.hasGlyphs(_loc4_);
               break;
            }
         }
         return _loc3_;
      }
      
      public function findUnsupportedGlyphsForFont(param1:String, param2:String) : String
      {
         var _loc4_:Font = null;
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         for each(_loc4_ in this._allFonts)
         {
            if(_loc4_.fontName == param1)
            {
               if(param2.length > 0)
               {
                  _loc5_ = 0;
                  while(_loc5_ < param2.length)
                  {
                     if(!_loc4_.hasGlyphs(param2.charAt(_loc5_)))
                     {
                        trace("glyph not found: " + param2.charAt(_loc5_) + " unicode: " + param2.charCodeAt(_loc5_));
                        _loc3_.push("[index:" + _loc5_ + ", char:" + param2.charAt(_loc5_) + ", charCode:" + param2.charCodeAt(_loc5_) + "]");
                     }
                     _loc5_++;
                  }
               }
               break;
            }
         }
         return _loc3_.join(",");
      }
      
      public function isFontRegistered(param1:String) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in this.fontNamesList)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getFontByName(param1:String) : Font
      {
         var _loc2_:Font = null;
         for each(_loc2_ in this._allFonts)
         {
            if(_loc2_.fontName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get allFonts() : Vector.<Font>
      {
         if(!this._allFonts)
         {
            this._allFonts = Vector.<Font>(Font.enumerateFonts());
         }
         return this._allFonts;
      }
   }
}
