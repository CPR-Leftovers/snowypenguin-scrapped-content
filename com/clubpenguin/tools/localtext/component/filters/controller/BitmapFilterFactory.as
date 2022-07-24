package com.clubpenguin.tools.localtext.component.filters.controller
{
   import com.clubpenguin.tools.localtext.component.filters.FilterDefinition;
   import com.clubpenguin.tools.localtext.component.filters.FilterType;
   import flash.filters.BitmapFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   
   public class BitmapFilterFactory
   {
      
      public static const INSTANCE:BitmapFilterFactory = new BitmapFilterFactory();
       
      
      private const creationFuncsByFiltType:Dictionary = new Dictionary();
      
      public function BitmapFilterFactory()
      {
         super();
         if(INSTANCE)
         {
            throw new Error("Singleton, use static INSTANCE property instead.");
         }
         this.mapFilterCreationFunctions();
      }
      
      private function mapFilterCreationFunctions() : void
      {
         this.creationFuncsByFiltType[FilterType.DROP_SHADOW] = this.createDropShadowFilter;
      }
      
      private function getCreationFunctionForType(param1:FilterType) : Function
      {
         if(!this.creationFuncsByFiltType[param1])
         {
            throw new Error("There is no creation function mapping for FilterType: " + param1.name + ".  Please create one.");
         }
         return this.creationFuncsByFiltType[param1];
      }
      
      public function getBitmapFilterFromDefinition(param1:FilterDefinition) : BitmapFilter
      {
         var _loc2_:Function = this.getCreationFunctionForType(param1.filterType);
         return _loc2_(param1) as BitmapFilter;
      }
      
      private function createDropShadowFilter(param1:FilterDefinition) : BitmapFilter
      {
         var _loc2_:Vector.<String> = param1.filterType.parameterNames;
         var _loc3_:Array = param1.parameterValues;
         var _loc4_:Number = _loc3_[_loc2_.indexOf("distance")];
         var _loc5_:Number = _loc3_[_loc2_.indexOf("angle")];
         var _loc6_:uint = uint(_loc3_[_loc2_.indexOf("color")]);
         var _loc7_:Number = (_loc6_ & 255) / 255;
         _loc6_ = _loc6_ >> 8;
         var _loc8_:Number = _loc3_[_loc2_.indexOf("blurX")];
         var _loc9_:Number = _loc3_[_loc2_.indexOf("blurY")];
         var _loc10_:Number = _loc3_[_loc2_.indexOf("strength")];
         var _loc11_:int = 1;
         switch(_loc3_[_loc2_.indexOf("quality")])
         {
            case "low":
               _loc11_ = BitmapFilterQuality.LOW;
               break;
            case "medium":
               _loc11_ = BitmapFilterQuality.MEDIUM;
               break;
            case "high":
               _loc11_ = BitmapFilterQuality.HIGH;
               break;
            default:
               throw new Error();
         }
         var _loc12_:Boolean = _loc3_[_loc2_.indexOf("inner")];
         var _loc13_:Boolean = _loc3_[_loc2_.indexOf("knockout")];
         var _loc14_:Boolean = _loc3_[_loc2_.indexOf("hideObject")];
         var _loc15_:DropShadowFilter = new DropShadowFilter(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_);
         return _loc15_;
      }
      
      private function createGlowFilter(param1:FilterDefinition) : BitmapFilter
      {
         var _loc2_:Vector.<String> = param1.filterType.parameterNames;
         var _loc3_:Array = param1.parameterValues;
         var _loc4_:uint = uint(_loc3_[_loc2_.indexOf("color")]);
         var _loc5_:Number = (_loc4_ & 255) / 255;
         _loc4_ = _loc4_ >> 8;
         var _loc6_:Number = _loc3_[_loc2_.indexOf("blurX")];
         var _loc7_:Number = _loc3_[_loc2_.indexOf("blurY")];
         var _loc8_:Number = _loc3_[_loc2_.indexOf("strength")];
         var _loc9_:int = 1;
         switch(_loc3_[_loc2_.indexOf("quality")])
         {
            case "low":
               _loc9_ = BitmapFilterQuality.LOW;
               break;
            case "medium":
               _loc9_ = BitmapFilterQuality.MEDIUM;
               break;
            case "high":
               _loc9_ = BitmapFilterQuality.HIGH;
               break;
            default:
               throw new Error();
         }
         var _loc10_:Boolean = _loc3_[_loc2_.indexOf("inner")];
         var _loc11_:Boolean = _loc3_[_loc2_.indexOf("knockout")];
         var _loc12_:GlowFilter = new GlowFilter(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_);
         return _loc12_;
      }
   }
}
