package dust.console.control;

import dust.console.impl.Console;

import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

class DefaultConsoleListeners
{
    var stage:Stage;
    var console:Console;

    public function new(stage:Stage, console:Console)
    {
        this.stage = stage;
        this.console = console;
    }

    public function enable()
    {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.focus = stage;
    }

        function onKeyDown(event:KeyboardEvent)
        {
            if (event.keyCode == Keyboard.TAB)
                toggleConsole();
        }

            function toggleConsole()
                console.isEnabled ? console.disable() : console.enable();

    public function disable()
    {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
    }
}

