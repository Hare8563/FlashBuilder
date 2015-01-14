package 
{
    import flash.display.*;
    import flash.text.*;
    
    [Embed(source="common_dialog.swf", symbol = "common_dialog")]
    public dynamic class common_dialog extends flash.display.MovieClip
    {
        public function common_dialog()
        {
            super();
            addFrameScript(0, this.frame1, 7, this.frame8, 13, this.frame14, 19, this.frame20);
            return;
        }

        internal function frame1():*
        {
            this.window_name.visible = false;
            this.message.visible = false;
            return;
        }

        internal function frame8():*
        {
            stop();
            this.window_name.visible = true;
            this.message.visible = true;
            return;
        }

        internal function frame14():*
        {
            this.window_name.visible = false;
            this.message.visible = false;
            return;
        }

        internal function frame20():*
        {
            this.visible = false;
            stop();
            if (this.callback != null) 
            {
                this.callback();
            }
            return;
        }

        public var btn_close:flash.display.MovieClip;

        public var btn_no:flash.display.MovieClip;

        public var window_name:flash.text.TextField;

        public var message:flash.text.TextField;

        public var btn_retry:flash.display.MovieClip;

        public var btn_yes:flash.display.MovieClip;

        public var callback:Function;
    }
}
