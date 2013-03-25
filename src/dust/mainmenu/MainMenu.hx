package dust.mainmenu;

import dust.mainmenu.ui.MainMenuButton;
import nme.events.MouseEvent;
import nme.display.Sprite;
import dust.mainmenu.control.MainMenuButtonFactory;
import dust.signals.SignalVoid;
import nme.ui.Keyboard;
import dust.ui.components.Label;
import dust.ui.components.VerticalList;
import dust.context.Config;
import dust.signals.Signal;

import nme.events.KeyboardEvent;

class MainMenu extends Sprite
{
    public var reset(default, null):SignalVoid;
    public var selected(default, null):Signal<Class<Config>>;

    var factory:MainMenuButtonFactory;
    var buttons:Sprite;
    var back:MainMenuButton;
    var list:Array<MainMenuButton>;
    var isEnabled:Bool;

    @inject
    public function new(factory:MainMenuButtonFactory)
    {
        selected = new Signal<Class<Config>>();
        reset = new SignalVoid();

        this.factory = factory;
        buttons = new Sprite();
        back = factory.make('back', 0, null);
        back.trigger.bind(onBack);
        list = new Array<MainMenuButton>();
        isEnabled = false;

        super();
        addChild(buttons);
        addChild(back);
    }

        function onBack(config:Class<Config> = null)
        {
            enable();
            reset.dispatch();
        }

    public function add(label:String, config:Class<Config>):MainMenu
    {
        var button = factory.make(label, list.length, config);
        list.push(button);
        buttons.addChild(button);
        button.trigger.bind(onTrigger);
        return this;
    }

        function onTrigger(config:Class<Config>)
        {
            disable();
            selected.dispatch(config);
        }

    public function enable()
    {
        if (!isEnabled)
            enableMenu();
        isEnabled = true;
    }

        function enableMenu()
        {
            back.visible = false;
            back.disable();

            buttons.visible = true;
            for (item in list)
                item.enable();
        }

    public function disable()
    {
        if (isEnabled)
            disableMenu();
        isEnabled = false;
    }

        function disableMenu()
        {
            back.visible = true;
            back.enable();

            buttons.visible = false;
            for (item in list)
                item.disable();
        }


}