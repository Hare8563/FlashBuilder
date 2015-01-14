package net 
{
    import common.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.system.*;
    import game.*;
    
    public class ResouceLoader extends flash.display.MovieClip
    {
        public function Release():void
        {
            this.LoaderUnload();
            this.m_LoaderInfo.removeEventListener(flash.events.Event.COMPLETE, this.LoadComplete);
            this.m_LoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.LoadError);
            this.m_LoaderInfo.removeEventListener(flash.events.ProgressEvent.PROGRESS, this.LoaderInfoProgress);
            this.m_Loader = null;
            this.m_Bitmap = null;
            return;
        }

        public function IsLoad():Boolean
        {
            return this.m_Percent == 1;
        }

        public function LoadStart(arg1:String=""):void
        {
            var loc1:*=null;
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
            this.m_FileType = this.SetFileType(this.m_FileName);
            if (this.m_FileType == "") 
            {
                Error(2);
                return;
            }
            this.LoaderUnload();
            if (this.m_Cache) 
            {
                loc1 = game.GameManager.getInstance();
                this.m_Bitmap = loc1.GetImageCache(this.m_FileName);
                if (this.m_Bitmap != null) 
                {
                    this.m_Bitmap.smoothing = true;
                    this.addChild(this.m_Bitmap);
                    this.m_Width = this.m_Bitmap.width;
                    this.m_Height = this.m_Bitmap.height;
                    this.LoadSuccess();
                    return;
                }
            }
            this.m_Loader.load(new flash.net.URLRequest(this.m_FileName));
            this.m_Percent = 0;
            common.Debug.Log("Resouce Load Start:" + this.m_FileName);
            return;
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

        public function DrawBitmap(arg1:flash.display.BitmapData):void
        {
            if (this.m_FileType == "swf" || !this.IsLoad()) 
            {
                return;
            }
            arg1.draw(this.m_Loader);
            return;
        }

        private function SetFileType(arg1:String):String
        {
            if (arg1.indexOf(".jpg") > -1 || arg1.indexOf(".jpeg") > -1) 
            {
                return "jpg";
            }
            if (arg1.indexOf(".gif") > -1) 
            {
                return "gif";
            }
            if (arg1.indexOf(".png") > -1) 
            {
                return "png";
            }
            if (arg1.indexOf(".swf") > -1) 
            {
                return "swf";
            }
            return "";
        }

        public function set ID(arg1:int):void
        {
            this.m_ID = arg1;
            return;
        }

        public function GetLinkageBitmap(arg1:String):flash.display.Bitmap
        {
            var domain:flash.system.ApplicationDomain;
            var linkage:String;
            var bitmapdata:flash.display.BitmapData;
            var newClass:Class;

            var loc1:*;
            domain = null;
            newClass = null;
            bitmapdata = null;
            linkage = arg1;
            if (this.m_FileType != "swf") 
            {
                return null;
            }
            if (!this.IsLoad()) 
            {
                return null;
            }
            try 
            {
                domain = this.m_LoaderInfo.applicationDomain;
                newClass = domain.getDefinition(linkage) as Class;
                bitmapdata = new newClass(0, 0);
                return new flash.display.Bitmap(bitmapdata);
            }
            catch (e:Error)
            {
                common.Debug.Log("No Likage:" + linkage);
            }
            return null;
        }

        public function GetLinkageSound(arg1:String):flash.media.Sound
        {
            var domain:flash.system.ApplicationDomain;
            var linkage:String;
            var newClass:Class;

            var loc1:*;
            domain = null;
            newClass = null;
            linkage = arg1;
            if (this.m_FileType != "swf") 
            {
                return null;
            }
            if (!this.IsLoad()) 
            {
                return null;
            }
            try 
            {
                domain = this.m_LoaderInfo.applicationDomain;
                newClass = domain.getDefinition(linkage) as Class;
                return new newClass();
            }
            catch (e:Error)
            {
                common.Debug.Log("No Linkage：" + linkage);
            }
            return null;
        }

        private function LoadError(arg1:flash.events.Event):void
        {
            common.Debug.Log("Resouce Load Error：" + this.m_FileName);
            this.m_Percent = 1;
            this.ErrorRet(common.Conf.ERROR_RESOUCE_LOAD);
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

        public function Progress(arg1:Boolean):void
        {
            this.m_Progress = arg1;
            return;
        }

        public function get ID():int
        {
            return this.m_ID;
        }

        public function ResouceLoader(arg1:String, arg2:Function=null, arg3:Boolean=false, arg4:Boolean=true)
        {
            super();
            this.m_FileName = arg1;
            this.m_CallBack = arg2;
            this.m_Cache = arg3;
            this.m_FileType = this.SetFileType(this.m_FileName);
            if (this.m_FileType == "") 
            {
                Error(2);
                return;
            }
            if (this.m_FileType == "swf") 
            {
                this.m_Cache = false;
            }
            this.m_Loader = new flash.display.Loader();
            this.m_LoaderInfo = this.m_Loader.contentLoaderInfo;
            this.m_LoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.LoadComplete);
            this.m_LoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.LoadError);
            this.m_LoaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS, this.LoaderInfoProgress);
            this.m_Percent = 0;
            this.m_Progress = false;
            if (arg4) 
            {
                this.addEventListener(flash.events.Event.ENTER_FRAME, this.AutoLoadStart);
            }
            return;
        }

        public function GetLinkageMovieClip(arg1:String):flash.display.MovieClip
        {
            var domain:flash.system.ApplicationDomain;
            var linkage:String;
            var newClass:Class;

            var loc1:*;
            domain = null;
            newClass = null;
            linkage = arg1;
            if (this.m_FileType != "swf") 
            {
                return null;
            }
            if (!this.IsLoad()) 
            {
                return null;
            }
            try 
            {
                domain = this.m_LoaderInfo.applicationDomain;
                newClass = domain.getDefinition(linkage) as Class;
                return new newClass();
            }
            catch (e:Error)
            {
                common.Debug.Log("No Likage:" + linkage);
            }
            return null;
        }

        public function LoaderUnload():void
        {
            if (!(this.m_Bitmap == null) && this.contains(this.m_Bitmap)) 
            {
                this.removeChild(this.m_Bitmap);
                this.m_Bitmap = null;
            }
            if (this.contains(this.m_Loader)) 
            {
                this.removeChild(this.m_Loader);
                this.m_Loader.unload();
            }
            return;
        }

        private function LoaderInfoProgress(arg1:flash.events.ProgressEvent):void
        {
            this.m_BytesTotal = arg1.bytesTotal;
            this.m_Bytes = arg1.bytesLoaded;
            this.m_Percent = this.m_Bytes / this.m_BytesTotal;
            if (this.m_Progress) 
            {
                game.GameManager.getInstance().ActivePercent("" + Math.floor(this.m_Percent * 100));
            }
            return;
        }

        private function AutoLoadStart(arg1:flash.events.Event):void
        {
            this.removeEventListener(flash.events.Event.ENTER_FRAME, this.AutoLoadStart);
            this.LoadStart(this.m_FileName);
            return;
        }

        private function LoadComplete(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            if (this.m_FileType != "swf") 
            {
                flash.display.Bitmap(arg1.target.content).smoothing = true;
                this.m_Width = flash.display.Bitmap(arg1.target.content).width;
                this.m_Height = flash.display.Bitmap(arg1.target.content).height;
            }
            else 
            {
                this.m_Width = arg1.target.content.width;
                this.m_Height = arg1.target.content.height;
                common.Debug.Log("SWFファイルのバージョン : " + this.m_LoaderInfo.swfVersion);
                common.Debug.Log("フレームレート : " + this.m_LoaderInfo.frameRate);
                common.Debug.Log("アクションスクリプトのバージョン : " + this.m_LoaderInfo.actionScriptVersion);
            }
            common.Debug.Log("Resouce Load Complete:" + this.m_FileName + " width:" + this.m_Width + " height:" + this.m_Height);
            this.addChild(this.m_Loader);
            if (this.m_Cache) 
            {
                loc1 = game.GameManager.getInstance();
                loc1.AddImageCache(this.m_FileName, this.m_Loader);
            }
            this.LoadSuccess();
            return;
        }

        public var m_Bytes:int;

        private var m_Loader:flash.display.Loader;

        private var m_FileType:String;

        public var m_BytesTotal:int;

        public var m_Progress:Boolean;

        private var m_FileName:String;

        private var m_ID:int;

        private var m_Bitmap:flash.display.Bitmap;

        private var m_Cache:Boolean;

        private var m_LoaderInfo:flash.display.LoaderInfo;

        public var m_Width:Number;

        private var m_CallBack:Function;

        public var m_Percent:Number;

        public var m_Height:Number;
    }
}
