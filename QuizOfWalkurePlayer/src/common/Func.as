package common 
{
    import flash.display.*;
    import flash.utils.*;
    
    public class Func extends Object
    {
        public function Func()
        {
            super();
            return;
        }

        public static function Mc2Btn(arg1:int, arg2:flash.display.MovieClip):flash.display.MovieClip
        {
            arg2.id = arg1;
            arg2.mouseChildren = false;
            arg2.buttonMode = true;
            arg2.useHandCursor = true;
            arg2.tabEnabled = false;
            return arg2;
        }

        public static function toString(arg1:Object):String
        {
            var loc2:*=null;
            var loc1:*="{";
            var loc3:*=0;
            var loc4:*=arg1;
            for (loc2 in loc4) 
            {
                loc1 = loc1 + loc2 + ":";
                var loc5:*=flash.utils.getQualifiedClassName(arg1[loc2]);
                switch (loc5) 
                {
                    case "Array":
                    {
                        loc1 = loc1 + arg1[loc2];
                        break;
                    }
                    case "Boolean":
                    {
                        loc1 = loc1 + arg1[loc2];
                        break;
                    }
                    case "Number":
                    {
                        loc1 = loc1 + arg1[loc2];
                        break;
                    }
                    case "Date":
                    {
                        loc1 = loc1 + arg1[loc2];
                        break;
                    }
                    case "uint":
                    {
                        loc1 = loc1 + arg1[loc2];
                        break;
                    }
                    case "String":
                    {
                        loc1 = loc1 + "\"" + arg1[loc2] + "\"";
                        break;
                    }
                    case "Object":
                    {
                        loc1 = loc1 + toString(arg1[loc2]).replace(new RegExp("\\n", "g"), "\n ");
                    }
                }
                loc1 = loc1 + ",\n ";
            }
            if (loc2) 
            {
                loc1 = loc1.slice(0, -2);
            }
            loc1 = loc1 + "\n}";
            return loc1;
        }

        public static function dist(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*=arg1 - arg3;
            var loc2:*=arg2 - arg4;
            return Math.sqrt(loc1 * loc1 + loc2 * loc2);
        }

        public static function sinInt(arg1:Number):int
        {
            return Math.floor(sin(arg1));
        }

        public static function sin(arg1:Number):Number
        {
            return Math.sin(Deg2Rad(arg1));
        }

        public static function Deg2Rad(arg1:Number):Number
        {
            return arg1 / 180 * Math.PI;
        }

        public static function CRLF2LF(arg1:String):String
        {
            var loc1:*=new RegExp("\\r\\n", "g");
            arg1 = arg1.replace(loc1, "\n");
            loc1 = new RegExp("\\r", "g");
            arg1 = arg1.replace(loc1, "");
            return arg1;
        }

        public static function randomInt(arg1:int):int
        {
            return int(Math.random() * arg1);
        }

        public static function cos(arg1:Number):Number
        {
            return Math.cos(Deg2Rad(arg1));
        }

        public static function cosInt(arg1:Number):int
        {
            return Math.floor(cos(arg1));
        }
    }
}
