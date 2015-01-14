package net 
{
    import com.adobe.serialization.json.*;
    import common.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import game.*;
    
    public class ServerConnect extends Object
    {
        public function ServerConnect(arg1:String, arg2:Function=null, arg3:Object=null)
        {
            super();
            this.m_Gm = game.GameManager.getInstance();
            this.m_IsActive = this.m_Gm.IsActive;
            this.m_StartTime = flash.utils.getTimer();
            common.Debug.Log("Sever Connect : " + arg1);
            this.m_Url = arg1;
            this.m_CallBack = arg2;
            this.m_Param = new Object();
            if (arg3 != null) 
            {
                this.m_Param = arg3;
            }
            this.m_Param.token = this.m_Gm.GetInfo();
            this.load();
            return;
        }

        private function load():void
        {
            var loc2:*=null;
            this.m_Loader = new flash.net.URLLoader();
            this.m_Loader.dataFormat = flash.net.URLLoaderDataFormat.TEXT;
            this.m_Loader.addEventListener(flash.events.Event.COMPLETE, this.LoadComplete);
            this.m_Loader.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.LoadIOError);
            this.m_Loader.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.SecurityError);
            var loc1:*=new flash.net.URLRequest();
            loc1.url = this.m_Url;
            if (this.m_Param != null) 
            {
                loc2 = new flash.net.URLVariables();
                loc2.data = com.adobe.serialization.json.JSON.encode(this.m_Param);
                common.Debug.Log("POST JSON DATA : " + loc2.data);
                loc1.method = flash.net.URLRequestMethod.POST;
                loc1.data = loc2;
            }
            this.m_Loader.load(loc1);
            return;
        }

        public function Release():void
        {
            this.m_Loader.removeEventListener(flash.events.Event.COMPLETE, this.LoadComplete);
            this.m_Loader.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.LoadIOError);
            this.m_Loader.removeEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, this.SecurityError);
            this.m_Loader = null;
            return;
        }

        private function SecurityError(arg1:flash.events.SecurityErrorEvent):void
        {
            common.Debug.Log("[TIME " + flash.utils.getTimer() - this.m_StartTime + "] Security Error：" + this.m_Url);
            this.ServerError(common.Conf.ERROR_SECURITY);
            return;
        }

        public function DialogConnectFunc(arg1:common.DynamicEvent=null):void
        {
            this.m_Gm.IsActive = this.m_IsActive;
            this.load();
            return;
        }

        private function ServerError(arg1:int):void
        {
            this.m_Gm.ConnectError();
            return;
        }

        private function LoadIOError(arg1:flash.events.IOErrorEvent):void
        {
            common.Debug.Log("[TIME " + flash.utils.getTimer() - this.m_StartTime + "] Connect Error：" + this.m_Url);
            this.ServerError(common.Conf.ERROR_TEXT_LOAD);
            return;
        }

        private function LoadComplete(arg1:flash.events.Event):void
        {
            common.Debug.Log("[TIME " + flash.utils.getTimer() - this.m_StartTime + "] Connect Complete:" + this.m_Url);
            var loc1:*=new net.ConnectObject(0);
            loc1.result = arg1.target.data;
            if (this.m_CallBack != null) 
            {
                this.m_CallBack(loc1);
            }
            return;
        }

        private var m_IsActive:Boolean;

        private var m_Loader:flash.net.URLLoader;

        private var m_StartTime:Number;

        private var m_CallBack:Function;

        private var m_Gm:game.GameManager;

        private var m_Param:Object;

        private var m_Url:String;
    }
}
