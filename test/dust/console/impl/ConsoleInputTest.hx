package dust.console.impl;

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
        var format = new ConsoleFormat();
        input = new ConsoleInput(format);
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
