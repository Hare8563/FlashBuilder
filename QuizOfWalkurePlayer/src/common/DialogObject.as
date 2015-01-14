package common 
{
    public class DialogObject extends Object
    {
        public function DialogObject(arg1:String="", arg2:String="", arg3:int=0)
        {
            super();
            this.title = arg1;
            this.message = arg2;
            this.buttonMode = arg3;
            this.button = 0;
            this.number = 0;
            return;
        }

        public var button:int;

        public var buttonMode:int;

        public var message:String;

        public var title:String;

        public var number:int;
    }
}
