package dust.interactive;

import dust.collections.api.Collection;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import dust.systems.System;
import dust.interactive.data.TouchInteractive;
import dust.interactive.data.Touchable;
import dust.systems.SystemsConfig;
import dust.systems.impl.Systems;
import dust.context.Config;
import dust.context.DependentConfig;

class TouchInteractiveDebugConfig implements DependentConfig
{
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
    {
        return [SystemsConfig, InteractiveConfig];
    }

    public function configure()
    {
        systems
            .map(DrawTouchInteractivesSystem, 0)
            .toCollection([Touchable, TouchInteractive]);
    }
}

class DrawTouchInteractivesSystem implements System
{
    @inject public var collection:Collection;
    @inject public var root:DisplayObjectContainer;

    var debug:Sprite;

    public function start()
    {
        debug = new Sprite();
        root.addChild(debug);
    }

    public function stop()
    {
        root.removeChild(debug);
        debug = null;
    }

    public function iterate(deltaTime:Float)
    {
        debug.graphics.clear();

        for (entity in collection)
        {
            var interactive:TouchInteractive = entity.get(TouchInteractive);
            interactive.draw(entity, debug.graphics);
        }
    }
}
