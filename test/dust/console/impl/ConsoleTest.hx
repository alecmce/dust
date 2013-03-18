package dust.console.impl;

import dust.console.ui.ConsoleFormat;
import dust.console.ui.ConsoleInput;
import dust.console.ui.ConsoleOutput;

class ConsoleTest
{
    var map:ConsoleMap;
    var format:ConsoleFormat;
    var input:ConsoleInput;
    var output:ConsoleOutput;
    var subject:Console;

    @Before public function before()
    {
        map = new ConsoleMap();
        format = new ConsoleFormat();
        input = new ConsoleInput(format);
        output = new ConsoleOutput(format);
        subject = new Console(map, input, output);
    }

    @Test public function canEnableConsole()
    {
        subject.enable();
    }

    @Test public function canDisableConsole()
    {
        subject.enable();
        subject.disable();
    }
}
