package
{
	
	import Lib.CommandManager;
	import Lib.ComponentLoader;
	
	import common.*;
	
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.core.IMXMLObject;
	
	public class QowPlay implements IMXMLObject
	{
//|=========================================================================================================|		
//|======================================Parameters Initialize==============================================|
//|=========================================================================================================|	
		private var view:QuizOfWalkurePlayer;
		private var m_EventData:Array = new Array();
		private var comment:String = "comment.txt";//Eventのテキストデータ
		private var event_File:String = "t1050_h01_19450.swf"//EventのSWFファイル
		private var request:URLRequest = new URLRequest(comment);
		private var m_loader:URLLoader=new URLLoader();
		private var commandManage:CommandManager;
		private var compLoader:ComponentLoader;
		
		private var m_AutoMode:Boolean;
//|=========================================================================================================|		
//|======================================Initialize Function==================================================|
//|=========================================================================================================|	
		public function initialized(document:Object, id:String):void
		{
			view = document as QuizOfWalkurePlayer;
			this.commandManage = new CommandManager(view,compLoader,m_EventData);
		}
	
		public function QowPlay()
		{
			m_loader.addEventListener(Event.COMPLETE, onSuccessLoader);
			m_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorSecurity);
			m_loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorLoader);
			m_loader.load(request);
			m_AutoMode = false;
			compLoader = new ComponentLoader(event_File);
		}	
//|=========================================================================================================|		
//|======================================Event Listeners==================================================|
//|=========================================================================================================|			
		public function btn_closeClick(event:Event):void{
				if(this.commandManage == null){
					return;
				}
				commandManage.m_Sound.Play(common.SoundConst.SE02_OK);
				commandManage.HideWindow();
				commandManage.m_BtnScreen.visible = true;
				commandManage.m_BtnR18.visible = false;
				commandManage.m_BtnSkip.visible = false;
				return;
		}
		
		public function btn_playClick(event:Event):void{
			if(this.commandManage == null){
				return;
			}
			this.commandManage.m_Sound.Play(common.SoundConst.SE02_OK);
			if(this.m_AutoMode){
				this.m_AutoMode = false;
				view.btn_play.selected = false;
			}
			else{
				this.m_AutoMode = true;
				view.btn_play.selected = true;
			}
			return;
		}
		
		public function btn_soundClick(event:Event):void{
			return;
		}
		
		public function screen_Click(event:Event):void{
			if(this.commandManage == null){
				return;
			}
			if(this.commandManage.m_Mode != this.commandManage.MODE_POPUP){
				commandManage.ShowWindow();
				commandManage.m_BtnScreen.visible = false;
				commandManage.m_BtnR18.visible = commandManage.m_IsR18Btn;
				commandManage.m_BtnSkip.visible = true;
			}
			else{
				commandManage.m_BtnScreen.visible = false;
				commandManage.ClearPopup();
			}
			return;
		}
		
		private function onSuccessLoader(event:Event):void{
			var str:String = common.Func.CRLF2LF(m_loader.data);
			var array:Array = str.split("\n");
			var length:uint = array.length;
			
			for(var i:uint=0;i < length;i++){
				this.m_EventData.push(array[i].split("\t"));
			}
			swfLoad();
			return;
		}
		
		private function onErrorSecurity(event:Event):void{
			view.message.text = "Security Error"
		}
		private function onErrorLoader(event:Event):void{
			view.message.text = "File Read Error"
		}
		
		
		
		
//|=========================================================================================================|		
//|======================================Other Methods=======================================================|
//|=========================================================================================================|	
		private function swfLoad():void{
			
		}
		
		
		
		
	}
}