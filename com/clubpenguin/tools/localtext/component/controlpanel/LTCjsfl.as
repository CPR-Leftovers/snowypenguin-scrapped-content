package com.clubpenguin.tools.localtext.component.controlpanel
{
   import adobe.utils.MMExecute;
   import fl.controls.ComboBox;
   import flash.text.TextField;
   
   public class LTCjsfl
   {
      
      private static const HANDLE_CS6_BUG:Boolean = true;
      
      private static const CS6_BUG_FL_DOC_LTC_PARAM_NAME:String = "localTextComponentOrderedParamterNames";
       
      
      public function LTCjsfl()
      {
         super();
      }
      
      public static function getOrderedParameterIndicesFromSelection() : String
      {
         if(HANDLE_CS6_BUG)
         {
            return handleCS6MissingParameterNameBug();
         }
         return getOrderedParamString();
      }
      
      private static function getOrderedParamString() : String
      {
         var _loc1_:* = "function getParamNames() {" + "var selection = fl.getDocumentDOM().selection[0];" + "if (selection != undefined) {" + "var paramNames = new Array();" + "for (var i = 0; i < selection.parameters.length; i++) {" + "\tparamNames[i] = selection.parameters[i].name;" + "}" + "return paramNames;" + "} else {" + "\tfl.outputPanel.trace(\'ERROR: Valid LocalTextComponent Live Preview is not selected!\');" + "}" + "return [];" + "} getParamNames();";
         return MMExecute(_loc1_);
      }
      
      public static function getValueJSFLForParamIndex(param1:uint, param2:String) : String
      {
         var _loc3_:String = "fl.getDocumentDOM().selection[0].parameters[" + param1 + "]." + param2;
         return _loc3_;
      }
      
      public static function getAssignmentJSFLForParamIndex(param1:uint, param2:String, param3:*, param4:Boolean = false) : String
      {
         var _loc5_:String = !param4 && (param3 is Number || param3 is int || param3 is uint)?"":"\"";
         var _loc6_:* = getValueJSFLForParamIndex(param1,param2) + " = " + _loc5_ + param3 + _loc5_ + ";" + "fl.getDocumentDOM().livePreview = true;";
         return _loc6_;
      }
      
      public static function comboBoxFromJSFL(param1:uint, param2:ComboBox) : void
      {
         var _loc3_:Array = listFromJSFL(param1);
         param2.removeAll();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            param2.addItem({
               "label":_loc3_[_loc4_],
               "data":_loc3_[_loc4_]
            });
            _loc4_++;
         }
      }
      
      public static function listFromJSFL(param1:uint) : Array
      {
         var _loc2_:* = "function getListItemNames() {" + "var listItemParameters = fl.getDocumentDOM().selection[0].parameters[" + param1 + "].value;" + "var listItemNames = new Array();" + "for (var i = 0; i < listItemParameters.length; i++) {" + "\tlistItemNames[i] = listItemParameters[i].value;" + "}" + "return listItemNames;" + "} getListItemNames();";
         var _loc3_:Array = MMExecute(_loc2_).split(",");
         return _loc3_;
      }
      
      public static function getParameterColorInt(param1:String) : int
      {
         var _loc2_:String = param1;
         var _loc3_:int = _loc2_.indexOf("#");
         if(_loc3_ > -1)
         {
            _loc2_ = _loc2_.substr(_loc3_ + 1);
            return parseInt(_loc2_,16);
         }
         return int(_loc2_);
      }
      
      public static function rgbAndAlphaToHexRGBA(param1:uint, param2:Number) : String
      {
         var _loc3_:uint = param1 >> 16 & 255;
         var _loc4_:String = _loc3_.toString(16);
         if(_loc3_ < 16)
         {
            _loc4_ = "0" + _loc4_;
         }
         var _loc5_:uint = param1 >> 8 & 255;
         var _loc6_:String = _loc5_.toString(16);
         if(_loc5_ < 16)
         {
            _loc6_ = "0" + _loc6_;
         }
         var _loc7_:uint = param1 & 255;
         var _loc8_:String = _loc7_.toString(16);
         if(_loc7_ < 16)
         {
            _loc8_ = "0" + _loc8_;
         }
         var _loc9_:uint = param2 * 255;
         var _loc10_:String = _loc9_.toString(16);
         if(_loc9_ < 16)
         {
            _loc10_ = "0" + _loc10_;
         }
         return "#" + _loc4_ + _loc6_ + _loc8_ + _loc10_;
      }
      
      public static function hexRGBAToUInt(param1:String) : uint
      {
         if(param1.indexOf("#") != 0)
         {
            throw new Error("Not a valid hex string. Must begin with #.");
         }
         var _loc2_:* = param1.substr(1);
         if(_loc2_.length == 6)
         {
            _loc2_ = _loc2_ + "ff";
         }
         return uint("0x" + _loc2_);
      }
      
      public static function showAlert(param1:String) : void
      {
         MMExecute("alert(\'" + param1 + "\');");
      }
      
      public static function limitInputTextToRange(param1:Number, param2:Number, param3:Number, param4:TextField) : Number
      {
         var _loc5_:Number = param1;
         if(param1 > param3)
         {
            _loc5_ = param3;
         }
         else if(param1 < param2)
         {
            _loc5_ = param2;
         }
         if(_loc5_ != param1)
         {
            param4.text = "" + _loc5_;
         }
         return _loc5_;
      }
      
      private static function handleCS6MissingParameterNameBug() : String
      {
         var _loc1_:* = MMExecute("fl.getDocumentDOM().selection[0].parameters[0].name;") == "";
         var _loc2_:String = MMExecute("fl.getDocumentDOM().getDataFromDocument(\'" + CS6_BUG_FL_DOC_LTC_PARAM_NAME + "\');");
         var _loc3_:* = parseInt(_loc2_) != 0;
         if(!_loc1_)
         {
            _loc2_ = getOrderedParamString();
            if(!_loc3_)
            {
               MMExecute("fl.getDocumentDOM().addDataToDocument(\'" + CS6_BUG_FL_DOC_LTC_PARAM_NAME + "\', \'string\', \'" + _loc2_ + "\')");
            }
         }
         return _loc2_;
      }
   }
}
