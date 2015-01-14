package common 
{
    import flash.display.*;
    import flash.events.*;
    import net.*;
    
    public class CardDrag extends Object
    {
        protected function CardOut(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=new net.ConnectObject(0);
            loc1.result = "OUT";
            loc1.id = this.m_ID;
            this.m_CallBack(loc1);
            return;
        }

        public function set ID(arg1:int):void
        {
            this.m_ID = arg1;
            return;
        }

        public function set visible(arg1:Boolean):void
        {
            this.m_Mc.visible = arg1;
            return;
        }

        public function get ID():int
        {
            return this.m_ID;
        }

        protected function CardMove(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=new net.ConnectObject(0);
            loc1.result = "MOVE";
            loc1.id = this.m_ID;
            this.m_CallBack(loc1);
            return;
        }

        protected function CardClick(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=new net.ConnectObject(0);
            loc1.result = "CLICK";
            loc1.id = this.m_ID;
            this.m_CallBack(loc1);
            return;
        }

        public function get mc():flash.display.MovieClip
        {
            return this.m_Mc;
        }

        protected function CardDown(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=new net.ConnectObject(0);
            loc1.result = "DOWN";
            loc1.id = this.m_ID;
            this.m_CallBack(loc1);
            return;
        }

        public function set mc(arg1:flash.display.MovieClip):void
        {
            this.m_Mc = arg1;
            return;
        }

        protected function CardUp(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=new net.ConnectObject(0);
            loc1.result = "UP";
            loc1.id = this.m_ID;
            this.m_CallBack(loc1);
            return;
        }

        public function get visible():Boolean
        {
            return this.m_Mc.visible;
        }

        public function Release():void
        {
            this.m_Mc.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.CardOver);
            this.m_Mc.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.CardOut);
            this.m_Mc.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.CardDown);
            this.m_Mc.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.CardUp);
            this.m_Mc.removeEventListener(flash.events.MouseEvent.CLICK, this.CardClick);
            this.m_Mc = null;
            this.m_CallBack = null;
            return;
        }

        protected function CardOver(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=new net.ConnectObject(0);
            loc1.result = "OVER";
            loc1.id = this.m_ID;
            this.m_CallBack(loc1);
            return;
        }

        public function Enabled(arg1:Boolean):void
        {
            this.m_Mc.mouseEnabled = arg1;
            return;
        }

        public function CardDrag(arg1:flash.display.MovieClip, arg2:int, arg3:Function)
        {
            super();
            this.m_Mc = arg1;
            this.m_Mc.buttonMode = true;
            this.m_Mc.mouseChildren = false;
            this.m_Mc.tabEnabled = false;
            this.m_Mc.useHandCursor = true;
            this.m_ID = arg2;
            this.m_CallBack = arg3;
            this.m_Mc.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.CardOver);
            this.m_Mc.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.CardOut);
            this.m_Mc.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.CardDown);
            this.m_Mc.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this.CardMove);
            this.m_Mc.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.CardUp);
            this.m_Mc.addEventListener(flash.events.MouseEvent.CLICK, this.CardClick);
            return;
        }

        private var m_ID:int;

        private var m_CallBack:Function;

        private var m_Mc:flash.display.MovieClip;
    }
}
