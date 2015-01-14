package common 
{
    import flash.display.*;
    
    public class Debug extends Object
    {
        public function Debug()
        {
            super();
            return;
        }

        public static function Log(arg1:String):void
        {
            return;
        }

        public static function Show():void
        {
            mc.visible = true;
            return;
        }

        public static function Hide():void
        {
            mc.visible = false;
            return;
        }

        
        /*{
            mc = new debug_window();
            debugText = "";
            textAry = new Array();
        }*/

        public static var debugText:String="";

        public static var mc:flash.display.MovieClip;

        public static var textAry:Array;
    }
}
