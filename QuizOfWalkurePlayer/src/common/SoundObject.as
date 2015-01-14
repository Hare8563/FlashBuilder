package common 
{
    import flash.events.*;
    import flash.media.*;
    import flash.utils.*;
    
    public class SoundObject extends Object
    {
        public function Pause():void
        {
            if (this.m_Channel == null) 
            {
                return;
            }
            this.m_CurrentPos = this.m_Channel.position;
            this.m_Channel.stop();
            this.m_Channel.removeEventListener(flash.events.Event.SOUND_COMPLETE, this.SoundCompleteFunc);
            this.m_Channel = null;
            return;
        }

        public function FadeIn(arg1:Number=0.5):void
        {
            if (this.m_Channel == null) 
            {
                return;
            }
            this.m_FadeStartVolume = 0;
            this.FadeVolume(this.m_FadeStartVolume);
            this.m_FadeEndVolume = 1;
            this.m_FadeTime = flash.utils.getTimer();
            this.m_FadeEndTime = arg1 * 1000;
            this.m_SoundStop = false;
            if (this.m_Timer != null) 
            {
                this.m_Timer.removeEventListener(flash.events.TimerEvent.TIMER, this.FadeHandler);
            }
            this.m_Timer = new flash.utils.Timer(50, 0);
            this.m_Timer.start();
            this.m_Timer.addEventListener(flash.events.TimerEvent.TIMER, this.FadeHandler);
            return;
        }

        public function IsPlay():Boolean
        {
            return !(this.m_Channel == null);
        }

        public function Stop():void
        {
            if (this.m_Channel == null) 
            {
                return;
            }
            if (this.m_Timer != null) 
            {
                this.m_Timer.removeEventListener(flash.events.TimerEvent.TIMER, this.FadeHandler);
                this.m_Timer = null;
            }
            this.m_CurrentPos = 0;
            this.m_LoopCount = this.m_Loop;
            this.m_Channel.stop();
            this.m_Channel.removeEventListener(flash.events.Event.SOUND_COMPLETE, this.SoundCompleteFunc);
            this.m_Channel = null;
            return;
        }

        public function IsFade():Boolean
        {
            return !(this.m_Timer == null);
        }

        public function FadeVolume(arg1:Number):void
        {
            var loc1:*=null;
            if (this.m_Channel != null) 
            {
                loc1 = this.m_Channel.soundTransform;
                loc1.volume = arg1 * this.m_Volume * common.SoundManager.TypeVolume[this.m_Type];
                this.m_Channel.soundTransform = loc1;
            }
            return;
        }

        public function Restart():void
        {
            var loc1:*=null;
            if (this.m_Sound == null) 
            {
                return;
            }
            if (this.m_Channel != null) 
            {
                this.m_Channel.stop();
                this.m_Channel.removeEventListener(flash.events.Event.SOUND_COMPLETE, this.SoundCompleteFunc);
            }
            if (this.m_Timer != null) 
            {
                this.m_Timer.removeEventListener(flash.events.TimerEvent.TIMER, this.FadeHandler);
                this.m_Timer = null;
            }
            this.m_Channel = this.m_Sound.play(this.m_CurrentPos, 0);
            loc1 = this.m_Channel.soundTransform;
            loc1.volume = this.m_Volume * common.SoundManager.TypeVolume[this.m_Type];
            this.m_Channel.soundTransform = loc1;
            this.m_Channel.addEventListener(flash.events.Event.SOUND_COMPLETE, this.SoundCompleteFunc);
            return;
        }

        public function Play(arg1:Boolean=false):void
        {
            var loc1:*=null;
            if (this.m_Sound == null) 
            {
                return;
            }
            if (this.m_Channel != null) 
            {
                this.m_Channel.stop();
                this.m_Channel.removeEventListener(flash.events.Event.SOUND_COMPLETE, this.SoundCompleteFunc);
            }
            if (!arg1 && !(this.m_Timer == null)) 
            {
                this.m_Timer.removeEventListener(flash.events.TimerEvent.TIMER, this.FadeHandler);
                this.m_Timer = null;
            }
            var loc2:*;
            var loc3:*=((loc2 = this).m_LoopCount - 1);
            loc2.m_LoopCount = loc3;
            this.m_Channel = this.m_Sound.play(0, 0);
            loc1 = this.m_Channel.soundTransform;
            loc1.volume = this.m_Volume * common.SoundManager.TypeVolume[this.m_Type];
            this.m_Channel.soundTransform = loc1;
            this.m_Channel.addEventListener(flash.events.Event.SOUND_COMPLETE, this.SoundCompleteFunc);
            return;
        }

        public function FadeHandler(arg1:flash.events.TimerEvent):void
        {
            var loc1:*=null;
            if (this.m_Channel == null) 
            {
                this.m_Timer.removeEventListener(flash.events.TimerEvent.TIMER, this.FadeHandler);
                this.m_Timer = null;
                return;
            }
            loc1 = this.m_Channel.soundTransform;
            var loc2:*=flash.utils.getTimer() - this.m_FadeTime;
            if (loc2 > this.m_FadeEndTime) 
            {
                loc2 = this.m_FadeEndTime;
                this.m_Timer.removeEventListener(flash.events.TimerEvent.TIMER, this.FadeHandler);
                this.m_Timer = null;
            }
            var loc3:*=this.easeNone(loc2, this.m_FadeStartVolume, this.m_FadeEndVolume, this.m_FadeEndTime);
            this.FadeVolume(loc3);
            if (this.m_Timer == null && loc3 == 0 && this.m_SoundStop) 
            {
                this.Pause();
            }
            return;
        }

        public function FadeOut(arg1:Number=0.5, arg2:Boolean=true):void
        {
            if (this.m_Channel == null) 
            {
                return;
            }
            this.m_FadeStartVolume = 1;
            this.FadeVolume(this.m_FadeStartVolume);
            this.m_FadeEndVolume = 0;
            this.m_FadeTime = flash.utils.getTimer();
            this.m_FadeEndTime = arg1 * 1000;
            this.m_SoundStop = arg2;
            if (this.m_Timer != null) 
            {
                this.m_Timer.removeEventListener(flash.events.TimerEvent.TIMER, this.FadeHandler);
                this.m_Timer = null;
            }
            this.m_Timer = new flash.utils.Timer(50, 0);
            this.m_Timer.start();
            this.m_Timer.addEventListener(flash.events.TimerEvent.TIMER, this.FadeHandler);
            return;
        }

        private function SoundCompleteFunc(arg1:flash.events.Event):void
        {
            arg1.target.removeEventListener(flash.events.Event.SOUND_COMPLETE, this.SoundCompleteFunc);
            this.m_CurrentPos = 0;
            this.m_Channel = null;
            if (this.m_Loop < 0) 
            {
                this.m_CurrentPos = 0;
                this.Play(true);
            }
            else if (this.m_LoopCount > 1) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this).m_LoopCount - 1);
                loc1.m_LoopCount = loc2;
                this.Play(true);
            }
            return;
        }

        public function get volume():Number
        {
            return this.m_Volume;
        }

        public function get type():Number
        {
            return this.m_Type;
        }

        public function set type(arg1:Number):void
        {
            this.m_Type = arg1;
            return;
        }

        public function easeNone(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            return (arg3 - arg2) * arg1 / arg4 + arg2;
        }

        public function set volume(arg1:Number):void
        {
            var loc1:*=null;
            this.m_Volume = arg1;
            if (this.m_Channel != null) 
            {
                loc1 = this.m_Channel.soundTransform;
                loc1.volume = this.m_Volume * common.SoundManager.TypeVolume[this.m_Type];
                this.m_Channel.soundTransform = loc1;
            }
            return;
        }

        public function SoundObject(arg1:flash.media.Sound, arg2:int, arg3:Number, arg4:int)
        {
            super();
            this.m_Sound = arg1;
            this.m_Type = arg2;
            this.m_Volume = arg3;
            this.m_Channel = null;
            this.m_Loop = arg4;
            return;
        }

        private var m_Type:Number=0;

        private var m_FadeEndTime:Number=0;

        private var m_SoundStop:Boolean=true;

        private var m_Sound:flash.media.Sound=null;

        private var m_FadeTime:Number=0;

        private var m_LoopCount:int=0;

        private var m_Loop:int=0;

        private var m_Timer:flash.utils.Timer=null;

        private var m_Channel:flash.media.SoundChannel=null;

        private var m_FadeStartVolume:Number=0;

        private var m_CurrentPos:Number=0;

        private var m_Volume:Number=1;

        private var m_FadeEndVolume:Number=0;
    }
}
