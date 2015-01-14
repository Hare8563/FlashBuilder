package common 
{
    import flash.net.*;
    import game.*;
    
    public class LocalReceive extends Object
    {
        public function LocalReceive()
        {
            var loc1:*;
            super();
            this.m_Gm = game.GameManager.getInstance();
            this.m_Connect = new flash.net.LocalConnection();
            this.m_Connect.client = this;
            try 
            {
                this.m_Connect.connect(common.Conf.CONNECTION_NAME);
            }
            catch (error:ArgumentError)
            {
            };
            return;
        }

        public function ErrorDialog():void
        {
            this.m_Gm.OpenDialog(common.Conf.DIALOG_TEXT_ERROR, common.Conf.DIALOG_WINDOW_CONNECT_ERROR, common.DynamicEvent.DIALOG_MODE_STOP);
            return;
        }

        private var m_Gm:game.GameManager;

        private var m_Connect:flash.net.LocalConnection;
    }
}
