package com.clubpenguin.tools.localtext.core.commands
{
   import com.clubpenguin.tools.localtext.core.ILocalTextField;
   import com.clubpenguin.tools.localtext.core.LocalTextAlign;
   import flash.text.TextField;
   
   public class VAlignLTFContentCMD
   {
       
      
      private const TEXT_VISIBILITY_PADDING:Number = 4;
      
      private var localTextField:ILocalTextField;
      
      private var maxHeight:Number;
      
      public function VAlignLTFContentCMD(param1:ILocalTextField, param2:Number = -1)
      {
         super();
         this.localTextField = param1;
         this.maxHeight = param2;
      }
      
      public function execute() : void
      {
         var _loc1_:TextField = this.localTextField.textField;
         if(this.maxHeight > 0 && _loc1_.textHeight + this.TEXT_VISIBILITY_PADDING > this.maxHeight)
         {
            _loc1_.height = this.maxHeight;
         }
         else
         {
            _loc1_.height = _loc1_.textHeight + this.TEXT_VISIBILITY_PADDING;
         }
         switch(this.localTextField.verticalAlignment)
         {
            case LocalTextAlign.TOP:
               _loc1_.y = 0;
               break;
            case LocalTextAlign.CENTER:
               _loc1_.y = (this.localTextField.height - _loc1_.height) / 2;
               break;
            case LocalTextAlign.BOTTOM:
               _loc1_.y = this.localTextField.height - _loc1_.height;
         }
         this.localTextField.textBounds.draw();
      }
   }
}
