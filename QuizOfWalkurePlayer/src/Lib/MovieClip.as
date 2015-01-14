package Lib
{
	import mx.core.UIComponent;
	import spark.components.*;
	import flash.display.*;
	public class MovieClip extends UIComponent
	{
		private var child:Sprite;
		private var assetImage:Image;
		
		public function MovieClip():void{
			
			child = new Sprite();
			child.buttonMode = true;
			child.graphics.beginFill(0xCCFF00);
			child.graphics.drawRect(0, 0, 100, 100);
			addChild(child);
		}
			
	}
}