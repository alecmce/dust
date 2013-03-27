package dust.console.impl;

import nme.display.Sprite;
import dust.Injector;
import dust.context.Context;
import dust.console.ui.ConsoleFormat;
import dust.console.ui.ConsoleInput;
import dust.console.ui.ConsoleOutput;

class ConsoleTest
{
    var output:Console;

    @Before public function before()
    {
        var context = new Context()
            .configure(ConsoleConfig)
            .start(new Sprite());

        output = context.injector.getInstance(Console);
    }

    @Test public function canEnableConsole()
    {
        output.enable();
    }

    @Test public function canDisableConsole()
    {
        output.enable();
        output.disable();
    }
}
