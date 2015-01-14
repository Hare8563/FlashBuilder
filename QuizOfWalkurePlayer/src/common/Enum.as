package common 
{
    public final class Enum extends Object
    {
        public function Enum()
        {
            super();
            if (inited) 
            {
                return;
            }
            inited = true;
            return;
        }

        public static function next(arg1:Number=NaN):int
        {
            if (!isNaN(arg1)) 
            {
                _next = arg1 >> 0;
                return _next;
            }
            var loc1:*;
            var loc2:*;
            return ++_next;
        }

        
        {
            _next = 0;
            inited = false;
        }

        private static var _next:int=0;

        private static var inited:Boolean=false;
    }
}
