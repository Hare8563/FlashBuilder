package net 
{
    public class ConnectObject extends Object
    {
        public function ConnectObject(arg1:int, arg2:String="")
        {
            super();
            this.error = arg1;
            this.message = arg2;
            this.result = "";
            this.id = 0;
            return;
        }

        public var message:String;

        public var error:int;

        public var id:int;

        public var result:String;
    }
}
