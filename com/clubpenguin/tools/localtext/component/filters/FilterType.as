package com.clubpenguin.tools.localtext.component.filters
{
   import flash.filters.DropShadowFilter;
   
   public class FilterType
   {
      
      public static const DROP_SHADOW:FilterType = new FilterType("Drop Shadow","dropShadowFilter",DropShadowFilter,Vector.<String>(["distance","angle","color","blurX","blurY","strength","quality","inner","knockout","hideObject"]));
      
      public static const ALL_TYPES:Vector.<FilterType> = Vector.<FilterType>([DROP_SHADOW]);
       
      
      private var _parameterNames:Vector.<String>;
      
      private var _filterClass:Class;
      
      private var _name:String;
      
      private var _jsflName:String;
      
      public function FilterType(param1:String, param2:String, param3:Class, param4:Vector.<String>)
      {
         super();
         this._name = param1;
         this._jsflName = param2;
         this._filterClass = param3;
         this._parameterNames = param4;
      }
      
      public static function getTypeForJSFLName(param1:String) : FilterType
      {
         var _loc2_:FilterType = null;
         for each(_loc2_ in ALL_TYPES)
         {
            if(_loc2_.jsflName == param1)
            {
               return _loc2_;
            }
         }
         throw new Error("A FilterType does not exist for jsflName: " + param1);
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get numParamaters() : uint
      {
         return this._parameterNames.length;
      }
      
      public function get parameterNames() : Vector.<String>
      {
         return this._parameterNames;
      }
      
      public function get jsflName() : String
      {
         return this._jsflName;
      }
   }
}
