package com.clubpenguin.tools.localtext.core
{
   import flash.events.IEventDispatcher;
   
   public interface ILocalText extends IEventDispatcher
   {
       
      
      function registerFontLibraryDependant(param1:IFontLibraryDependant) : void;
      
      function get libraryInitialized() : Boolean;
      
      function addLocalTF(param1:ILocalTextField) : void;
      
      function setText(param1:ILocalTextField, param2:String) : void;
      
      function setLocalizedText(param1:ILocalizedText) : void;
      
      function loadFontLibrary(param1:String) : void;
      
      function get fontLibrary() : FontLibrary;
   }
}
