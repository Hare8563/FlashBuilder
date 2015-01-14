package common 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import game.mypage.*;
    
    public class ScrollBar extends game.mypage.ScreenBase
    {
        public function ScrollBar(arg1:flash.display.MovieClip, arg2:flash.display.MovieClip, arg3:flash.display.MovieClip)
        {
            super();
            this.m_Mc = null;
            this.m_BtnPrev = common.Func.Mc2Btn(0, arg1);
            this.m_BtnNext = common.Func.Mc2Btn(1, arg2);
            this.m_Pointer = common.Func.Mc2Btn(2, arg3);
            this.m_Top = this.m_BtnPrev.y + this.m_BtnPrev.height;
            this.m_Bottom = this.m_BtnNext.y - this.m_Pointer.height;
            this.m_Dist = this.m_Bottom - this.m_Top;
            this.m_Rect = new flash.geom.Rectangle(this.m_Pointer.x, this.m_Top, 0, this.m_Dist);
            this.m_Pointer.y = this.m_Top;
            this.m_BtnPrev.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.ButtonDown);
            this.m_BtnNext.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.ButtonDown);
            this.m_Pointer.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.ButtonDown);
            m_Stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this.ButtonUp);
            this.m_BtnPrev.visible = false;
            this.m_BtnNext.visible = false;
            this.m_Pointer.visible = false;
            this.m_IsTarget = false;
            return;
        }

        public function SetTargetMc(arg1:flash.display.MovieClip, arg2:Number, arg3:Number, arg4:Number, arg5:Number=1, arg6:Boolean=false):void
        {
            var loc1:*=NaN;
            this.m_Mc = arg1;
            this.m_ScrollHeight = arg2;
            this.m_StartY = arg4;
            this.m_BlockY = arg5;
            if (!this.m_IsTarget || arg6) 
            {
                this.m_NowY = this.m_StartY;
                this.m_Pointer.y = this.m_Top;
            }
            if (this.m_ScrollHeight > 0) 
            {
                this.m_BtnPrev.visible = true;
                this.m_BtnNext.visible = true;
                this.m_Pointer.visible = true;
                loc1 = this.m_BtnNext.y - (this.m_BtnPrev.y + this.m_BtnPrev.height);
                this.m_Pointer.height = Math.floor(loc1 * arg3);
                if (this.m_Pointer.height < 16) 
                {
                    this.m_Pointer.height = 16;
                }
                this.m_Bottom = this.m_BtnNext.y - this.m_Pointer.height;
                this.m_Dist = this.m_Bottom - this.m_Top;
                this.m_Rect = new flash.geom.Rectangle(this.m_Pointer.x, this.m_Top, 0, this.m_Dist);
            }
            else 
            {
                this.m_BtnPrev.visible = false;
                this.m_BtnNext.visible = false;
                this.m_Pointer.visible = false;
            }
            if (this.m_Pointer.y > this.m_Bottom) 
            {
                this.m_Pointer.y = this.m_Bottom;
            }
            this.m_IsTarget = true;
            if (!this.m_Mc.parent.hasEventListener(flash.events.MouseEvent.MOUSE_WHEEL)) 
            {
                this.m_Mc.parent.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.MouseWheelFunc, false, 0, true);
            }
            return;
        }

        public function ScrollY():Number
        {
            return (this.m_Pointer.y - this.m_Top) / this.m_Dist;
        }

        public override function Release():void
        {
            super.Release();
            if (!(this.m_Mc == null) && this.m_Mc.parent.hasEventListener(flash.events.MouseEvent.MOUSE_WHEEL)) 
            {
                this.m_Mc.parent.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.MouseWheelFunc);
            }
            this.m_BtnPrev.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.ButtonDown);
            this.m_BtnNext.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.ButtonDown);
            this.m_Pointer.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.ButtonDown);
            m_Stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.ButtonUp);
            return;
        }

        private function ButtonDown(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=NaN;
            var loc2:*=arg1.currentTarget.id;
            switch (loc2) 
            {
                case 0:
                {
                    if (this.m_Mc != null) 
                    {
                        loc1 = this.m_Dist / (this.m_ScrollHeight / this.m_BlockY);
                        this.m_Pointer.y = this.m_Pointer.y - loc1;
                        if (this.m_Pointer.y < this.m_Top) 
                        {
                            this.m_Pointer.y = this.m_Top;
                        }
                    }
                    break;
                }
                case 1:
                {
                    if (this.m_Mc != null) 
                    {
                        loc1 = this.m_Dist / (this.m_ScrollHeight / this.m_BlockY);
                        this.m_Pointer.y = this.m_Pointer.y + loc1;
                        if (this.m_Pointer.y > this.m_Bottom) 
                        {
                            this.m_Pointer.y = this.m_Bottom;
                        }
                    }
                    break;
                }
                case 2:
                {
                    this.m_IsDrag = true;
                    this.m_Pointer.startDrag(false, this.m_Rect);
                    break;
                }
            }
            return;
        }

        private function ButtonUp(arg1:flash.events.MouseEvent):void
        {
            this.m_IsDrag = false;
            this.m_Pointer.stopDrag();
            return;
        }

        public function MouseWheelFunc(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=NaN;
            if (!m_Gm.IsActive) 
            {
                return;
            }
            var loc2:*=arg1.delta;
            if (loc2 > 0) 
            {
                if (this.m_Mc != null) 
                {
                    loc1 = this.m_Dist / (this.m_ScrollHeight / this.m_BlockY);
                    this.m_Pointer.y = this.m_Pointer.y - loc1;
                    if (this.m_Pointer.y < this.m_Top) 
                    {
                        this.m_Pointer.y = this.m_Top;
                    }
                }
            }
            if (loc2 < 0) 
            {
                if (this.m_Mc != null) 
                {
                    loc1 = this.m_Dist / (this.m_ScrollHeight / this.m_BlockY);
                    this.m_Pointer.y = this.m_Pointer.y + loc1;
                    if (this.m_Pointer.y > this.m_Bottom) 
                    {
                        this.m_Pointer.y = this.m_Bottom;
                    }
                }
            }
            return;
        }

        public function Enabled(arg1:Boolean):void
        {
            if (arg1) 
            {
                this.m_BtnPrev.mouseEnabled = true;
                this.m_BtnNext.mouseEnabled = true;
                this.m_Pointer.mouseEnabled = true;
            }
            else 
            {
                this.m_BtnPrev.mouseEnabled = false;
                this.m_BtnNext.mouseEnabled = false;
                this.m_Pointer.mouseEnabled = false;
            }
            return;
        }

        public override function Update(arg1:flash.events.Event):void
        {
            if (this.m_Mc != null) 
            {
                this.m_TargetY = this.m_ScrollHeight * this.ScrollY();
                if (this.m_IsDrag) 
                {
                    this.m_TargetY = this.m_StartY - this.m_TargetY;
                }
                else 
                {
                    this.m_TargetY = this.m_StartY - Math.round(this.m_TargetY / this.m_BlockY) * this.m_BlockY;
                }
                this.m_NowY = this.m_NowY + (this.m_TargetY - this.m_NowY) / 2;
                this.m_Mc.y = Math.round(this.m_NowY);
            }
            return;
        }

        private var m_BtnNext:flash.display.MovieClip;

        private var m_IsDrag:Boolean;

        private var m_TargetY:Number;

        private var m_NowY:Number;

        private var m_StartY:Number;

        private var m_Top:Number;

        private var m_BlockY:Number;

        private var m_Bottom:Number;

        private var m_Dist:Number;

        private var m_Rect:flash.geom.Rectangle;

        private var m_IsTarget:Boolean;

        private var m_ScrollHeight:Number;

        private var m_Pointer:flash.display.MovieClip;

        private var m_Mc:flash.display.MovieClip;

        private var m_BtnPrev:flash.display.MovieClip;
    }
}
