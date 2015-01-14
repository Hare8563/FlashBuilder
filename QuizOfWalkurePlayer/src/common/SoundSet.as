package common 
{
	import jingle.*;
	import BGM.*;
	import SE.*;
    public class SoundSet extends Object
    {
        public function SoundSet()
        {
            super();
            return;
        }

        public function Add(arg1:common.SoundManager):void
        {
            arg1.AddSound(common.SoundConst.BGM01_MYPAGE, new BGM_01(), common.SoundConst.SOUND_TYPE_BGM, common.SoundConst.SOUND_VOLUME, common.SoundConst.SOUND_LOOP);
            arg1.AddSound(common.SoundConst.BGM02_CARD, new BGM_02(), common.SoundConst.SOUND_TYPE_BGM, common.SoundConst.SOUND_VOLUME, common.SoundConst.SOUND_LOOP);
            arg1.AddSound(common.SoundConst.BGM03_QUEST, new BGM_03(), common.SoundConst.SOUND_TYPE_BGM, common.SoundConst.SOUND_VOLUME, common.SoundConst.SOUND_LOOP);
            arg1.AddSound(common.SoundConst.BGM04_BATTLE, new BGM_04(), common.SoundConst.SOUND_TYPE_BGM, common.SoundConst.SOUND_VOLUME, common.SoundConst.SOUND_LOOP);
            arg1.AddSound(common.SoundConst.BGM05_BOSS, new BGM_05(), common.SoundConst.SOUND_TYPE_BGM, common.SoundConst.SOUND_VOLUME, common.SoundConst.SOUND_LOOP);
            arg1.AddSound(common.SoundConst.BGM06_CHANCE, new BGM_06(), common.SoundConst.SOUND_TYPE_BGM, common.SoundConst.SOUND_VOLUME, common.SoundConst.SOUND_LOOP);
            arg1.AddSound(common.SoundConst.BGM07_LEAGUE, new BGM_07(), common.SoundConst.SOUND_TYPE_BGM, common.SoundConst.SOUND_VOLUME, common.SoundConst.SOUND_LOOP);
            arg1.AddSound(common.SoundConst.JINGLE01_GAMEOVER, new Jingle_01(), common.SoundConst.SOUND_TYPE_JINGLE);
            arg1.AddSound(common.SoundConst.JINGLE02_CLEAR, new Jingle_02(), common.SoundConst.SOUND_TYPE_JINGLE);
            arg1.AddSound(common.SoundConst.JINGLE03_RESULT, new Jingle_03(), common.SoundConst.SOUND_TYPE_JINGLE);
            arg1.AddSound(common.SoundConst.JINGLE04_FRIEND, new Jingle_04(), common.SoundConst.SOUND_TYPE_JINGLE);
            arg1.AddSound(common.SoundConst.JINGLE05_CARD, new Jingle_05(), common.SoundConst.SOUND_TYPE_JINGLE);
            arg1.AddSound(common.SoundConst.SE01_ONCURSOR, new SE_01(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE02_OK, new SE_02(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE03_CANCEL, new SE_03(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE04_HARISEN, new SE_04(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE05_LEVELUP, new SE_05(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE06_GENRE, new SE_06(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE07_SKILL, new SE_07(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE08_COLLECT, new SE_08(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE09_INCORRECT, new SE_09(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE10_HIT, new SE_10(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE11_DAMAGE, new SE_11(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE12_KIRAKIRA, new SE_12(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE13_CHARGE, new SE_13(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE14_SHOOT, new SE_14(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE15_BACHI, new SE_15(), common.SoundConst.SOUND_TYPE_SE);
            arg1.AddSound(common.SoundConst.SE16_EVENTOK, new SE_16(), common.SoundConst.SOUND_TYPE_SE);
            return;
        }
    }
}
