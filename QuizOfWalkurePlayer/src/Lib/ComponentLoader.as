package Lib
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.media.Sound;

	
	public class ComponentLoader extends flash.display.MovieClip
	{
		private var m_FileName:String;
		
		private var m_Loader:flash.display.Loader;
		private var m_LoaderInfo:flash.display.LoaderInfo;
		private var m_CallBack:Function;
		private var m_Width:uint;
		private var m_Height:uint;
		
		public function ComponentLoader(arg1:String, arg2:Function=null)
		{		
			super();
			this.m_FileName = arg1;
			this.m_CallBack = arg2;
			
			/*
			this.m_Cache = arg3;
			this.m_FileType = this.SetFileType(this.m_FileName);
			if (this.m_FileType == "") 
			{
				Error(2);
				return;
			}
			if (this.m_FileType == "swf") 
			{
				this.m_Cache = false;
			}*/
			
			this.m_Loader = new flash.display.Loader();
			this.m_LoaderInfo = this.m_Loader.contentLoaderInfo;
			this.m_LoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.LoadComplete);
			
			this.m_LoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.LoadError);
			
			//this.m_LoaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS, this.LoaderInfoProgress);
			
			/*
			this.m_Percent = 0;
			this.m_Progress = false;
			if (arg4) 
			{
				this.addEventListener(flash.events.Event.ENTER_FRAME, this.AutoLoadStart);
			}*/
			
			return;
		}
		
//======================================Event Listensers===================================================		
		private function LoadComplete(event:Event):void{
			this.m_Width = event.target.content.width;
			this.m_Height = event.target.content.height;
			this.addChild(this.m_Loader);
			this.LoadSuccess();
			return;
		}
		
		private function LoadError(event:Event):void{
			
		}
		
		/*
		private function LoaderInfoProgress(event:Event):void{
			
		}*/
	
	
//=============================Other Methods============================================================
		private function LoadSuccess():void{
			if(this.m_CallBack == null){
				return;
			}
			
			this.m_CallBack();
			return;
		}
		
		public function GetLinkageBitmap(arg1:String):flash.display.Bitmap
		{
			var domain:flash.system.ApplicationDomain;
			var linkage:String;
			var bitmapdata:flash.display.BitmapData;
			var newClass:Class;
			
			var loc1:*;
			domain = null;
			newClass = null;
			bitmapdata = null;
			linkage = arg1;
			/*if (this.m_FileType != "swf") 
			{
				return null;
			}
			if (!this.IsLoad()) 
			{
				return null;
			}*/
			try 
			{
				domain = this.m_LoaderInfo.applicationDomain;
				newClass = domain.getDefinition(linkage) as Class;
				bitmapdata = new newClass(0, 0);
				return new flash.display.Bitmap(bitmapdata);
			}
			catch (e:Error)
			{
				trace("No Likage:" + linkage);
			}
			return null;
		}
		
		public function GetLinkageMovieClip(arg1:String):flash.display.MovieClip
		{
			var domain:flash.system.ApplicationDomain;
			var linkage:String;
			var newClass:Class;
			
			var loc1:*;
			domain = null;
			newClass = null;
			linkage = arg1;
			/*
			if (this.m_FileType != "swf") 
			{
				return null;
			}
			if (!this.IsLoad()) 
			{
				return null;
			}*/
			try 
			{
				domain = this.m_LoaderInfo.applicationDomain;
				newClass = domain.getDefinition(linkage) as Class;
				return new newClass();
			}
			catch (e:Error)
			{
				trace("No Likage:" + linkage);
			}
			return null;
		}
	
		public function GetLinkageSound(arg1:String):flash.media.Sound
		{
			var domain:flash.system.ApplicationDomain;
			var linkage:String;
			var newClass:Class;
			
			var loc1:*;
			domain = null;
			newClass = null;
			linkage = arg1;
		/*	if (this.m_FileType != "swf") 
			{
				return null;
			}
			if (!this.IsLoad()) 
			{
				return null;
			}*/
			try 
			{
				domain = this.m_LoaderInfo.applicationDomain;
				newClass = domain.getDefinition(linkage) as Class;
				return new newClass();
			}
			catch (e:Error)
			{
				trace("No Linkage：" + linkage);
			}
			return null;
		}
		
		public function Release():void
		{
			this.LoaderUnload();
			this.m_LoaderInfo.removeEventListener(flash.events.Event.COMPLETE, this.LoadComplete);
			this.m_LoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.LoadError);
			//this.m_LoaderInfo.removeEventListener(flash.events.ProgressEvent.PROGRESS, this.LoaderInfoProgress);
			this.m_Loader = null;
			return;
		}
		
		public function LoaderUnload():void
		{
			/*if (!(this.m_Bitmap == null) && this.contains(this.m_Bitmap)) 
			{
				this.removeChild(this.m_Bitmap);
				this.m_Bitmap = null;
			}*/
			if (this.contains(this.m_Loader)) 
			{
				this.removeChild(this.m_Loader);
				this.m_Loader.unload();
			}
			return;
		}
	}
}