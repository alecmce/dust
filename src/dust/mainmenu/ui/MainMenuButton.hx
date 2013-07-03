package dust.mainmenu.ui;

import flash.events.TouchEvent;
import flash.events.MouseEvent;
import flash.display.Sprite;
import flash.display.DisplayObject;
import dust.context.Config;
import dust.signals.Signal;

class MainMenuButton extends Sprite
{
    public var trigger:Signal<Class<Config>>;

    var config:Class<Config>;

    public function new(config:Class<Config>, art:DisplayObject)
    {
        trigger = new Signal<Class<Config>>();
        super();
        this.config = config;
        addChild(art);
    }

    public function enable()
        addEventListener(MouseEvent.CLICK, onClick)

        function onClick(_)
            trigger.dispatch(config)

    public function disable()
        removeEventListener(MouseEvent.CLICK, onClick)
}
