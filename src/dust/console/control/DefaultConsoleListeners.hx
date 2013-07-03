package dust.console.control;

import dust.console.impl.Console;

import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

class DefaultConsoleListeners
{
    var console:Console;

    public function new(console:Console)
        this.console = console

    public function enable()
    {
        var stage = nme.Lib.current.stage;
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.focus = stage;
    }

        function onKeyDown(event:KeyboardEvent)
        {
            if (event.keyCode == Keyboard.TAB)
                toggleConsole();
        }

            function toggleConsole()
                console.isEnabled ? console.disable() : console.enable()

    public function disable()
    {
        nme.Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
    }
}

