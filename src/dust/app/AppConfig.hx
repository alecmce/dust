package dust.app;

import nme.ui.MultitouchInputMode;
import dust.app.data.AppTarget;
import nme.Vector;
import nme.ui.Multitouch;
import dust.app.data.AppData;
import dust.Injector;
import dust.context.Config;

class AppConfig implements Config
{
    @inject public var injector:Injector;

    var app:AppData;

    public function configure()
    {
        app = makeApp();
        injector.mapValue(AppData, app);
        Multitouch.inputMode = getInputMode();
    }

        function makeApp():AppData
        {
            var width = nme.Lib.current.stage.stageWidth;
            var height = nme.Lib.current.stage.stageHeight;
            var isMultiTouch = nme.ui.Multitouch.supportsTouchEvents;

            var app = new AppData();
            app.stageWidth = Std.int(width);
            app.stageHeight = Std.int(height);
            app.target = getTarget(width, height, isMultiTouch);
            app.isMultiTouch = isMultiTouch;
            app.hasGestures = nme.ui.Multitouch.supportsGestureEvents;
            app.supportedGestures = toArray(nme.ui.Multitouch.supportedGestures);

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
