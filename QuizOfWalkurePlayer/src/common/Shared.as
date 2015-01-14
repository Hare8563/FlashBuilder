package common 
{
    import flash.net.*;
    import game.*;
    
    public class Shared extends Object
    {
        public function Shared()
        {
            super();
            this.m_Gm = game.GameManager.getInstance();
            this.m_Sound = this.m_Gm.GetSoundManager();
            this.m_So = flash.net.SharedObject.getLocal(common.Conf.SAVE_FILE_NAME);
            return;
        }

        public function Save():void
        {
            var str:String;
            var obj:Object;

            var loc1:*;
            obj = null;
            str = null;
            if (this.m_So) 
            {
                obj = this.m_So.data;
                obj.bgm_volume = this.m_Sound.GetVolume(common.SoundConst.SOUND_TYPE_BGM);
                obj.se_volume = this.m_Sound.GetVolume(common.SoundConst.SOUND_TYPE_SE);
                obj.voice_volume = this.m_Sound.GetVolume(common.SoundConst.SOUND_TYPE_VOICE);
                obj.sort_id = this.m_Gm.SortID;
                try 
                {
                    str = this.m_So.flush();
                    loc2 = str;
                    switch (loc2) 
                    {
                        case flash.net.SharedObjectFlushStatus.FLUSHED:
                        {
                            common.Debug.Log("SharedObject Save Complete");
                            break;
                        }
                        case flash.net.SharedObjectFlushStatus.PENDING:
                        {
                            common.Debug.Log("Put the hard disk write requests to the user.");
                            break;
                        }
                    }
                }
                catch (e:Error)
                {
                    common.Debug.Log("Failed to write.");
                }
            }
            return;
        }

        public function Load():void
        {
            var loc1:*=null;
            if (this.m_So) 
            {
                loc1 = this.m_So.data;
                if (loc1.bgm_volume != null) 
                {
                    this.m_Sound.SetVolume(loc1.bgm_volume, common.SoundConst.SOUND_TYPE_BGM);
                }
                if (loc1.se_volume != null) 
                {
                    this.m_Sound.SetVolume(loc1.se_volume, common.SoundConst.SOUND_TYPE_SE);
                    this.m_Sound.SetVolume(loc1.se_volume, common.SoundConst.SOUND_TYPE_JINGLE);
                }
                if (loc1.bgm_volume != null) 
                {
                    this.m_Sound.SetVolume(loc1.voice_volume, common.SoundConst.SOUND_TYPE_VOICE);
                }
                if (loc1.sort_id != null) 
                {
                    this.m_Gm.SortID = loc1.sort_id;
                }
            }
            return;
        }

        private var m_Gm:game.GameManager;

        private var m_Sound:common.SoundManager;

        private var m_So:flash.net.SharedObject;
    }
}
