package Lib
{
    import flash.display.*;
    
    [Embed(source="ridhi_mc.swf", symbol = "ridhi_mc")]
    public dynamic class ridhi_mc extends flash.display.MovieClip
    {
        public function ridhi_mc()
        {
            super();
            addFrameScript(0, this.frame1);
            return;
        }

        internal function frame1():*
        {
            stop();
            return;
        }

        public var mabataki:flash.display.MovieClip;
    }
}
