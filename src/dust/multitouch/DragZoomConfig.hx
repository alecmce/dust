package dust.multitouch;

import dust.multitouch.control.DragZoomFactory;
import dust.context.Config;
import dust.context.DependentConfig;

class DragZoomConfig implements DependentConfig
{
    @inject public var factory:DragZoomFactory;

    public function dependencies():Array<Class<Config>>
        return [MultiTouchConfig];

    public function configure()
        factory.make()
}
