package com.clubpenguin.tools.localtext.component.filters.controller
{
   import com.clubpenguin.tools.localtext.component.filters.FilterDefinition;
   import com.clubpenguin.tools.localtext.component.filters.LTCFilterUtils;
   import flash.filters.BitmapFilter;
   import flash.text.TextField;
   
   public class ApplyRawFiltersToTextFieldCMD
   {
       
      
      private var textField:TextField;
      
      private var rawFiltersString:String;
      
      public function ApplyRawFiltersToTextFieldCMD(param1:TextField, param2:String)
      {
         super();
         this.textField = param1;
         this.rawFiltersString = param2;
      }
      
      public function execute() : void
      {
         var _loc3_:FilterDefinition = null;
         var _loc4_:BitmapFilter = null;
         var _loc1_:Vector.<FilterDefinition> = LTCFilterUtils.getFilterDefsFromRaw(this.rawFiltersString);
         var _loc2_:Array = [];
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = BitmapFilterFactory.INSTANCE.getBitmapFilterFromDefinition(_loc3_);
            _loc2_.push(_loc4_);
         }
         this.textField.filters = _loc2_;
      }
   }
}
