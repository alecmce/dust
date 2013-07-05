package dust.app;

import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import dust.app.data.AppTarget;
import flash.Vector;
import flash.ui.Multitouch;
import flash.display.Stage;
import dust.app.data.App;
import dust.Injector;
import dust.context.Config;

class AppConfig implements Config
{
    @inject public var injector:Injector;
    @inject public var stage:Stage;

    var app:App;

    public function configure()
    {
        app = makeApp();
        injector.mapValue(App, app);
        Multitouch.inputMode = getInputMode();
    }

        function makeApp():App
        {
            var width = stage.stageWidth;
            var height = stage.stageHeight;
            var isMultiTouch = flash.ui.Multitouch.supportsTouchEvents;

            var app = new App();
            app.stageWidth = Std.int(width);
            app.stageHeight = Std.int(height);
            app.target = getTarget(width, height, isMultiTouch);
            app.isMultiTouch = isMultiTouch;
            app.hasGestures = flash.ui.Multitouch.supportsGestureEvents;
            app.supportedGestures = toArray(flash.ui.Multitouch.supportedGestures);

            return app;
        }

            function getTarget(width:Int, height:Int, isMultiTouch:Bool):AppTarget
            {
                var max = width > height ? width : height;
                return if (max == 2048 && isMultiTouch)
                    AppTarget.IPAD_RETINA;
                else if (max == 1024 && isMultiTouch)
                    AppTarget.IPAD_NORMAL;
                else
                    AppTarget.WEB;
            }

            function toArray(list:Vector<String>):Array<String>
            {
                var output = new Array<String>();
                if (list == null)
                    return output;

                for (item in list)
                    output.push(item);
                return output;
            }

        function getInputMode():MultitouchInputMode
        {
            return if (app.isMultiTouch)
                MultitouchInputMode.TOUCH_POINT;
            else
                MultitouchInputMode.NONE;
        }
}
