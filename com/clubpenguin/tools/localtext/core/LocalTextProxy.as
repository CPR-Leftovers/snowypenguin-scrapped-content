package com.clubpenguin.tools.localtext.core
{
   import flash.text.Font;
   
   public class LocalTextProxy
   {
      
      private static const _localTextFields:Array = [];
      
      private static const _fontLibraryDependants:Array = [];
      
      private static var _localText:ILocalText;
      
      private static var compileTimeEnumeratedFonts:Vector.<Font> = Vector.<Font>(Font.enumerateFonts());
       
      
      public function LocalTextProxy()
      {
         super();
      }
      
      public static function queueLocalTextField(param1:ILocalTextField) : void
      {
         if(!_localText)
         {
            _localTextFields.push(param1);
         }
         else
         {
            _localText.addLocalTF(param1);
         }
      }
      
      public static function queueFontLibraryDependant(param1:IFontLibraryDependant) : void
      {
         if(_localText && _localText.libraryInitialized)
         {
            param1.onFontLibraryLoaded();
         }
         else if(_localText)
         {
            _localText.registerFontLibraryDependant(param1);
         }
         else
         {
            _fontLibraryDependants.push(param1);
         }
      }
      
      public static function get initialized() : Boolean
      {
         return _localText != null && _localText.libraryInitialized;
      }
      
      public static function get localText() : ILocalText
      {
         if(!_localText)
         {
            throw new Error("An ILocalText implementation has not been set.");
         }
         return _localText;
      }
      
      public static function set localText(param1:ILocalText) : void
      {
         var _loc2_:LocalTextField = null;
         var _loc3_:IFontLibraryDependant = null;
         _localText = param1;
         for each(_loc2_ in _localTextFields)
         {
            _localText.addLocalTF(_loc2_);
         }
         _localTextFields.length = 0;
         for each(_loc3_ in _fontLibraryDependants)
         {
            if(_localText.libraryInitialized)
            {
               _loc3_.onFontLibraryLoaded();
            }
            else
            {
               _localText.registerFontLibraryDependant(_loc3_);
            }
         }
         _fontLibraryDependants.length = 0;
      }
      
      public static function get allFonts() : Vector.<Font>
      {
         if(!_localText)
         {
            return compileTimeEnumeratedFonts;
         }
         return _localText.fontLibrary.allFonts;
      }
   }
}
