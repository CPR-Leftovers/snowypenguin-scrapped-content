package com.clubpenguin.tools.localtext.component
{
   import com.clubpenguin.tools.localtext.core.ILocalTextField;
   
   public interface ILocalTextComponent
   {
       
      
      function get localTextField() : ILocalTextField;
      
      function getMetaData() : String;
   }
}
