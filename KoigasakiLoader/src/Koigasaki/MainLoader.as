// ActionScript file
package Koigasaki
{
	
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;
	
	import mx.controls.Alert;
	import mx.core.IMXMLObject;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	
	import spark.components.Image;
	
	import a24.tween.Tween24;
	
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
		public var currentSoundChannel:SoundChannel;
		public var currentBgmChannel:SoundChannel;
		public function initialized(document:Object, id:String):void
		{
			view = document as KoigasakiLoader;
		}
		
		public function loadedZipFile():void{
			
			while(1){
				if(ScenarioObj[ScenarioIndex].hasOwnProperty("end")){
					NativeApplication.nativeApplication.exit();	
					break;
				}
				if(ScenarioObj[ScenarioIndex].hasOwnProperty("bgm")){
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
				}
				if(ScenarioObj[ScenarioIndex].hasOwnProperty("effect")){
					//vibe
					//bow
					//blink
				}
				if(ScenarioObj[ScenarioIndex].hasOwnProperty("bg")){
					this.bgAction(ScenarioObj[ScenarioIndex].bg);
				}
				if(ScenarioObj[ScenarioIndex].hasOwnProperty("char")){
					var charProp:Object = ScenarioObj[ScenarioIndex].char;
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
				}
				if(ScenarioObj[ScenarioIndex].hasOwnProperty("wait")){
					if(ScenarioObj[ScenarioIndex].wait < 0){
						break;
					}
					else{
						//次のループへ行くのを待つ
						// 現在の時間を一時的に格納
						var nowTime:int  = getTimer(); 
						var waitTime:int = ScenarioObj[ScenarioIndex].wait;
						// 今の時間から、さっき格納した時間の差分を比較
						while((getTimer() - nowTime) < waitTime){}
					}
				}
				if(ScenarioObj[ScenarioIndex].hasOwnProperty("movie")){
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
					
					//view.mainContents.gotoFirstFrameAndStop();
				}
				if(ScenarioObj[ScenarioIndex].hasOwnProperty("vo")){
					if(currentSoundChannel != null) currentSoundChannel.stop();
					var voData:Object = ScenarioObj[ScenarioIndex].vo;
					if(Mp3Obj.hasOwnProperty(voData.src)){
						currentSoundChannel = Sound(Mp3Obj[voData.src]).play();
					}
				}
				if(ScenarioObj[ScenarioIndex].hasOwnProperty("text")){
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
				}
				ScenarioIndex++;
			}
		}
		
	private function bgAction(param:Object):void{
	var img:Image = new Image();

	if(param.hasOwnProperty("src")){
		img.source = ImgObj[param.src];
	}
		if(param.hasOwnProperty("type")){
			
			if (param["type"] == null){
				var width:Number = view.width/10;
				var height:Number = view.height;
				
				var i:int= 0;
				var mask:MovieClip;
				var s:Shape;
				var mc_mask:MovieClip= new MovieClip();
				var targets:Array=new Array();
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
				if (img != null){
					view.background.source = img.source;
					view.effect.addChild(mc_mask);
					view.effect.mask = mc_mask;		
				}
				this.tween = Tween24.lag(0.1, 
					Tween24.tween(targets, 0.5, Tween24.ease.QuadOut).$x(width).width(0), 
					Tween24.tween(targets, 0.5, Tween24.ease.ExpoInOut).fadeOut());
				this.tween.play();
				return;
			}
			
		}
	
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
					ScenarioIndex++;
					loadedZipFile();
				}
			}
		}	
	}	
}
