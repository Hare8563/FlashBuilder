// ActionScript file
package Koigasaki
{
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;
	
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.core.IMXMLObject;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	
	import a24.tween.Tween24;
	import a24.tween.events.Tween24Event;
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.TextShortcuts;
	
	import flashx.textLayout.formats.Float;

	TextShortcuts.init();

	public class MainLoader implements IMXMLObject
	{
		private var view:KoigasakiLoader;
		private var closeFlag:Boolean = false;
		private var previousClose:Boolean = false;
		private var ScenarioIndex:int = 0;
		private var tween:Tween24 = null;
		private var mv_bg:MovieClip;
		
		public var ScenarioObj:Object;
		public var Mp3Obj:Object={};
		public var MovieObj:Object={};
		public var ImgObj:Object={};
		public var script:Object = null;
		public var currentSoundChannel:SoundChannel;
		public var currentBgmChannel:SoundChannel;
		public static const ACTION_COMPLETE:String = "complete_action";
		
		public function initialized(document:Object, id:String):void
		{
			view = document as KoigasakiLoader;
		}
		
		public function action():void{
			this.tween = null;
			this.script = ScenarioObj[ScenarioIndex];
			
			if(script.hasOwnProperty("end")){
				NativeApplication.nativeApplication.exit();	
			}
			else if(script.hasOwnProperty("bgm")){
				bgmAction(this.script);
			}
			else if(script.hasOwnProperty("effect")){
				//vibe
				//bow
				//blink
			}
			else if(script.hasOwnProperty("bg")){
				bgAction(this.script);
			}
			else if(script.hasOwnProperty("char")){
				charAction(this.script);
			}
			else if(script.hasOwnProperty("wait")){
				waitAction(this.script);
			}
			else if(ScenarioObj[ScenarioIndex].hasOwnProperty("movie")){
				movieAction(this.script);
			}
			else if(ScenarioObj[ScenarioIndex].hasOwnProperty("vo")){
				voiceAction(this.script);
			}
			else if(ScenarioObj[ScenarioIndex].hasOwnProperty("text")){
				textAction(this.script);
			}
			else{
				actionComplete();
			}
		}
		
	private function waitAction(param:Object):void{
		var tweenList:*;
		try{
			if (param.wait > 0){
				this.tween = Tween24.wait(param.wait / 1000);
				this.tween.addEventListener(Event.COMPLETE, this.onWaitComplete);
				
				setMouseEventEnable(false);
				this.tween.play();
			}
			else if (param.wait == 0){
				view.msArea.text = "";
				this.actionComplete();
			}
			else if (param.wait == -1 || param.wait == -2){
//				if (param == -2){
//					if (view.msArea.visible == true){
//						Tween24.serial(Tween24.tween(this.mv_message.mv_messageWindow.mv_arrow, 0, Tween24.ease.QuadOut).fadeOut(), Tween24.tween(this.mv_message.mv_messageWindow.mv_arrow, 0, Tween24.ease.QuadOut).fadeIn(), Tween24.gotoAndPlay(1, this.mv_message.mv_messageWindow.mv_arrow)).play();
//					}
//				}
				this.tween = Tween24.serial(tweenList, Tween24.wait(86400000));
				this.tween.addEventListener(Event.COMPLETE, this.onWaitComplete);
				this.tween.play();
			}
		}
		catch (e:Error){
			actionComplete();
		}
		return;
	}
	private function onWaitComplete(event:Event) : void {
		if (this.tween.hasEventListener(Event.COMPLETE)){
			this.tween.removeEventListener(Event.COMPLETE, this.onWaitComplete);
		}
		if (this.script.wait == -2){
			view.msArea.text ="";
		}
		setMouseEventEnable(true);
		this.actionComplete();
		return;
	}
	public function setMouseEventEnable(param1:Boolean) : void {
		var _loc_2:* = param1;
		view.mouseEnabled = param1;
		view.mouseChildren = _loc_2;
		return;
	}	
	private function bgmAction(param:Object):void{
		var bgmData:Object = ScenarioObj[ScenarioIndex].bgm;
		if(bgmData.hasOwnProperty("src")){
			var sound:Sound = Sound(Mp3Obj[bgmData.src]);
			currentBgmChannel = sound.play();
			var func:Function;
			currentBgmChannel.addEventListener(Event.SOUND_COMPLETE, func = function (e:Event):void{
				e.currentTarget.removeEventListener(Event.SOUND_COMPLETE, func);
				currentBgmChannel = sound.play();
			});
		}
		if(bgmData.hasOwnProperty("action")){
			if(bgmData.action == "finish"){
				currentBgmChannel.stop();
			}
		}
		this.actionComplete();
		return;
	}
	private function charAction(param:Object):void{
		var charProp:Object = param.char;
		if(charProp.hasOwnProperty("action")){
			if(charProp.action == "finish"){
				view.Character.source = "";
			}
		}
		if(charProp.hasOwnProperty("src")){
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.allowLoadBytesCodeExecution = true;
			view.Character.loaderContext = loaderContext;
			
			if(view.Character.source == MovieObj[charProp.src]){
				var mvClip:MovieClip= view.Character.content as MovieClip;
				
				if(charProp.hasOwnProperty("eye")){
					var eye:MovieClip = mvClip.mv_char.mv_eye as MovieClip;
					eye.addEventListener(Event.EXIT_FRAME, function(e:Event):void{eye.stop();});
					eye.gotoAndPlay(charProp.eye + 1);
				}
				if(charProp.hasOwnProperty("lip")){
					var lip:MovieClip = mvClip.mv_char.mv_lip as MovieClip;
					lip.addEventListener(Event.EXIT_FRAME, function(e:Event):void{lip.stop();});
					lip.gotoAndPlay(charProp.lip + 1);	
				}
			}else{
				view.Character.source = MovieObj[charProp.src];
			}
			view.Character.addEventListener(Event.COMPLETE, function(e:Event):void{
				var mvClip:MovieClip= e.target.content as MovieClip;
				
				if(charProp.hasOwnProperty("eye")){
					var eye:MovieClip = mvClip.mv_char.mv_eye as MovieClip;
					eye.addEventListener(Event.EXIT_FRAME, function(e:Event):void{eye.stop();});
					eye.gotoAndPlay(charProp.eye + 1);
				}
				if(charProp.hasOwnProperty("lip")){
					var lip:MovieClip = mvClip.mv_char.mv_lip as MovieClip;
					lip.addEventListener(Event.EXIT_FRAME, function(e:Event):void{lip.stop();});
					lip.gotoAndPlay(charProp.lip + 1);	
				}
				
			});	
		}
		this.actionComplete();
		return;
	}
	private function movieAction(param:Object):void{
		var loaderContext:LoaderContext = new LoaderContext();
		
		loaderContext.allowLoadBytesCodeExecution = true;
		view.mainContents.loaderContext = loaderContext;
		view.mainContents.source = MovieObj[ScenarioObj[ScenarioIndex].movie.src];
		var rootMc:MovieClip;
		
		if(!ScenarioObj[ScenarioIndex].movie.hasOwnProperty("action")){
			//もし、loopアクションが入ってない場合
			
			view.mainContents.addEventListener(Event.COMPLETE,
				function(e:Event):void
				{
					rootMc = view.mainContents.content as MovieClip;
					rootMc.addEventListener(Event.ENTER_FRAME,
						function(e:Event):void
						{
							if(rootMc.currentFrame == rootMc.totalFrames) rootMc.stop();
						});
				});
		}
		else if(ScenarioObj[ScenarioIndex].movie.action == "loop"){
			view.mainContents.addEventListener(Event.COMPLETE, 
				function(e:Event):void
				{
					rootMc = view.mainContents.content as MovieClip;
					rootMc.addEventListener(Event.ENTER_FRAME,
						function(e:Event):void
						{
							if(rootMc.currentFrame == rootMc.totalFrames) rootMc.gotoAndPlay(1);
						});
				});
		}
		else if(ScenarioObj[ScenarioIndex].movie.action == "finish"){
			view.mainContents.source = "";
		}
		this.actionComplete();
		return;
	}
	private function voiceAction(param:Object):void{
		if(currentSoundChannel != null) currentSoundChannel.stop();
		var voData:Object = ScenarioObj[ScenarioIndex].vo;
		if(Mp3Obj.hasOwnProperty(voData.src)){
			currentSoundChannel = Sound(Mp3Obj[voData.src]).play();
		}
		this.actionComplete();
		return;
	}
	
	private function textAction(param:Object):void{
		var name:String = ScenarioObj[ScenarioIndex].text.name;
		var serif:String = ScenarioObj[ScenarioIndex].text.serif;
		if(name != null){
			name = name.replace(/{s1}/, "花山");
			name = name.replace(/{n1}/,"晴男");
		}
		if(serif != null){
			serif = serif.replace(/{s1}/g, "花山");
			serif = serif.replace(/{n1}/g,"晴男");
		}
		
		view.msArea.text = "";
		view.nameArea.text = name;
		var t:Number = serif.length * 0.05;
		Tweener.addTween(view.msArea, {time:t, _text:serif, transition: "linear"});
		this.actionComplete();
		return;
	}

private function bgAction(param:Object):void{

	var mc:MovieClip;
	var bmpData:BitmapData = new BitmapData(view.width, view.height);
	var tweenList:Array;
	var current_bg:Bitmap;
	var loader:Loader = new Loader();
	if(param.bg.hasOwnProperty("src")){
		loader.contentLoaderInfo.addEventListener(Event.INIT, function(e:Event):void {
			bmpData.draw(loader);
		});
		loader.loadBytes(ImgObj[param.bg.src]);
		current_bg = new Bitmap(bmpData);
	}
	view.uicomp.addChild(new Bitmap(bmpData));
	this.actionComplete();
	return;
//	
//		if(param.bg.hasOwnProperty("type")){
//			if (param.bg["type"] == null){
//				var width:Number = view.width/10;
//				var height:Number = view.height;
//				
//				var i:int= 0;
//				var mask:MovieClip;
//				var s:Shape;
//				var mc_mask:MovieClip= new MovieClip();
//				var targets:Array=new Array();
//				while (i < 10){	
//					mask = new MovieClip();
//					s = new Shape();
//					s.graphics.beginFill(0);
//					s.graphics.drawRect(0, 0, width, height);
//					s.graphics.endFill();
//					mask.addChild(s);
//					mask.x = i * width;
//					mc_mask.addChild(mask);
//					targets.push(mask);
//					i = (i + 1);
//				}
//				if (img != null){
//					view.background.source = img.source;
//					view.effect.addChild(mc_mask);
//					view.effect.mask = mc_mask;		
//				}
//				this.tween = Tween24.lag(0.1, 
//					Tween24.tween(targets, 0.5, Tween24.ease.QuadOut).$x(width).width(0), 
//					Tween24.tween(targets, 0.5, Tween24.ease.ExpoInOut).fadeOut());
//				this.tween.play();
//				return;
//			}
//			else if (param.bg["type"] == "f" || param.bg["type"] == "q"){
//				tweenList=new Array();
//				if (view.background.source != null){
//					this.tween = Tween24.serial(Tween24.tween(view.background, 0, Tween24.ease.QuadOut).fadeOut());
//					this.tween.addEventListener(Tween24Event.COMPLETE, function(e:Event):void{
//						view.background.source = img.source;
//						Tween24.tween(view.background, 0, Tween24.ease.QuadInOut).fadeIn().play();
//						return;
//					});
//					this.tween.play();
//				}	
//			}
//		}
//		else{
//			return;
//		}
//		
		return;
	}
	
	private function onBgBlindComplete(event:Event) : void {
		this.tween.removeEventListener(Event.COMPLETE, this.onBgBlindComplete);
		if (this.mv_bg.numChildren > 1){
			this.mv_bg.removeChildAt((this.mv_bg.numChildren - 1));
		}
		this.actionComplete();
		return;
	}
	
	private function actionComplete():void{
		this.ScenarioIndex++;
		view.dispatchEvent(new Event(ACTION_COMPLETE));
		return;
	}
	
	
		public function Exit_clickHandler(event: MouseEvent):void
		{
			event.preventDefault();
			Alert.show("終了してよろしいですか?", "警告", Alert.OK | Alert.CANCEL, 
				null, alertCloseHandler);
		}
		
		private function alertCloseHandler(event:CloseEvent):void {
			if(event.detail == Alert.OK) {
				NativeApplication.nativeApplication.exit();
			}
		}
		
		public function Close_clickHandler(event: MouseEvent):void
		{
			closeFlag = true;
			previousClose = true;
			view.MessageWindowGroup.move(view.MessageWindowGroup.x, view.MessageWindowGroup.y + 240);
		}
		
		public function MSWindow_clickHandler(event:MouseEvent):void{
			if(previousClose == true){
				previousClose = false;
			}
			else{
				if(closeFlag){	
					view.MessageWindowGroup.move(view.MessageWindowGroup.x, view.MessageWindowGroup.y - 240);
					closeFlag = false;
				}
				else{
					//次の文章に進める
					actionComplete();
				}
			}
		}	
	}	
}
