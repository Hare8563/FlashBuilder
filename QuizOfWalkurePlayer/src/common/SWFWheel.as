package common 
{
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.geom.*;
    
    public class SWFWheel extends Object
    {
        
        {
            _browserScroll = true;
        }

        private static function checkBrowserScroll():Boolean
        {
            return _browserScroll;
        }

        public static function set browserScroll(arg1:Boolean):void
        {
            _browserScroll = arg1;
            return;
        }

        public static function get isReady():Boolean
        {
            return !(_stage == null);
        }

        public static function initialize(arg1:flash.display.Stage):void
        {
            if (!available || isReady) 
            {
                return;
            }
            _stage = arg1;
            flash.external.ExternalInterface.call(DEFINE_LIBRARY_FUNCTION);
            flash.external.ExternalInterface.call(EXECUTE_LIBRARY_FUNCTION, flash.external.ExternalInterface.objectID);
            flash.external.ExternalInterface.addCallback("checkBrowserScroll", checkBrowserScroll);
            _state = flash.external.ExternalInterface.call(GET_STATE_FUNCTION, flash.external.ExternalInterface.objectID);
            flash.external.ExternalInterface.addCallback("triggerMouseEvent", triggerMouseEvent);
            return;
        }

        public static function get browserScroll():Boolean
        {
            return _browserScroll;
        }

        public static function get state():int
        {
            return _state;
        }

        private static function triggerMouseEvent(arg1:Number, arg2:Boolean, arg3:Boolean, arg4:Boolean):void
        {
            var loc3:*=null;
            if (_state == STATE_IF_NEEDED && _browserScroll) 
            {
                return;
            }
            var loc1:*=_stage.getObjectsUnderPoint(new flash.geom.Point(_stage.mouseX, _stage.mouseY));
            var loc2:*=loc1.pop() as flash.display.DisplayObject;
            while (loc2 != null) 
            {
                loc3 = loc2 as flash.display.InteractiveObject;
                if (loc3) 
                {
                    break;
                }
                loc2 = loc2.parent;
            }
            if (!loc3) 
            {
                return;
            }
            var loc4:*=new flash.events.MouseEvent(flash.events.MouseEvent.MOUSE_WHEEL, true, false, loc3.mouseX, loc3.mouseY, null, arg2, arg3, arg4, false, int(arg1));
            loc3.dispatchEvent(loc4);
            return;
        }

        public static function get available():Boolean
        {
            var f:Boolean;

            var loc1:*;
            f = false;
            if (!flash.external.ExternalInterface.available) 
            {
                return f;
            }
            try 
            {
                f = Boolean(flash.external.ExternalInterface.call("function(){return true;}"));
            }
            catch (e:Error)
            {
                trace("Warning: turn off SWFWheel because can\'t access external interface.");
            }
            return f;
        }

        public function SWFWheel()
        {
            super();
            return;
        }

        public static const STATE_IF_NEEDED:int=1;

        public static const GET_STATE_FUNCTION:String="SWFWheel.getState";

        public static const STATE_HACKED:int=2;

        public static const STATE_NATIVE:int=0;

        public static const EXECUTE_LIBRARY_FUNCTION:String="SWFWheel.join";

        public static const DEFINE_LIBRARY_FUNCTION:String="function(){if(window.SWFWheel)return;var win=window,doc=document,nav=navigator;var SWFWheel=window.SWFWheel=function(id){this.setUp(id);if(SWFWheel.browser.msie)this.bind4msie();else this.bind()};SWFWheel.prototype={setUp:function(id){var el=SWFWheel.retrieveObject(id);if(el.nodeName.toLowerCase()==\'embed\'||SWFWheel.browser.safari)el=el.parentNode;this.target=el;this.eventType=SWFWheel.browser.mozilla?\'DOMMouseScroll\':\'mousewheel\'},bind:function(){this.target.addEventListener(this.eventType,function(evt){var target,name,delta=0;if(/XPCNativeWrapper/.test(evt.toString())){var k=evt.target.getAttribute(\'id\')||evt.target.getAttribute(\'name\');if(!k)return;target=SWFWheel.retrieveObject(k)}else{target=evt.target}name=target.nodeName.toLowerCase();if(name!=\'object\'&&name!=\'embed\')return;if(!target.checkBrowserScroll()){evt.stopPropagation();evt.preventDefault();evt.returnValue=false}if(!target.triggerMouseEvent)return;switch(true){case SWFWheel.browser.mozilla:delta=-evt.detail;break;case SWFWheel.browser.opera:delta=evt.wheelDelta/40;break;default:delta=evt.wheelDelta/80;break}target.triggerMouseEvent(delta,evt.ctrlKey,evt.altKey,evt.shiftKey)},false)},bind4msie:function(){var _wheel,_unload,target=this.target;_wheel=function(){var evt=win.event,delta=0,name=evt.srcElement.nodeName.toLowerCase();if(name!=\'object\'&&name!=\'embed\')return;if(!target.checkBrowserScroll()){evt.returnValue=false;evt.cancelBubble=true}if(!target.triggerMouseEvent)return;delta=evt.wheelDelta/40;target.triggerMouseEvent(delta,evt.ctrlKey,evt.altKey,evt.shiftKey)};_unload=function(){target.detachEvent(\'onmousewheel\',_wheel);win.detachEvent(\'onunload\',_unload)};target.attachEvent(\'onmousewheel\',_wheel);win.attachEvent(\'onunload\',_unload)}};SWFWheel.browser=(function(){var ua=nav.userAgent.toLowerCase(),pl=nav.platform.toLowerCase(),version,pv=[0,0,0];if(nav.plugins&&nav.plugins[\'Shockwave Flash\']){version=nav.plugins[\'Shockwave Flash\'].description.replace(/^.*\\s+(\\S+\\s+\\S+$)/,\'$1\');pv[0]=parseInt(version.replace(/^(.*)\\..*$/,\'$1\'),10);pv[1]=parseInt(version.replace(/^.*\\.(.*)\\s.*$/,\'$1\'),10);pv[2]=/[a-z-A-Z]/.test(version)?parseInt(version.replace(/^.*[a-zA-Z]+(.*)$/,\'$1\'),10):0}else if(win.ActiveXObject){try{var axo=new ActiveXObject(\'ShockwaveFlash.ShockwaveFlash\');if(axo){version=axo.GetVariable(\'$version\');if(version){version=version.split(\' \')[1].split(\',\');pv[0]=parseInt(version[0],10);pv[1]=parseInt(version[1],10);pv[2]=parseInt(version[2],10)}}}catch(e){}}return{win:pl?/win/.test(pl):/win/.test(ua),mac:pl?/mac/.test(pl):/mac/.test(ua),playerVersion:pv,version:(ua.match(/.+(?:rv|it|ra|ie)[/:\\s]([\\d.]+)/)||[0,\'0\'])[1],chrome:/chrome/.test(ua),stainless:/stainless/.test(ua),safari:/webkit/.test(ua)&&!/(chrome|stainless)/.test(ua),opera:/opera/.test(ua),msie:/msie/.test(ua)&&!/opera/.test(ua),mozilla:/mozilla/.test(ua)&&!/(compatible|webkit)/.test(ua)}})();SWFWheel.join=function(id){var t=setInterval(function(){if(SWFWheel.retrieveObject(id)){clearInterval(t);new SWFWheel(id)}},0)};SWFWheel.getState=function(id){var STATE_HACKED=2,STATE_IF_NEEDED=1,STATE_NATIVE=0,br=SWFWheel.browser,fp=br.playerVersion;if(br.mac){if(fp[0]>=10&&fp[1]>=1){if(br.safari||br.stainless)return STATE_NATIVE;else if(br.chrome)return STATE_IF_NEEDED;else return STATE_HACKED}else{return STATE_HACKED}}if(!(fp[0]>=10&&fp[1]>=1)&&SWFWheel.browser.safari)return STATE_HACKED;var el=SWFWheel.retrieveObject(id),name=el.nodeName.toLowerCase(),wmode=\'\';if(name==\'object\'){var k,param,params=el.getElementsByTagName(\'param\'),len=params.length;for(var i=0;i<len;i++){param=params[i];if(param.parentNode!=el)continue;k=param.getAttribute(\'name\');wmode=param.getAttribute(\'value\')||\'\';if(/wmode/i.test(k))break}}else if(name==\'embed\'){wmode=el.getAttribute(\'wmode\')||\'\'}if(br.msie){if(/transparent/i.test(wmode))return STATE_HACKED;else if(/opaque/i.test(wmode))return STATE_IF_NEEDED;else return STATE_NATIVE}else{if(/opaque|transparent/i.test(wmode))return STATE_HACKED;else return STATE_NATIVE}};SWFWheel.retrieveObject=function(id){var el=doc.getElementById(id);if(!el){var nodes=doc.getElementsByTagName(\'embed\'),len=nodes.length;for(var i=0;i<len;i++){if(nodes[i].getAttribute(\'name\')==id){el=nodes[i];break}}}return el}}";

        public static const VERSION:String="1.5";

        private static var _browserScroll:Boolean=true;

        private static var _state:int;

        private static var _stage:flash.display.Stage;
    }
}
