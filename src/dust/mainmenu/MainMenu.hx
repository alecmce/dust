package dust.mainmenu;

import dust.signals.SignalVoid;
import nme.ui.Keyboard;
import dust.ui.components.Label;
import dust.ui.components.VerticalList;
import dust.context.Config;
import dust.signals.Signal;

import nme.events.KeyboardEvent;

class MainMenu
{
    public var reset(default, null):SignalVoid;
    public var selected(default, null):Signal<Class<Config>>;

    var hash:IntHash<Class<Config>>;
    var list:VerticalList;
    var disabled:Label;
    var isEnabled:Bool;

    public function new()
    {
        selected = new Signal<Class<Config>>();
        reset = new SignalVoid();

        hash = new IntHash<Class<Config>>();

        list = new VerticalList([], 3);
        list.mouseEnabled = false;
        list.mouseChildren = false;

        disabled = new Label("[escape] returns to menu");

        var stage = nme.Lib.current.stage;
        stage.addChild(list);
        stage.addChild(disabled);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

        enable();
    }

    public function enable()
    {
        isEnabled = true;
        list.visible = true;
        disabled.visible = false;
    }

    public function disable()
    {
        isEnabled = false;
        list.visible = false;
        disabled.visible = true;
    }

        function onKeyDown(event:KeyboardEvent)
        {
            if (isEnabled)
                checkForOption(event.keyCode);
            else
                checkForEnable(event.keyCode);
        }

            function checkForOption(keyCode)
            {
                if (hash.exists(keyCode))
                {
                    disable();
                    selected.dispatch(hash.get(keyCode));
                }
            }

            function checkForEnable(keyCode)
            {
                if (keyCode == Keyboard.ESCAPE)
                {
                    enable();
                    reset.dispatch();
                }
            }

    public function add(key:String, label:String, config:Class<Config>):MainMenu
    {
        var item = new Label(key + ". " + label);
        list.addItem(item);
        hash.set(StringTools.fastCodeAt(key, 0), config);
        return this;
    }

}