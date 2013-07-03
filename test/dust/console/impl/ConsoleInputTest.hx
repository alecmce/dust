package dust.console.impl;

import flash.display.Sprite;
import dust.context.Context;
import dust.Injector;
import dust.console.ui.ConsoleFormat;
import dust.console.ui.ConsoleInput;
import flash.events.KeyboardEvent;
import flash.events.KeyboardEvent;
import flash.text.TextFormat;

class ConsoleInputTest
{
    var input:ConsoleInput;

    @Before public function before()
    {
        var context = new Context()
            .configure(ConsoleConfig)
            .start(new Sprite());

        input = context.injector.getInstance(ConsoleInput);
    }

    @Test public function canEnable()
    {
        input.enable();
    }

    @Test public function canDisable()
    {
        input.enable();
        input.disable();
    }

    @Test public function canBindToCommandOutput()
    {
        input.command.bindOnce(function(data:String) {});
    }
}
