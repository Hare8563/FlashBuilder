package common 
{
    import flash.events.*;
    import flash.net.*;
    
    public class LocalSend extends Object
    {
        public function LocalSend()
        {
            super();
            this.m_Connect = new flash.net.LocalConnection();
            this.m_Connect.addEventListener(flash.events.StatusEvent.STATUS, this.SendStatusFunc);
            this.m_Connect.send(common.Conf.CONNECTION_NAME, "ErrorDialog");
            return;
        }

        public function SendStatusFunc(arg1:flash.events.StatusEvent):void
        {
            common.Debug.Log(arg1.toString());
            return;
        }

        private var m_Connect:flash.net.LocalConnection;
    }
}
