package dust.ui.eg;

import dust.ui.components.ComponentConfig;
import dust.console.ConsoleConfig;
import dust.console.impl.Console;
import nme.display.DisplayObjectContainer;
import dust.ui.components.Slider;
import dust.context.Config;
import dust.context.DependentConfig;

class UIExample implements DependentConfig
{
    @inject public var root:DisplayObjectContainer;
    @inject public var config:ComponentConfig;
    @inject public var console:Console;

    public function dependencies():Array<Class<Config>>
        return [UIConfig, ConsoleConfig]

    public function configure()
    {
        var slider = new Slider(onUpdate, config, 0, 200, 50);
        slider.x = 200;
        slider.y = 200;
        slider.enable();
        root.addChild(slider);
    }

        function onUpdate(value:Float)
            console.write('slider.value = ' + value)
}
