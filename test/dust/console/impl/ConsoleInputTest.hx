package dust.console.impl;

import nme.display.Sprite;
import dust.context.Context;
import dust.Injector;
import dust.console.ui.ConsoleFormat;
import dust.console.ui.ConsoleInput;
import nme.events.KeyboardEvent;
import nme.events.KeyboardEvent;
import nme.text.TextFormat;

class ConsoleInputTest
{
    var input:ConsoleInput;

    @Before public function before()
    {
        var injector = new Injector();

        var context = new Context(injector)
            .configure(ConsoleConfig)
            .start(new Sprite());

        input = injector.getInstance(ConsoleInput);
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
