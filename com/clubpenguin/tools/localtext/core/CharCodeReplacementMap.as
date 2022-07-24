package com.clubpenguin.tools.localtext.core
{
   public class CharCodeReplacementMap
   {
       
      
      private const MAP_LENGTH:uint = 20000;
      
      private const replacementMap:Vector.<int> = new Vector.<int>(this.MAP_LENGTH,true);
      
      public function CharCodeReplacementMap()
      {
         super();
         this.setupMap();
      }
      
      private function setupMap() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.MAP_LENGTH)
         {
            this.replacementMap[_loc1_] = -1;
            _loc1_++;
         }
         this.replacementMap[160] = 32;
      }
      
      public function replaceCharCodesForSring(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc2_:uint = param1.length;
         var _loc3_:int = 0;
         var _loc5_:Array = [];
         var _loc6_:uint = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = param1.charCodeAt(_loc6_);
            _loc4_ = this.replacementMap[_loc3_];
            if(_loc4_ > -1)
            {
               _loc5_.push(_loc4_);
            }
            else
            {
               _loc5_.push(_loc3_);
            }
            _loc6_++;
         }
         return String.fromCharCode.apply(null,_loc5_);
      }
   }
}
