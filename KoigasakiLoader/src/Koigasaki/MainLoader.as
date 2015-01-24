// ActionScript file
package Koigasaki
{
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.system.LoaderContext;
	
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.core.IMXMLObject;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	
	import spark.skins.spark.TextAreaSkin;
	
	import a24.tween.Tween24;
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.TextShortcuts;
	
	TextShortcuts.init();

	public class MainLoader implements IMXMLObject
	{
		private var view:KoigasakiLoader;
		private var closeFlag:Boolean = false;
		private var previousClose:Boolean = false;
		private var ScenarioIndex:int = 0;
		private var tween:Tween24 = null;

		private var bg_Glob:Image;
		private var additional_ui:UIComponent;
		private var current_soundObj:Sound;
		
		public var ScenarioObj:Object;
		public var Mp3Obj:Object={};
		public var MovieObj:Object={};
		public var ImgObj:Object={};
		public var script:Object = null;
		public var currentSoundChannel:SoundChannel;
		public var currentBgmChannel:SoundChannel;
		
		public var firstName:String = "晴男";
		public var familyName:String = "花山";
		
		public static const ACTION_COMPLETE:String = "complete_action";
		public static const ALIGN_LEFT_X:int = 230;
		public static const ALIGN_CENTER_X:int = 470;
		public static const ALIGN_CENTER_Y:int = 350;
		public static const ALIGN_RIGHT_X:int = 710;
		private static var colors:Object = [3947580, 30447, 15676345, 1092388, 11998391, 14141200, 15891712, 9061420, 8551797, 195, 15141900];

		
		public function initialized(document:Object, id:String):void
		{
			view = document as KoigasakiLoader;
		}
		
		public function action():void{
			if(view.background.alpha <= 0){
				Tween24.tween(view.background, 0.1, Tween24.ease.QuadInOut).fadeIn().play();
			}
			
			this.tween = null;
			this.script = ScenarioObj[ScenarioIndex];
			
			if(script.hasOwnProperty("end")){
				NativeApplication.nativeApplication.exit();	
			}
			else if(script.hasOwnProperty("bgm")){
				bgmAction(this.script);
			}
			else if(script.hasOwnProperty("effect")){
				effectAction(this.script);
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
		private function randomInt(param1:int, param2:int) : int {
			var _loc_3:* = Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
			return _loc_3;
		}
		
		private function effectAction(param:Object):void{
			var effectParam:Object = param.effect;
			var mv_effect:MovieClip;// = new MovieClip();
			
			if(effectParam.hasOwnProperty("action")){
				if(effectParam.action == "flash"){
					mv_effect = new MovieClip();
					mv_effect.width = view.width;
					mv_effect.height = view.height;
					//あらかじめ入ってた場合は消去しておく
					if(view.uicomp.numChildren > 1){
						while(view.uicomp.numChildren > 1){
							view.uicomp.removeChildAt(0);
						}
					}
					
					var color:*;
					view.uicomp.addChild(mv_effect);
					if(effectParam.hasOwnProperty("hex")){
						if(effectParam.hex != null){
							color = effectParam.hex;
						}
					}
					this.tween = Tween24.serial(Tween24.tween(mv_effect, 0).color(color, 1), 
						Tween24.tween(mv_effect, 0.03).color(color, 0));
				}
				else if(effectParam.action == "tilt"){
					this.tween = Tween24.serial(Tween24.tween(view, 0.05).x(this.randomInt(-10, 10)).y(this.randomInt(-10, 10)), 
						Tween24.tween(view, 0.05).x(this.randomInt(-10, 10)).y(this.randomInt(-10, 10)), 
						Tween24.tween(view, 0.05).x(this.randomInt(-10, 10)).y(this.randomInt(-10, 10)), 
						Tween24.tween(view, 0.05).x(this.randomInt(-10, 10)).y(this.randomInt(-10, 10)), 
						Tween24.tween(view, 0.05).x(this.randomInt(-10, 10)).y(this.randomInt(-10, 10)), 
						Tween24.tween(view, 0.05).x(this.randomInt(-10, 10)).y(this.randomInt(-10, 10)), 
						Tween24.tween(view, 0.05).x(this.randomInt(-10, 10)).y(this.randomInt(-10, 10)), 
						Tween24.tween(view, 0.05).x(this.randomInt(-10, 10)).y(this.randomInt(-10, 10)), 
						Tween24.tween(view, 0).x(0).y(0));
				}
				else if(effectParam.action =="action"){
					var target:MovieClip;
					if(effectParam.hasOwnProperty("target")){
						target = view.Character.content as MovieClip;
					}
					if(target != null){
						var eye:MovieClip = target.mv_char.mv_eye;
						if (effectParam.hasOwnProperty("type")){
							switch(effectParam["type"]){
								case "slideinR":{
									this.tween = Tween24.serial(Tween24.tween(target, 0).x(-ALIGN_LEFT_X), Tween24.tween(target, 0.4).x(ALIGN_RIGHT_X));
									break;
								}
								case "slideoutR":{
									this.tween = Tween24.serial(Tween24.tween(target, 0).x(ALIGN_LEFT_X), Tween24.tween(target, 0.4).x(view.width + ALIGN_LEFT_X));
									break;
								}
								case "slideinL":{
									this.tween = Tween24.serial(Tween24.tween(target, 0).x(view.width + ALIGN_LEFT_X), Tween24.tween(target, 0.4).x(ALIGN_LEFT_X));
									break;
								}
								case "slideoutL":{
									this.tween = Tween24.serial(Tween24.tween(target, 0).x(ALIGN_RIGHT_X), Tween24.tween(target, 0.4).x(-ALIGN_LEFT_X));
									break;
								}
								case "jump":{
									this.tween = Tween24.serial(Tween24.tween(target, 0.3).$y(-15), Tween24.tween(target, 0.3).$y(0));
									break;
								}
								case "bow":{
									this.tween = Tween24.serial(Tween24.tween(target, 0.3).$y(15), Tween24.tween(target, 0.3).$y(0));
									break;
								}
								case "vibe":{
									this.tween = Tween24.serial(Tween24.tween(target, 0.05).$$x(-5), Tween24.tween(target, 0.05).$$x(5), Tween24.tween(target, 0.05).$$x(-5), Tween24.tween(target, 0.05).$$x(5), Tween24.tween(target, 0.05).$$x(-5), Tween24.tween(target, 0.05).$$x(5), Tween24.tween(target, 0.05).$$x(-5), Tween24.tween(target, 0.05).$$x(5), Tween24.tween(target, 0.05).$$x(0));
									break;
								}
								case "swing":{
									this.tween = Tween24.serial(Tween24.tween(target, 0.15).$$x(-10), Tween24.tween(target, 0.15).$$x(10), Tween24.tween(target, 0.15).$$x(-10), Tween24.tween(target, 0.15).$$x(10), Tween24.tween(target, 0.1).$$x(0));
									break;
								}
								case "blink2":{
									this.tween = Tween24.gotoAndPlay(77, eye);
									break;
								}
								case "blink":{
									this.tween = Tween24.gotoAndPlay(87, eye);
									break;
								}
								case "fadeout":{
									this.tween = Tween24.serial(Tween24.tween(target, 0, Tween24.ease.QuadOut).fadeIn(), Tween24.tween(target, 0.13, Tween24.ease.QuadOut).fadeOut());
									break;
								}
								case "fadein":{
									this.tween = Tween24.serial(Tween24.tween(target, 0, Tween24.ease.QuadOut).fadeOut(), Tween24.tween(target, 0.13, Tween24.ease.QuadOut).fadeIn());
									break;
								}
								default:{
									break;
								}
							}
						}
					}
				}
			}
			if(this.tween != null){
				this.tween.addEventListener(Event.COMPLETE, this.onTweenComplete);
				this.tween.play();
			}
			
			return;
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
			var bgmData:Object = param.bgm;
			if(bgmData.hasOwnProperty("src")){
				this.current_soundObj = Sound(Mp3Obj[bgmData.src]);
				currentBgmChannel = this.current_soundObj.play();
				currentBgmChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
			if(bgmData.hasOwnProperty("action")){
				if(bgmData.action == "finish"){
					currentBgmChannel.stop();
				}
			}
			this.actionComplete();
			return;
		}
		private function onSoundComplete(event:Event):void{
			currentBgmChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			//e.currentTarget.removeEventListener(Event.SOUND_COMPLETE, func);
			currentBgmChannel = this.current_soundObj.play();
			currentBgmChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
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
				
				if(charProp.src == null){
					view.Character.source = "";
					actionComplete();
					return;
				}
				else{
					if(view.Character.source == MovieObj[charProp.src]){
						var mvClip:MovieClip= view.Character.content as MovieClip;
						
						if(charProp.hasOwnProperty("eye")){
							var eye:MovieClip = mvClip.mv_char.mv_eye as MovieClip;
							//eye.addEventListener(Event.EXIT_FRAME, function(e:Event):void{eye.stop();});
							eye.gotoAndStop(charProp.eye + 1);
						}
						if(charProp.hasOwnProperty("lip")){
							var lip:MovieClip = mvClip.mv_char.mv_lip as MovieClip;
							//lip.addEventListener(Event.EXIT_FRAME, function(e:Event):void{lip.stop();});
							lip.gotoAndStop(charProp.lip + 1);
						}
						this.actionComplete();
						return;
					}else{
						view.Character.source = MovieObj[charProp.src];
						view.Character.addEventListener(Event.COMPLETE, function(e:Event):void{
							var mvClip:MovieClip= e.target.content as MovieClip;
							
							if(charProp.hasOwnProperty("eye")){
								var eye:MovieClip = mvClip.mv_char.mv_eye as MovieClip;
								//eye.addEventListener(Event.EXIT_FRAME, function(e:Event):void{eye.stop();});
								eye.gotoAndStop(charProp.eye + 1);
							}
							if(charProp.hasOwnProperty("lip")){
								var lip:MovieClip = mvClip.mv_char.mv_lip as MovieClip;
								//lip.addEventListener(Event.EXIT_FRAME, function(e:Event):void{lip.stop();});
								lip.gotoAndStop(charProp.lip + 1);	
							}
							view.Character.removeEventListener(Event.COMPLETE, arguments.callee);
							actionComplete();
						});	
						return;
					}
				}
			}
			actionComplete();
			return;
		}
		private function movieAction(param:Object):void{
			var loaderContext:LoaderContext = new LoaderContext();
			
			loaderContext.allowLoadBytesCodeExecution = true;
			view.mainContents.loaderContext = loaderContext;
			view.mainContents.source = MovieObj[ScenarioObj[ScenarioIndex].movie.src];
	
			if(param.movie.hasOwnProperty("action") == false){
				//もし、loopアクションが入ってない場合
				view.mainContents.addEventListener(Event.COMPLETE, onNotloopEvent);
			}
			else if(ScenarioObj[ScenarioIndex].movie.action == "loop"){
				view.mainContents.addEventListener(Event.COMPLETE, onloopEvent);
			}
			else if(ScenarioObj[ScenarioIndex].movie.action == "finish"){
				view.mainContents.source = "";
			}
			this.actionComplete();
			return;
		}
		private function onNotloopEvent(e:Event):void{
			var rootMc:MovieClip = view.mainContents.content as MovieClip;
			rootMc.addEventListener(Event.ENTER_FRAME,
				function(e:Event):void
				{
					if(rootMc.currentFrame == rootMc.totalFrames){
						rootMc.stop();
					}
					//rootMc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
				});
			view.mainContents.removeEventListener(Event.COMPLETE, onNotloopEvent);
		}
		private function onloopEvent(e:Event):void{
			var rootMc:MovieClip;
			rootMc = view.mainContents.content as MovieClip;
			rootMc.addEventListener(Event.ENTER_FRAME,
				function(e:Event):void
				{
					if(rootMc.currentFrame == rootMc.totalFrames) rootMc.gotoAndPlay(1);
				});
			view.mainContents.removeEventListener(Event.COMPLETE, onloopEvent);		
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
			var name:String = param.text.name;
			var serif:String = param.text.serif;
			
			if(name != null){
				name = name.replace(/{s1}/, this.familyName);
				name = name.replace(/{n1}/, this.firstName);
			}
			if(serif != null){
				serif = serif.replace(/{s1}/g, this.familyName);
				serif = serif.replace(/{n1}/g, this.firstName);
			}
			
			//文字の縁取り
			if(param.text.hasOwnProperty("color")){
				var glow : GlowFilter = new GlowFilter( colors[param.text.color], 1.0, 2, 2, 64, 3);    
				TextAreaSkin(view.msArea.skin).filters = [glow];
				view.nameArea.filters = [glow];
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
			var bg:Image;
			var current_bg:Bitmap;
			var loader:Loader = new Loader();
			if(param.bg.hasOwnProperty("src")){
				bg = new Image();
				this.bg_Glob = new Image();
				bg.source = ImgObj[param.bg.src];
				this.bg_Glob.source = ImgObj[param.bg.src];
			}
			if (view.uicomp.numChildren > 1){
				while (view.uicomp.numChildren > 1){
					view.uicomp.removeChildAt(0);
				}
			}
			if (view.background.source != null){
				var bd:BitmapData = new BitmapData(view.width, view.height);
				bd.draw(view.background);
				current_bg = new Bitmap(bd);
			}
				if(param.bg.hasOwnProperty("type")){
					
					if (param.bg["type"] == null){
						var width:Number = view.width/10;
						var height:Number = view.height;
						
						var i:int= 0;
						var mask:MovieClip;
						var s:Shape;
						var mc_mask:MovieClip= new MovieClip();
						var targets:Array=new Array();
						view.background.source = bg.source;
						while (i < 10){	
							mask = new MovieClip();
							s = new Shape();
							s.graphics.beginFill(0);
							s.graphics.drawRect(0, 0, width, height);
							s.graphics.endFill();
							mask.addChild(s);
							mask.x = i * width;
							mc_mask.addChild(mask);
							targets.push(mask);
							i = (i + 1);
						}
						if (current_bg != null){
							this.additional_ui = new UIComponent();
							additional_ui.addChild(current_bg);
							additional_ui.addChild(mc_mask);
							additional_ui.mask = mc_mask;
							view.addElement(additional_ui);
						}
						this.tween = Tween24.lag(0.1, 
							Tween24.tween(targets, 0.5, Tween24.ease.QuadOut).$x(width).width(0), 
							Tween24.tween(targets, 0.5, Tween24.ease.ExpoInOut).fadeOut());
						this.tween.addEventListener(Event.COMPLETE, this.onBgBlindComplete);
						this.tween.play();
						return;
					}
					else if (param.bg["type"] == "f" || param.bg["type"] == "q"){
						this.tween = Tween24.serial(Tween24.tween(view.background, 0.1, Tween24.ease.QuadOut).fadeOut());
					}
					if(this.tween != null){
						this.tween.addEventListener(Event.COMPLETE, onTweenComplete);
						this.tween.play();
					}
				}
				else{
					this.actionComplete();
				}
				return;
			}
			
		private function onBgBlindComplete(event:Event) : void {
			this.tween.removeEventListener(Event.COMPLETE, this.onBgBlindComplete);
			if (this.additional_ui != null){
				view.removeElement(this.additional_ui);
			}
			this.actionComplete();
			return;
		}
		private function onTweenComplete(event:Event):void{
			this.tween.removeEventListener(Event.COMPLETE, onTweenComplete);
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
