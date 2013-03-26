package dust.app;

import nme.Vector;
import nme.ui.Multitouch;
import dust.app.data.AppData;
import minject.Injector;
import dust.context.Config;

class AppConfig implements Config
{
    @inject public var injector:Injector;

    public function configure()
        injector.mapValue(AppData, makeApp())

        function makeApp():AppData
        {
            var app = new AppData();
            app.deviceWidth = Std.int(nme.system.Capabilities.screenResolutionX);
            app.deviceHeight = Std.int(nme.system.Capabilities.screenResolutionY);
            app.isMultiTouch = nme.ui.Multitouch.supportsTouchEvents;
            app.hasGestures = nme.ui.Multitouch.supportsGestureEvents;
            app.supportedGestures = toArray(nme.ui.Multitouch.supportedGestures);
            return app;
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
}
