package common 
{
    import flash.events.*;
    
    public dynamic class DynamicEvent extends flash.events.Event
    {
        public function set dialog(arg1:common.DialogObject):void
        {
            this.m_Dialog = new common.DialogObject(arg1.title, arg1.message, arg1.buttonMode);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new common.DynamicEvent(type, bubbles, cancelable);
        }

        public function get soundName():String
        {
            return this.m_SoundName;
        }

        public function set soundName(arg1:String):void
        {
            this.m_SoundName = arg1;
            return;
        }

        public function set fontClass(arg1:Object):void
        {
            this.m_Font = arg1;
            return;
        }

        public function get soundClass():Object
        {
            return this.m_Sound;
        }

        public function set check(arg1:Boolean):void
        {
            this.m_Check = arg1;
            return;
        }

        public function set soundClass(arg1:Object):void
        {
            this.m_Sound = arg1;
            return;
        }

        public function get check():Boolean
        {
            return this.m_Check;
        }

        public function get fontClass():Object
        {
            return this.m_Font;
        }

        public function get dialog():common.DialogObject
        {
            return this.m_Dialog;
        }

        public function DynamicEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            this.m_Sound = null;
            this.m_Font = null;
            this.m_Dialog = new common.DialogObject();
            return;
        }

        public static const LEAGUE_RESULT_OPEN:String="LeagueResultOpen";

        public static const DIALOG_MODE_SHOP:int=2;

        public static const DIALOG_OPEN:String="DialogOpen";

        public static const DIALOG_MODE_CLOSE:int=0;

        public static const DIALOG_MODE_CONNECT:int=3;

        public static const BUTTON_CANCEL:int=1;

        public static const BUTTON_NO:int=3;

        public static const DIALOG_CLOSE:String="DialogClose";

        public static const LEAGUE_START:String="LeagueStart";

        public static const BUTTON_YES:int=2;

        public static const BATTLE_END:String="BattleEnd";

        public static const DIALOG_MODE_STOP:int=4;

        public static const BUTTON_RETRY:int=4;

        public static const NEXT_SHOW:String="NextShow";

        public static const BUTTON_CLOSE:int=0;

        public static const BATTLE_START:String="BattleStart";

        public static const LEAGUE_RESULT_CLOSE:String="LeagueResultClose";

        public static const SOUND_PLAY:String="SoundPlay";

        public static const DIALOG_MODE_YESNO:int=1;

        public var m_Dialog:common.DialogObject;

        public var m_Check:Boolean;

        public var m_SoundName:String;

        public var m_Sound:Object;

        public var m_Font:Object;
    }
}
