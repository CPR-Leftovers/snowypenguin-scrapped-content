package com.clubpenguin.tools.localtext.core
{
   import flash.utils.Dictionary;
   
   public interface ILocalizedText
   {
       
      
      function setLocalText(param1:Dictionary) : void;
      
      function getTextForToken(param1:String) : String;
   }
}
