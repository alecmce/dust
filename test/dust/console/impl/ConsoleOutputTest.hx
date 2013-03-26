package dust.console.impl;

import dust.context.Context;
import nme.display.Sprite;
import minject.Injector;
import dust.console.ui.ConsoleFormat;
import dust.console.ui.ConsoleOutput;
import nme.text.TextFormat;

class ConsoleOutputTest
{
    var subject:ConsoleOutput;

    @Before public function before()
    {
        var injector = new Injector();

        var context = new Context(injector)
            .configure(ConsoleConfig)
            .start(new Sprite());

        subject = injector.getInstance(ConsoleOutput);
    }

    @Test public function writeAppendsText()
    {
        subject.write("hello");
    }

    @Test public function canSpecifyColorForText()
    {
        subject.write("hello yellow", 0xFFEE00);
    }

    @Test public function overwriteOverwritesText()
    {
        subject.write("hello");
        subject.overwrite("world");
    }
}
