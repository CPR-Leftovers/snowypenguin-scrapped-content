package com.clubpenguin.tools.localtext.component.filters
{
   import com.clubpenguin.tools.localtext.component.controlpanel.LTCjsfl;
   
   public class FilterDefinition
   {
      
      public static const NUM_PARAMS_PER_RAW_FILTER:uint = 19;
      
      public static const RAW_PARAMETER_NAME_INDICES:Object = {
         "name":0,
         "angle":1,
         "blurX":2,
         "blurY":3,
         "brightness":4,
         "color":5,
         "contrast":6,
         "distance":7,
         "enabled":8,
         "hideObject":9,
         "highlightColor":10,
         "hue":11,
         "inner":12,
         "knockout":13,
         "quality":14,
         "saturation":15,
         "shadowColor":16,
         "strength":17,
         "type":18
      };
       
      
      private var _filterType:FilterType;
      
      private var _parameterValues:Array;
      
      public function FilterDefinition(param1:FilterType, param2:Array)
      {
         super();
         this._filterType = param1;
         this._parameterValues = param2;
      }
      
      public static function fromRawArray(param1:Array) : FilterDefinition
      {
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         if(param1.length != NUM_PARAMS_PER_RAW_FILTER)
         {
            throw new Error("Expected rawDefinition to have " + NUM_PARAMS_PER_RAW_FILTER + " values, got " + param1.length);
         }
         var _loc2_:FilterType = FilterType.getTypeForJSFLName(param1[0]);
         var _loc3_:Array = [];
         for each(_loc4_ in _loc2_.parameterNames)
         {
            _loc5_ = RAW_PARAMETER_NAME_INDICES[_loc4_];
            _loc6_ = param1[_loc5_];
            if(_loc6_ == "true" || _loc6_ == "false")
            {
               _loc7_ = Boolean(_loc6_ == "true");
            }
            else if(_loc6_.indexOf("#") == 0)
            {
               _loc7_ = LTCjsfl.hexRGBAToUInt(_loc6_);
            }
            else if(!isNaN(Number(_loc6_)))
            {
               _loc7_ = Number(_loc6_);
            }
            else
            {
               _loc7_ = String(_loc6_);
            }
            _loc3_.push(_loc7_);
         }
         return new FilterDefinition(_loc2_,_loc3_);
      }
      
      public function get filterType() : FilterType
      {
         return this._filterType;
      }
      
      public function get parameterValues() : Array
      {
         return this._parameterValues;
      }
      
      public function toString() : String
      {
         var _loc1_:* = "FilterDefintion:{ FilterType: " + this._filterType.jsflName + ", {";
         var _loc2_:Vector.<String> = this._filterType.parameterNames;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = _loc1_ + (_loc2_[_loc3_] + " = " + this._parameterValues[_loc3_]);
            if(_loc3_ < _loc2_.length - 1)
            {
               _loc1_ = _loc1_ + ", ";
            }
            _loc3_++;
         }
         _loc1_ = _loc1_ + "}}";
         return _loc1_;
      }
   }
}
