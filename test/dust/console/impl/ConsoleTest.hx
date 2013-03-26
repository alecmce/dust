package dust.console.impl;

import nme.display.Sprite;
import minject.Injector;
import dust.context.Context;
import dust.console.ui.ConsoleFormat;
import dust.console.ui.ConsoleInput;
import dust.console.ui.ConsoleOutput;

class ConsoleTest
{
    var output:Console;

    @Before public function before()
    {
        var injector = new Injector();

        var context = new Context(injector)
            .configure(ConsoleConfig)
            .start(new Sprite());

        output = injector.getInstance(Console);
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
