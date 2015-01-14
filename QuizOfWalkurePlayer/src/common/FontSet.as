package common 
{
    import flash.text.*;
    
    public class FontSet extends Object
    {
        public function FontSet()
        {
            super();
            flash.text.Font.registerFont(this._engfont);
            flash.text.Font.registerFont(this._engfontb);
            flash.text.Font.registerFont(this._migmix2p);
            return;
        }

        public function SetEnFont(arg1:flash.text.TextField, arg2:Number):void
        {
            arg1.defaultTextFormat = new flash.text.TextFormat(EN_FONT_NAME, arg2);
            arg1.embedFonts = true;
            arg1.antiAliasType = flash.text.AntiAliasType.ADVANCED;
            return;
        }

        public function SetJpFont(arg1:flash.text.TextField, arg2:Number):void
        {
            arg1.defaultTextFormat = new flash.text.TextFormat(JP_FONT_NAME, arg2);
            arg1.embedFonts = true;
            arg1.antiAliasType = flash.text.AntiAliasType.ADVANCED;
            return;
        }

        public const _engfontb:Class=common.FontSet__engfontb;

        public const _engfont:Class=common.FontSet__engfont;

        public const _migmix2p:Class=common.FontSet__migmix2p;

        public static const JP_FONT_NAME:String="migmix2p";

        public static const EN_FONT_NAME:String="engfontb";
    }
}
