package Lib
{
	import caurina.transitions.*;
	
	import common.*;
	
	import flash.display.*;
	
	import mx.controls.Button;
	import mx.core.UIComponent;
	
	import spark.components.Image;
	
	public class CommandManager
	{
		private const MODE_END:int=common.Enum.next();
		private const MODE_INIT:int = common.Enum.next(0);
		private const MODE_FADE:int = common.Enum.next();
		public const MODE_CURSOR:int = common.Enum.next();
		public const MODE_WAIT:int = common.Enum.next();
		private const EVENT_VOICE:String="EVENT_VOICE";
		public const MODE_NEXT:int=common.Enum.next();	
		public const MODE_POPUP:int=common.Enum.next();
		public const MODE_TEXT:int = common.Enum.next();
		private const RIDHI:String="c105000.png";
		private const RIDHI_X:int=0;
		private const RIDHI_Y:int=228;
		
		private const FRONT_CENTER_X:int=380;
		private const FRONT_CENTER_Y:int=190;
		
		private const FRONT_LEFT_X:int=190;
		private const FRONT_LEFT_Y:int=190;
		
		private const FRONT_RIGHT_X:int=570;
		private const FRONT_RIGHT_Y:int=190;
		
		private const BUTTON_SCREEN:int=16;
		
		private var _m_Mode:int;
		private var _m_WaitTime:int;
		
		private var _m_IsPlay:Boolean;
		private var _m_Sound:common.SoundManager;
		
		private var m_IsText:Boolean;
		
		private var m_EventCg:flash.display.Bitmap;
		private var m_EventCgCenter:flash.display.Bitmap;
		
		private var m_EventMovie:flash.display.MovieClip;
		
		private var m_EventData:Array;
		
		private var m_EventPack:flash.display.MovieClip;
		
		private var m_EventIndex:int;
		private var m_Status_r18:Boolean;
		private var m_EventRidhi:flash.display.MovieClip;
		private var m_RidhiNum:int;
		private var m_EventCgRight:flash.display.Bitmap;
		private var m_EventCgLeft:flash.display.Bitmap;
		private var m_EventCgPopup:flash.display.Bitmap;		
		private var m_EventPopupMovie:flash.display.MovieClip;;
		
		private var m_Name:String;
		private var m_Message:String;
		private var m_Voice:String;
		
		private var _m_BtnScreen:mx.core.UIComponent;
		private var _m_BtnR18:mx.controls.Button;
		private var _m_BtnSkip:mx.controls.Button
		private var _m_MessIndex:int;
		private var _m_IsR18Btn:Boolean;
		private var _m_GeneralEnd:Boolean;
		
		private var view:QuizOfWalkurePlayer;
		
		//m_EventData, 終了時の処理を記述した関数を引数にとる
		public function get m_Mode():int{
			return this._m_Mode;
		}
		public function set m_Mode(arg1:int):void{
			this._m_Mode = arg1;
		}	
		public function get m_IsPlay():Boolean{
			return this._m_IsPlay;
		}
		public function set m_IsPlay(arg1:Boolean):void{
			this._m_IsPlay = arg1;
		}
		public function get m_WaitTime():int{
			return this._m_WaitTime;
		}
		public function set m_WaitTime(arg1:int):void{
			this._m_WaitTime = arg1;
		}
		
		
		public function get m_BtnScreen():mx.core.UIComponent{
			return this._m_BtnScreen;
		}
		
		public function set m_BtnScreen(arg1:mx.core.UIComponent):void{
			this._m_BtnScreen = arg1;
		}
		
		
		public function get m_BtnR18():mx.controls.Button{
			return this._m_BtnR18;
		}
		public function set m_BtnR18(arg1:mx.controls.Button):void{
			this._m_BtnR18 = arg1;
		}
		
		public function get m_BtnSkip():mx.controls.Button{
			return this._m_BtnSkip;
		}
		public function set m_BtnSkip(arg1:mx.controls.Button):void{
			this._m_BtnSkip = arg1;
		}
		

		public function get m_Sound():common.SoundManager{
			return this._m_Sound;
		}
		public function set m_Sound(arg1:common.SoundManager):void{
			this._m_Sound = arg1;
		}
		

		public function get m_MessIndex():int{
			return this._m_MessIndex;
		}
		public function set m_MessIndex(arg1:int):void{
			this._m_MessIndex = arg1;
		}

		public function get m_IsR18Btn():Boolean{
			return this._m_IsR18Btn;
		}
		public function set m_IsR18Btn(arg1:Boolean):void{
			this._m_IsR18Btn = arg1;
		}
		
		public function get m_GeneralEnd():Boolean{
			return this._m_GeneralEnd;
		}
		public function set m_GeneralEnd(arg1:Boolean):void{
			this._m_GeneralEnd = arg1;
		}
		
		
		public function CommandManager(QoWData:QuizOfWalkurePlayer, loader:ComponentLoader, eventData:Array)
		{
			this.m_IsPlay = true;
			this.m_IsText=false;
			
			this.m_Mode=this.MODE_INIT;
			this.m_EventData = eventData;
			this.m_EventIndex = 0;
			this.m_Status_r18 = true;
			this.m_EventCg = null;
			this.m_EventCgCenter = null;
			this.m_EventCgLeft = null;
			this.m_EventCgRight = null;
			this.m_EventCgPopup = null;
			
			
			//this.view = QoWData;
			this.m_BtnScreen = view.screen_click;
			this.m_BtnR18 = view.btn_r18;
			this.m_BtnSkip = view.btn_skip;
			this.m_Sound = new common.SoundManager();
			var setSound:common.SoundSet = new common.SoundSet();
			setSound.Add(m_Sound);
			this.m_MessIndex = 0;
			this.m_IsR18Btn = false;
			this.m_GeneralEnd = false;
			//this.compLoader = loader;
			this.m_EventPack = loader;
		}
		
		
		
		public function ManageEvent():void{
			var command:*;
			command = undefined;
			var i:int=0;
			while(this.m_Mode == this.MODE_NEXT)
			{
				command = this.m_EventData[this.m_EventIndex][0];
				if(command == "all" && !this.m_Status_r18) command = "";
				if(command == "r18" && this.m_Status_r18) command = "";
				
				//最初の値にコマンド名が無かった場合
				
				if(command == "")
				{
					if(this.m_EventData[this.m_EventIndex][1] == "")
					{
						if(this.m_EventData[this.m_EventIndex][2] == "")
						{
							if(this.m_EventData[this.m_EventIndex][3] != "")
							{
								//"   ああああ” みたいなとき。
								command = "text";
							}	
						}
						else
						{
							//"  なんか" みたいなとき
							command = "novoice";
						}
					}
					else
					{
						//" なんか"　みたいなとき
						command = "voice";
					}					
				}
				
				//各コマンドによる処理を実行
				ExecutionAction(command, i);
				
				if(this.m_Mode != this.MODE_END)
				{
					this.m_EventIndex++;
					if(this.m_EventIndex >= this.m_EventData.length)
					{
						//Eventの終了処理
					}
				}
				
			}//End While Loop
			
			return;
		}//End Function Define
		
		//各コマンドごとの処理
		private function ExecutionAction(command:String, i:int):void
		{
			switch(command)
			{
				case "fade":
				{
					if(this.m_EventData[this.m_EventIndex][1] != "white")
					{
						if (this.m_EventData[this.m_EventIndex][1] == "black") 
						{
							view.fade_black.visible = true;
							view.fade_black.alpha = 1;
						}
					}
					else
					{
							view.fade_white.visible = true;
							view.fade_white.alpha = 1;
					}
					
					this.m_Mode = this.MODE_NEXT;
					break;
				}		
				case "fadeIn":
				{
					if(this.m_EventData[this.m_EventIndex][1] != "white")
					{
						if(this.m_EventData[this.m_EventIndex][1] == "black")
						{
							//fade_blackはImageコンポーネントのためなにか問題がでる可能性あり
							this.FadeIn(view.fade_black, parseInt(this.m_EventData[this.m_EventIndex][2]));
						}
					}
					else
					{
						this.FadeIn(view.fade_white, parseInt(this.m_EventData[this.m_EventIndex][2]));
					}
						this.m_Mode = this.MODE_FADE;
						break;
				}
				case "fadeOut":
				{
					if(this.m_EventData[this.m_EventIndex][1] != "white")
					{
						if(this.m_EventData[this.m_EventIndex][1] == "black")
						{
							//fade_blackはImageコンポーネントのためなにか問題がでる可能性あり
							this.FadeOut(view.fade_black, parseInt(this.m_EventData[this.m_EventIndex][2]));
						}
					}
					else
					{
						this.FadeOut(view.fade_white, parseInt(this.m_EventData[this.m_EventIndex][2]));
					}
					this.m_Mode = this.MODE_FADE;				
					break;
				}
				case "wait":
				{
					this.m_WaitTime = parseInt(this.m_EventData[this.m_EventIndex][1]);
					this.m_Mode = this.MODE_WAIT;
					break;
				}
				case "image":
				{
					this.ClearImage();
					if (this.m_Status_r18 || this.m_EventData[this.m_EventIndex][2] == "") 
					{
						this.m_EventCg = this.m_EventPack.GetLinkageBitmap(this.m_EventData[this.m_EventIndex][1]);
					}
					else 
					{
						this.m_EventCg = this.m_EventPack.GetLinkageBitmap(this.m_EventData[this.m_EventIndex][2]);
					}
					if (this.m_EventCg) 
					{
						this.m_EventCg.x = Math.floor((common.Conf.SCREEN_WIDTH - this.m_EventCg.width) / 2);
						this.m_EventCg.y = 0;
						view.cg_mc.addChild(this.m_EventCg);
					}
					this.m_Mode = this.MODE_NEXT;
					break;
				}
				case "center":
				{
					
					this.ClearFrontImage(0);
					if (this.m_EventData[this.m_EventIndex][1] != this.RIDHI) 
					{
						this.m_EventCgCenter = this.m_EventPack.GetLinkageBitmap(this.m_EventData[this.m_EventIndex][1]);
						if (this.m_EventCgCenter) 
						{
							this.m_EventCgCenter.x = this.FRONT_CENTER_X - parseInt(this.m_EventData[this.m_EventIndex][2]);
							this.m_EventCgCenter.y = this.FRONT_CENTER_Y - parseInt(this.m_EventData[this.m_EventIndex][3]);
							view.front_mc.addChild(this.m_EventCgCenter);
						}
					}
					else 
					{
						this.m_EventRidhi = new ridhi_mc();
						this.m_EventRidhi.x = this.FRONT_CENTER_X + this.RIDHI_X;
						this.m_EventRidhi.y = this.RIDHI_Y;
						view.front_mc.addChild(this.m_EventRidhi);
						this.m_RidhiNum = 0;
					}
					this.m_Mode = this.MODE_NEXT;
					break;
				}
				case "left":
				{
					this.ClearFrontImage(1);
					if (this.m_EventData[this.m_EventIndex][1] != this.RIDHI) 
					{
						this.m_EventCgLeft = this.m_EventPack.GetLinkageBitmap(this.m_EventData[this.m_EventIndex][1]);
						if (this.m_EventCgLeft) 
						{
							this.m_EventCgLeft.x = this.FRONT_LEFT_X - parseInt(this.m_EventData[this.m_EventIndex][2]);
							this.m_EventCgLeft.y = this.FRONT_LEFT_Y - parseInt(this.m_EventData[this.m_EventIndex][3]);
							view.front_mc.addChild(this.m_EventCgLeft);
						}
					}
					else 
					{
						this.m_EventRidhi = new ridhi_mc();
						this.m_EventRidhi.x = this.FRONT_LEFT_X + this.RIDHI_X;
						this.m_EventRidhi.y = this.RIDHI_Y;
						view.front_mc.addChild(this.m_EventRidhi);
						this.m_RidhiNum = 1;
					}
					this.m_Mode = this.MODE_NEXT;
					break;
				}
				case "right":
				{
					this.ClearFrontImage(2);
					if (this.m_EventData[this.m_EventIndex][1] != this.RIDHI) 
					{
						this.m_EventCgRight = this.m_EventPack.GetLinkageBitmap(this.m_EventData[this.m_EventIndex][1]);
						if (this.m_EventCgRight) 
						{
							this.m_EventCgRight.x = this.FRONT_RIGHT_X - parseInt(this.m_EventData[this.m_EventIndex][2]);
							this.m_EventCgRight.y = this.FRONT_RIGHT_Y - parseInt(this.m_EventData[this.m_EventIndex][3]);
							view.front_mc.addChild(this.m_EventCgRight);
						}
					}
					else 
					{
						this.m_EventRidhi = new ridhi_mc();
						this.m_EventRidhi.x = this.FRONT_RIGHT_X + this.RIDHI_X;
						this.m_EventRidhi.y = this.RIDHI_Y;
						view.front_mc.addChild(this.m_EventRidhi);
						this.m_RidhiNum = 2;
					}
					this.m_Mode = this.MODE_NEXT;
					break;
				}
				case "face":
				{
					this.SetFace(this.m_EventData[this.m_EventIndex][1]);
					break;
				}
				case "clear":
				{
					if (this.m_EventData[this.m_EventIndex][1] != "image") 
					{
						if (this.m_EventData[this.m_EventIndex][1] != "center") 
						{
							if (this.m_EventData[this.m_EventIndex][1] != "left") 
							{
								if (this.m_EventData[this.m_EventIndex][1] != "right") 
								{
									this.ClearImage();
									this.ClearFrontImage(0);
									this.ClearFrontImage(1);
									this.ClearFrontImage(2);
								}
								else 
								{
									this.ClearFrontImage(2);
								}
							}
							else 
							{
								this.ClearFrontImage(1);
							}
						}
						else 
						{
							this.ClearFrontImage(0);
						}
					}
					else 
					{
						this.ClearImage();
					}
					this.m_Mode = this.MODE_NEXT;
					break;
				}
				case "popup":
				{	
					this.ClearPopup();
					this.m_EventCgPopup = this.m_EventPack.GetLinkageBitmap(this.m_EventData[this.m_EventIndex][1]);
					if (this.m_EventCgPopup) 
					{
						this.m_EventCgPopup.x = parseInt(this.m_EventData[this.m_EventIndex][2]);
						this.m_EventCgPopup.y = parseInt(this.m_EventData[this.m_EventIndex][3]);
						view.popup_mc.addChild(this.m_EventCgPopup);
						this.m_EventCgPopup.alpha = 0;
						caurina.transitions.Tweener.addTween(this.m_EventCgPopup, {"alpha":1, "useFrames":true, "delay":0, "time":15, "transition":"linear", "onComplete":function ():void
						{
							m_BtnScreen.visible = true;
							return;
						}})
						this.m_Mode = this.MODE_POPUP;
					}
					else 
					{
						this.m_Mode = this.MODE_NEXT;
					}
					break;
				}
				case "movie":
				{
					this.ClearImage();
					this.m_EventMovie = this.m_EventPack.GetLinkageMovieClip(this.m_EventData[this.m_EventIndex][1]);
					if (this.m_EventMovie) 
					{
						this.m_EventMovie.x = Math.floor((common.Conf.SCREEN_WIDTH - this.m_EventMovie.width) / 2);
						this.m_EventMovie.y = 0;
						view.cg_mc.addChild(this.m_EventMovie);
					}
					this.m_Mode = this.MODE_NEXT;
					break;
				}
				case "se":
				{
					this.PlaySound(this.m_EventData[this.m_EventIndex][1]);
					this.m_Mode = this.MODE_NEXT;
					break;
				}
				case "popupmovie":
				{
					this.ClearImage();
					this.m_EventPopupMovie = this.m_EventPack.GetLinkageMovieClip(this.m_EventData[this.m_EventIndex][1]);
					if (this.m_EventPopupMovie) 
					{
						this.m_EventPopupMovie.x = parseInt(this.m_EventData[this.m_EventIndex][2]);
						this.m_EventPopupMovie.y = parseInt(this.m_EventData[this.m_EventIndex][3]);
						view.popup_mc.addChild(this.m_EventPopupMovie);
						this.m_EventPopupMovie.alpha = 0;
						caurina.transitions.Tweener.addTween(this.m_EventPopupMovie, {"alpha":1, "useFrames":true, "delay":0, "time":15, "transition":"linear", "onComplete":function ():void
						{
							m_BtnScreen.visible = true;
							return;
						}})
						this.m_Mode = this.MODE_POPUP;
					}
					else 
					{
						this.m_Mode = this.MODE_NEXT;
					}
					break;
				}
				case "voice":
				{
					this.m_Voice = this.m_EventData[this.m_EventIndex][1];
					this.m_Name = this.m_EventData[this.m_EventIndex][2];
					this.m_Message = this.m_EventData[this.m_EventIndex][3];
					i = 4;
					while (i < this.m_EventData[this.m_EventIndex].length) 
					{
						this.m_Message = this.m_Message + "\n";
						this.m_Message = this.m_Message + this.m_EventData[this.m_EventIndex][i];
						++i;
					}
					this.SetMessage();
					this.m_Mode = this.MODE_TEXT;
					break;
				}
				case "novoice":
				{
					this.m_Voice = "";
					this.m_Name = this.m_EventData[this.m_EventIndex][2];
					this.m_Message = this.m_EventData[this.m_EventIndex][3];
					i = 4;
					while (i < this.m_EventData[this.m_EventIndex].length) 
					{
						this.m_Message = this.m_Message + "\n";
						this.m_Message = this.m_Message + this.m_EventData[this.m_EventIndex][i];
						++i;
					}
					this.SetMessage();
					this.m_Mode = this.MODE_TEXT;
					break;
				}
				case "text":
				{
					this.m_Voice = "";
					this.m_Name = "";
					this.m_Message = this.m_EventData[this.m_EventIndex][3];
					i = 4;
					while (i < this.m_EventData[this.m_EventIndex].length) 
					{
						this.m_Message = this.m_Message + "\n";
						this.m_Message = this.m_Message + this.m_EventData[this.m_EventIndex][i];
						++i;
					}
					this.SetMessage();
					this.m_Mode = this.MODE_TEXT;
					break;
				}
				case "showWindow":
				{
					if (this.m_Status_r18 == false && this.m_EventData[this.m_EventIndex][1] == "r18") 
					{
						this.m_IsR18Btn = true;
						this.m_BtnR18.visible = true;
					}
					this.ShowWindow();
					this.m_WaitTime = 15;
					this.m_Mode = this.MODE_WAIT;
					break;
				}
				case "hideWindow":
				{
					this.HideWindow();
					this.m_WaitTime = 15;
					this.m_Mode = this.MODE_WAIT;
					break;
				}
				case "comment":
				{
					this.m_Mode = this.MODE_NEXT;
					break;
				}
				case "general":
				{
					if (this.m_Status_r18) 
					{
						this.m_Mode = this.MODE_NEXT;
					}
					else 
					{
						this.m_GeneralEnd = true;
						this.m_Voice = "";
						this.m_Name = common.Conf.EVENT_GENERAL_NAME;
						this.m_Message = common.Conf.EVENT_GENERAL_TEXT;
						this.SetMessage();
						this.m_Mode = this.MODE_TEXT;
					}
					break;
				}
				case "end":
				{
					this.EventEnd();
					this.m_Mode = this.MODE_END;
					break;
				}
			}
		}
		
		
		private function FadeIn(arg1:spark.components.Image, arg2:int):void
		{
			var tm:int;
			var mc:spark.components.Image;
			
			mc = arg1;
			tm = arg2;
			mc.visible = true;
			mc.alpha = 1;
			caurina.transitions.Tweener.addTween(mc, {"alpha":0, "useFrames":true, "delay":0, "time":tm, "transition":"linear", "onComplete":function ():void
			{
				mc.visible = false;
				m_Mode = MODE_NEXT;
				return;
			}})
			return;
		}
		
		private function FadeOut(arg1:spark.components.Image, arg2:int):void
		{
			var tm:int;
			//var mc:flash.display.MovieClip;
			var image:spark.components.Image;
			image = arg1;
			//mc = arg1;
			tm = arg2;
			image.visible = true;
			image.alpha = 0;
			caurina.transitions.Tweener.addTween(image, {"alpha":1, "useFrames":true, "delay":0, "time":tm, "transition":"linear", "onComplete":function ():void
			{
				m_Mode = MODE_NEXT;
				return;
			}})
			return;
		}
	
		private function ClearImage():void{
			if (this.m_EventCg) 
			{
				this.m_EventCg.bitmapData.dispose();
				view.cg_mc.removeChild(this.m_EventCg);
				this.m_EventCg = null;
			}
			if (this.m_EventMovie) 
			{
				view.cg_mc.removeChild(this.m_EventMovie);
				this.m_EventMovie = null;
			}
			return;
		}

		private function ClearFrontImage(arg1:int):void
		{
			var loc1:*=arg1;
			switch (loc1) 
			{
				case 0:
				{
					if (this.m_EventCgCenter) 
					{
						this.m_EventCgCenter.bitmapData.dispose();
						view.front_mc.removeChild(this.m_EventCgCenter);
						this.m_EventCgCenter = null;
					}
					if (this.m_RidhiNum == 0 && this.m_EventRidhi) 
					{
						view.front_mc.removeChild(this.m_EventRidhi);
						this.m_EventRidhi = null;
					}
					break;
				}
				case 1:
				{
					if (this.m_EventCgLeft) 
					{
						this.m_EventCgLeft.bitmapData.dispose();
						view.front_mc.removeChild(this.m_EventCgLeft);
						this.m_EventCgLeft = null;
					}
					if (this.m_RidhiNum == 1 && this.m_EventRidhi) 
					{
						view.front_mc.removeChild(this.m_EventRidhi);
						this.m_EventRidhi = null;
					}
					break;
				}
				case 2:
				{
					if (this.m_EventCgRight) 
					{
						this.m_EventCgRight.bitmapData.dispose();
						view.front_mc.removeChild(this.m_EventCgRight);
						this.m_EventCgRight = null;
					}
					if (this.m_RidhiNum == 2 && this.m_EventRidhi) 
					{
						view.front_mc.removeChild(this.m_EventRidhi);
						this.m_EventRidhi = null;
					}
					break;
				}
			}
			return;
		}

		public function ClearPopup():void
		{
			var loc1:*;
			if (this.m_EventCgPopup) 
			{
				caurina.transitions.Tweener.addTween(this.m_EventCgPopup, {"alpha":0, "useFrames":true, "delay":0, "time":15, "transition":"linear", "onComplete":function ():void
				{
					ClearPopupImage();
					m_Mode = MODE_NEXT;
					return;
				}})
			}
			if (this.m_EventPopupMovie) 
			{
				view.cg_mc.removeChild(this.m_EventPopupMovie);
				this.m_EventPopupMovie = null;
			}
			return;
		}
		
		private function ClearPopupImage():void
		{
			if (this.m_EventCgPopup) 
			{
				this.m_EventCgPopup.bitmapData.dispose();
				view.popup_mc.removeChild(this.m_EventCgPopup);
				this.m_EventCgPopup = null;
			}
			return;
		}

		public function ShowWindow():void{
			caurina.transitions.Tweener.removeTweens(view.message_window);
			caurina.transitions.Tweener.addTween(view.message_window, {"y":346, "useFrames":true, "delay":0, "time":15, "transition":"easeOutCubic", "onComplete":function ():void
			{
				return;
			}})
			return;
		}
		
		private function SetFace(arg1:String):void
		{
			if (this.m_EventRidhi) 
			{
				this.m_EventRidhi.gotoAndStop(arg1);
			}
			return;
		}
	
		private function PlaySound(arg1:String):void
		{
			var loc1:*=arg1;
			switch (loc1) 
			{
				case "SE_01":
				{
					m_Sound.Play(common.SoundConst.SE01_ONCURSOR);
					break;
				}
				case "SE_02":
				{
					m_Sound.Play(common.SoundConst.SE02_OK);
					break;
				}
				case "SE_03":
				{
					m_Sound.Play(common.SoundConst.SE03_CANCEL);
					break;
				}
				case "SE_04":
				{
					m_Sound.Play(common.SoundConst.SE04_HARISEN);
					break;
				}
				case "SE_05":
				{
					m_Sound.Play(common.SoundConst.SE05_LEVELUP);
					break;
				}
				case "SE_06":
				{
					m_Sound.Play(common.SoundConst.SE06_GENRE);
					break;
				}
				case "SE_07":
				{
					m_Sound.Play(common.SoundConst.SE07_SKILL);
					break;
				}
				case "SE_08":
				{
					m_Sound.Play(common.SoundConst.SE08_COLLECT);
					break;
				}
				case "SE_09":
				{
					m_Sound.Play(common.SoundConst.SE09_INCORRECT);
					break;
				}
				case "SE_10":
				{
					m_Sound.Play(common.SoundConst.SE10_HIT);
					break;
				}
				case "SE_11":
				{
					m_Sound.Play(common.SoundConst.SE11_DAMAGE);
					break;
				}
				case "SE_12":
				{
					m_Sound.Play(common.SoundConst.SE12_KIRAKIRA);
					break;
				}
				case "SE_13":
				{
					m_Sound.Play(common.SoundConst.SE13_CHARGE);
					break;
				}
				case "SE_14":
				{
					m_Sound.Play(common.SoundConst.SE14_SHOOT);
					break;
				}
				case "SE_15":
				{
					m_Sound.Play(common.SoundConst.SE15_BACHI);
					break;
				}
				case "SE_16":
				{
					m_Sound.Play(common.SoundConst.SE16_EVENTOK);
					break;
				}
			}
			return;
		}
	
		private function SetMessage():void
		{
			view.chara_name.text = this.m_Name;
			this.m_MessIndex = 0;
			if (m_Sound.IsPlay(this.EVENT_VOICE)) 
			{
				m_Sound.Stop(this.EVENT_VOICE);
			}
			if (this.m_Voice != "") 
			{
				m_Sound.AddSound(this.EVENT_VOICE, this.m_EventPack.GetLinkageSound(this.m_Voice + ".wav"), common.SoundConst.SOUND_TYPE_VOICE);
				m_Sound.Play(this.EVENT_VOICE);
			}
			this.m_IsText = true;
			return;
		}
	
		public function HideWindow():void
		{
			var loc1:*;
			caurina.transitions.Tweener.removeTweens(view.message_window);
			caurina.transitions.Tweener.addTween(view.message_window, {"y":470, "useFrames":true, "delay":0, "time":15, "transition":"easeOutCubic", "onComplete":function ():void
			{
				return;
			}})
			return;
		}
		
		public function EventEnd():void
		{
			this.m_IsPlay = false;
			this.m_BtnSkip.enabled=false;//btn入力の無効化、どうやって再現するか？
			this.PageOut();
			return;
		}
		
		public function PageOut():void
		{
			var alp:Number;
			
			var loc1:*;
			//m_Gm.IsActive = false;
			this.HideWindow();
			alp = 0;
			if (!view.fade_black.visible || view.fade_black.alpha < 1) 
			{
				view.fade_black.visible = true;
				view.fade_black.alpha = 0;
			}
			caurina.transitions.Tweener.addTween(view.fade_black, {"alpha":1, "useFrames":true, "delay":0, "time":30, "transition":"linear", "onComplete":function ():void
			{
				Hide();
				return;
			}})
			return;
		}
		
		public function Hide():void
		{
			if (m_Sound.IsPlay(this.EVENT_VOICE)) 
			{
				m_Sound.Stop(this.EVENT_VOICE);
			}
			this.ClearImage();
			this.ClearFrontImage(0);
			this.ClearFrontImage(1);
			this.ClearFrontImage(2);
			this.ClearPopupImage();
			this.m_EventPack.Release();
			/*
			view.removeChild(this.m_EventArea);
			m_Gm.IsActive = true;
			m_Gm.EventEnd();*/
			return;
		}
	}
}