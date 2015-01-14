package common 
{
    import flash.display.*;
    import flash.events.*;
    //import net.*;
    
    public class UIButton extends Object
    {
        public function set alpha(arg1:Number):void
        {
            this.m_Mc.alpha = arg1;
            return;
        }

        public function Selected(arg1:Boolean):void
        {
            this.m_IsSelect = arg1;
            if (this.m_IsSelect) 
            {
                this.m_Mc.gotoAndPlay(common.Conf.BUTTON_SELECTED_LABEL);
            }
            else 
            {
                this.m_Mc.gotoAndPlay(common.Conf.BUTTON_NORMAL_LABEL);
            }
            return;
        }

        public function set ID(arg1:int):void
        {
            this.m_ID = arg1;
            return;
        }

        public function get visible():Boolean
        {
            return this.m_Mc.visible;
        }

        public function set mc(arg1:flash.display.MovieClip):void
        {
            this.m_Mc = arg1;
            return;
        }

        public function Enabled(arg1:Boolean):void
        {
            if (arg1) 
            {
                if (this.m_IsSelect) 
                {
                    this.m_Mc.gotoAndPlay(common.Conf.BUTTON_SELECTED_LABEL);
                }
                else 
                {
                    this.m_Mc.gotoAndPlay(common.Conf.BUTTON_NORMAL_LABEL);
                }
                this.m_Mc.mouseEnabled = true;
            }
            else 
            {
                if (this.m_IsSelect) 
                {
                    this.m_Mc.gotoAndPlay(common.Conf.BUTTON_SELECTED_LABEL);
                }
                else 
                {
                    this.m_Mc.gotoAndPlay(common.Conf.BUTTON_DEACTIVE_LABEL);
                }
                this.m_Mc.mouseEnabled = false;
            }
            return;
        }

        public function Release():void
        {
            this.m_Mc.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.ButtonOver);
            this.m_Mc.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.ButtonOut);
            this.m_Mc.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.ButtonDown);
            this.m_Mc.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.ButtonUp);
            this.m_Mc.removeEventListener(flash.events.MouseEvent.CLICK, this.ButtonClick);
            this.m_Mc = null;
            this.m_CallBack = null;
            return;
        }

        protected function ButtonClick(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (!this.m_Mc.mouseEnabled) 
            {
                return;
            }
            if (this.m_CallBack != null) 
            {
                loc1 = new net.ConnectObject(0);
                loc1.id = this.m_ID;
                this.m_CallBack(loc1);
            }
            return;
        }

        public function set visible(arg1:Boolean):void
        {
            this.m_Mc.visible = arg1;
            return;
        }

        public function get alpha():Number
        {
            return this.m_Mc.alpha;
        }

        protected function ButtonOut(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (!this.m_Mc.mouseEnabled) 
            {
                return;
            }
            if (this.m_IsSelect) 
            {
                this.m_Mc.gotoAndPlay(common.Conf.BUTTON_SELECTED_LABEL);
            }
            else 
            {
                this.m_Mc.gotoAndPlay(common.Conf.BUTTON_NORMAL_LABEL);
            }
            if (this.m_OutCallBack != null) 
            {
                loc1 = new net.ConnectObject(0);
                loc1.id = this.m_ID;
                this.m_OutCallBack(loc1);
            }
            return;
        }

        public function get ID():int
        {
            return this.m_ID;
        }

        public function get mc():flash.display.MovieClip
        {
            return this.m_Mc;
        }

        protected function ButtonDown(arg1:flash.events.MouseEvent):void
        {
            if (!this.m_Mc.mouseEnabled) 
            {
                return;
            }
            this.m_Mc.gotoAndPlay(common.Conf.BUTTON_DOWN_LABEL);
            return;
        }

        protected function ButtonUp(arg1:flash.events.MouseEvent):void
        {
            if (!this.m_Mc.mouseEnabled) 
            {
                return;
            }
            this.m_Mc.gotoAndPlay(common.Conf.BUTTON_OVER_LABEL);
            return;
        }

        protected function ButtonOver(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (!this.m_Mc.mouseEnabled) 
            {
                return;
            }
            this.m_Mc.gotoAndPlay(common.Conf.BUTTON_OVER_LABEL);
            if (this.m_OverCallBack != null) 
            {
                loc1 = new net.ConnectObject(0);
                loc1.id = this.m_ID;
                this.m_OverCallBack(loc1);
            }
            return;
        }

        public function UIButton(arg1:flash.display.MovieClip, arg2:int, arg3:Function=null, arg4:Function=null, arg5:Function=null)
        {
            super();
            this.m_Mc = arg1;
            this.m_Mc.buttonMode = true;
            this.m_Mc.mouseChildren = false;
            this.m_Mc.tabEnabled = false;
            this.m_Mc.useHandCursor = true;
            this.m_ID = arg2;
            this.m_CallBack = arg3;
            this.m_OverCallBack = arg4;
            this.m_OutCallBack = arg5;
            this.m_IsSelect = false;
            this.m_Mc.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.ButtonOver);
            this.m_Mc.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.ButtonOut);
            this.m_Mc.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.ButtonDown);
            this.m_Mc.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.ButtonUp);
            this.m_Mc.addEventListener(flash.events.MouseEvent.CLICK, this.ButtonClick);
            return;
        }

        private var m_OutCallBack:Function;

        private var m_CallBack:Function;

        private var m_ID:int;

        private var m_OverCallBack:Function;

        private var m_Mc:flash.display.MovieClip;

        private var m_IsSelect:Boolean;
    }
}
