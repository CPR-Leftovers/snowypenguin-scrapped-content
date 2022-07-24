package com.clubpenguin.tools.localtext.component.filters
{
   public class LTCFilterUtils
   {
       
      
      public function LTCFilterUtils()
      {
         super();
      }
      
      public static function getFilterDefsFromRaw(param1:String) : Vector.<FilterDefinition>
      {
         var _loc4_:Array = null;
         var _loc5_:FilterDefinition = null;
         if(param1 == "")
         {
            return new Vector.<FilterDefinition>();
         }
         var _loc2_:Array = param1.split(",");
         if(_loc2_.length % FilterDefinition.NUM_PARAMS_PER_RAW_FILTER != 0)
         {
            throw new Error("Invalid number of filter parameters fetched via jsfl. Expected multiple of " + FilterDefinition.NUM_PARAMS_PER_RAW_FILTER + ", but got " + _loc2_.length);
         }
         var _loc3_:Vector.<FilterDefinition> = new Vector.<FilterDefinition>();
         while(_loc2_.length && (_loc4_ = _loc2_.splice(0,FilterDefinition.NUM_PARAMS_PER_RAW_FILTER)).length)
         {
            _loc5_ = FilterDefinition.fromRawArray(_loc4_);
            _loc3_.push(_loc5_);
         }
         return _loc3_;
      }
   }
}
