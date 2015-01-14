package net 
{
    import common.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    
    public class SoundLoader extends flash.media.Sound
    {
        public function IsLoad():Boolean
        {
            return this.m_Percent == 1;
        }

        public function LoadStart(arg1:String=""):void
        {
            if (arg1 == "") 
            {
                if (this.IsLoad()) 
                {
                    this.LoadSuccess();
                    return;
                }
            }
            else 
            {
                if (this.IsLoad() && this.m_FileName == arg1) 
                {
                    this.LoadSuccess();
                    return;
                }
                this.m_FileName = arg1;
            }
            if (this.m_FileName.indexOf(".mp3") > -1) 
            {
                this.m_FileType = "mp3";
            }
            else 
            {
                Error(2);
                return;
            }
            this.load(new flash.net.URLRequest(this.m_FileName));
            this.m_Percent = 0;
            return;
        }

        public function IsErr():Boolean
        {
            return this.m_IsError;
        }

        private function ErrorRet(arg1:int):void
        {
            if (this.m_CallBack == null) 
            {
                return;
            }
            var loc1:*=new net.ConnectObject(arg1, common.Conf.ERROR_MESSAGE[arg1]);
            this.m_CallBack(loc1);
            return;
        }

        public function Release():void
        {
            this.removeEventListener(flash.events.Event.COMPLETE, this.LoadComplete);
            this.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.LoadError);
            this.removeEventListener(flash.events.ProgressEvent.PROGRESS, this.LoaderInfoProgress);
            return;
        }

        private function LoadError(arg1:flash.events.Event):void
        {
            this.m_Percent = 1;
            this.m_IsError = true;
            this.ErrorRet(common.Conf.ERROR_RESOUCE_LOAD);
            return;
        }

        private function LoadComplete(arg1:flash.events.Event):void
        {
            this.LoadSuccess();
            return;
        }

        private function LoadSuccess():void
        {
            this.m_Percent = 1;
            if (this.m_CallBack == null) 
            {
                return;
            }
            var loc1:*=new net.ConnectObject(0);
            this.m_CallBack(loc1);
            return;
        }

        private function LoaderInfoProgress(arg1:flash.events.ProgressEvent):void
        {
            this.m_BytesTotal = arg1.bytesTotal;
            this.m_Bytes = arg1.bytesLoaded;
            this.m_Percent = this.m_Bytes / this.m_BytesTotal;
            return;
        }

        public function SoundLoader(arg1:String, arg2:Function=null, arg3:Boolean=true)
        {
            super();
            this.m_FileName = arg1;
            this.m_CallBack = arg2;
            this.addEventListener(flash.events.Event.COMPLETE, this.LoadComplete);
            this.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.LoadError);
            this.addEventListener(flash.events.ProgressEvent.PROGRESS, this.LoaderInfoProgress);
            this.m_Percent = 0;
            this.m_IsError = false;
            if (arg3) 
            {
                this.LoadStart(this.m_FileName);
            }
            return;
        }

        private var m_CallBack:Function;

        private var m_FileName:String;

        public var m_Percent:Number;

        public var m_Width:Number;

        private var m_LoaderInfo:flash.display.LoaderInfo;

        public var m_Height:Number;

        public var m_IsError:Boolean;

        public var m_BytesTotal:int;

        private var m_FileType:String;

        public var m_Bytes:int;
    }
}
