package dust.console.impl;

import dust.context.Context;
import nme.display.Sprite;
import dust.Injector;
import dust.console.ui.ConsoleFormat;
import dust.console.ui.ConsoleOutput;
import nme.text.TextFormat;

class ConsoleOutputTest
{
    var subject:ConsoleOutput;

    @Before public function before()
    {
        var context = new Context()
            .configure(ConsoleConfig)
            .start(new Sprite());

        subject = context.injector.getInstance(ConsoleOutput);
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
