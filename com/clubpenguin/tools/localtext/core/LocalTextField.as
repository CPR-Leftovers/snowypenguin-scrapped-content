package com.clubpenguin.tools.localtext.core
{
   import com.clubpenguin.tools.localtext.core.events.FontLibraryEvent;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class LocalTextField extends MovieClip implements ILocalTextField
   {
      
      public static const FONT_NOT_APPLIED:String = "fontNotApplied";
      
      public static const FONT_APPLIED:String = "fontApplied";
      
      public static const FONT_NOT_RENDERING:String = "fontNotRendering";
      
      private static const REPLACEMENT_MAP:CharCodeReplacementMap = new CharCodeReplacementMap();
       
      
      private const propertyNames:Vector.<String> = new Vector.<String>();
      
      private const propertyValues:Array = [];
      
      private var _textBounds:TextBounds;
      
      private var _token:String;
      
      private var _fontAlias:String;
      
      private var _groupName:String;
      
      private var _textField:TextField;
      
      private var _status:String;
      
      private var _embedFonts:Boolean = true;
      
      private var _rendered:Boolean = false;
      
      private var _textVerticalAlignment:String;
      
      private var _componentVersion:String;
      
      private var _replacementMap:CharCodeReplacementMap;
      
      public function LocalTextField()
      {
         this._replacementMap = REPLACEMENT_MAP;
         super();
         this._status = FONT_NOT_APPLIED;
         this._textField = this["textField"];
         this._textBounds = new TextBounds(this._textField);
         this._textBounds.visible = false;
         addChild(this._textBounds);
         setChildIndex(this._textBounds,0);
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function disableFontEmbedding() : void
      {
         this._embedFonts = false;
      }
      
      public function get allowEmbededFonts() : Boolean
      {
         return this._embedFonts;
      }
      
      public function get fontAlias() : String
      {
         return this._fontAlias;
      }
      
      public function set fontAlias(param1:String) : void
      {
         this._fontAlias = param1;
         var _loc2_:FontLibraryEvent = new FontLibraryEvent(FontLibraryEvent.FONT_CHANGED,false,false,this);
         dispatchEvent(_loc2_);
      }
      
      public function get groupName() : String
      {
         return this._groupName;
      }
      
      public function set groupName(param1:String) : void
      {
         this._groupName = param1;
      }
      
      public function get absoluteGroupName() : String
      {
         if(this.isInGroup)
         {
            return this.loaderInfo.url + "::" + this._groupName;
         }
         return null;
      }
      
      public function get isInGroup() : Boolean
      {
         return this.groupName != null && this.groupName != "[none]"?Boolean(Boolean(this.groupName.length)):false;
      }
      
      public function get token() : String
      {
         return this._token;
      }
      
      public function set token(param1:String) : void
      {
         this._token = param1;
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function set status(param1:String) : void
      {
         this._status = param1;
      }
      
      public function get text() : String
      {
         return this._textField.text;
      }
      
      public function set text(param1:String) : void
      {
         this._textField.text = this._replacementMap.replaceCharCodesForSring(param1);
      }
      
      public function get textField() : TextField
      {
         return this._textField;
      }
      
      public function set textField(param1:TextField) : void
      {
         this._textField = param1;
      }
      
      public function replaceTextField(param1:TextField) : void
      {
         this.removeChild(this._textField);
         this.addChild(param1);
         this._textField = param1;
      }
      
      public function get verticalAlignment() : String
      {
         return this._textVerticalAlignment;
      }
      
      public function set verticalAlignment(param1:String) : void
      {
         this._textVerticalAlignment = param1;
      }
      
      public function get rendered() : Boolean
      {
         return this._rendered;
      }
      
      public function set rendered(param1:Boolean) : void
      {
         this._rendered = param1;
      }
      
      public function get componentVersion() : String
      {
         return this._componentVersion;
      }
      
      public function set componentVersion(param1:String) : void
      {
         this._componentVersion = param1;
      }
      
      override public function get width() : Number
      {
         return this._textBounds.width;
      }
      
      override public function get height() : Number
      {
         return this._textBounds.height;
      }
      
      public function get textBounds() : TextBounds
      {
         return this._textBounds;
      }
      
      public function setProperty(param1:String, param2:*) : void
      {
         var _loc3_:int = this.propertyNames.indexOf(param1);
         if(_loc3_ == -1)
         {
            this.propertyNames.push(param1);
            this.propertyValues.push(param2);
         }
         else
         {
            this.propertyValues[_loc3_] = param2;
         }
      }
      
      public function getProperty(param1:String) : *
      {
         var _loc2_:int = this.propertyNames.indexOf(param1);
         return _loc2_ == -1?null:this.propertyValues[_loc2_];
      }
   }
}
