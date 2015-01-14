package common 
{
    import flash.events.*;
    import flash.media.*;
    
    public class SoundManager extends flash.events.EventDispatcher
    {
        
        {
            TypeVolume = new Array(1, 0.4, 0.5, 0.5, 0.5);
        }

        public function SetVolume(arg1:Number, arg2:int=0):void
        {
            var loc1:*=NaN;
            var loc2:*=null;
            if (arg2 != 0) 
            {
                TypeVolume[arg2] = arg1;
                var loc3:*=0;
                var loc4:*=this.m_SoundList;
                for each (loc2 in loc4) 
                {
                    if (loc2.type != arg2) 
                    {
                        continue;
                    }
                    loc2.volume = loc2.volume;
                }
            }
            else 
            {
                this.m_MainVolume = arg1;
                loc1 = arg1;
                if (this.m_Mute) 
                {
                    loc1 = 0;
                }
                this.m_SoundMix = flash.media.SoundMixer.soundTransform;
                this.m_SoundMix.volume = loc1;
                flash.media.SoundMixer.soundTransform = this.m_SoundMix;
            }
            return;
        }

        public function Volume(arg1:String, arg2:Number):void
        {
            this.m_SoundList[arg1].volume = arg2;
            return;
        }

        public function MuteOn():void
        {
            this.m_Mute = true;
            this.SetVolume(this.m_MainVolume);
            return;
        }

        public function MuteOff():void
        {
            this.m_Mute = false;
            this.SetVolume(this.m_MainVolume);
            return;
        }

        public function GetVolume(arg1:int=0):Number
        {
            if (arg1 == 0) 
            {
                return this.m_MainVolume;
            }
            return TypeVolume[arg1];
        }

        public function Restart(arg1:String):void
        {
            this.m_SoundList[arg1].Restart();
            return;
        }

        public function IsFade(arg1:String):Boolean
        {
            return this.m_SoundList[arg1].IsFade();
        }

        public function Stop(arg1:String):void
        {
            this.m_SoundList[arg1].Stop();
            return;
        }

        public function FadeIn(arg1:String, arg2:Number=0.5):void
        {
            this.m_SoundList[arg1].FadeIn(arg2);
            return;
        }

        public function StopAll():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.m_SoundList;
            for (loc1 in loc3) 
            {
                this.m_SoundList[loc1].Stop();
            }
            return;
        }

        public function IsPlay(arg1:String):Boolean
        {
            if (!this.m_SoundList[arg1]) 
            {
                return false;
            }
            return this.m_SoundList[arg1].IsPlay();
        }

        private function Initialise():void
        {
            this.m_SoundList = new Object();
            this.m_MainVolume = 1;
            this.m_Mute = false;
            this.SetVolume(this.m_MainVolume);
            return;
        }

        public function Pause(arg1:String):void
        {
            this.m_SoundList[arg1].Pause();
            return;
        }

        public function Play(arg1:String):void
        {
            this.m_SoundList[arg1].Play();
            return;
        }

        public function FadeOut(arg1:String, arg2:Number=0.5, arg3:Boolean=true):void
        {
            this.m_SoundList[arg1].FadeOut(arg2, arg3);
            return;
        }

        public function AddSound(arg1:String, arg2:flash.media.Sound, arg3:int=0, arg4:Number=1, arg5:int=0):common.SoundObject
        {
            var loc1:*=new common.SoundObject(arg2, arg3, arg4, arg5);
            this.m_SoundList[arg1] = loc1;
            return loc1;
        }

        public function IsMute():Boolean
        {
            return this.m_Mute;
        }

        public function SoundManager()
        {
            super();
            common.Debug.Log("SoundManager Initialise");
            this.Initialise();
            return;
        }

        private var m_SoundList:Object;

        private var m_MainVolume:Number;

        private var m_BGMChannel:int;

        private var m_Mute:Boolean;

        private var m_SoundMix:flash.media.SoundTransform;

        public static var TypeVolume:Array;
    }
}
