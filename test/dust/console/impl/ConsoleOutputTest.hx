package dust.console.impl;

import dust.console.ui.ConsoleFormat;
import dust.console.ui.ConsoleOutput;
import nme.text.TextFormat;

class ConsoleOutputTest
{
    var subject:ConsoleOutput;

    @Before public function before()
    {
        var format = new ConsoleFormat();
        subject = new ConsoleOutput(format);
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
