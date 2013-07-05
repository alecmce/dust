package dust.console.impl;

import dust.console.ui.ConsoleOutput;
import dust.console.ui.ConsoleInput;
import dust.signals.Signal;
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.display.Stage;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.KeyboardEvent;

class Console extends Sprite
{
    public var isEnabled(default, null):Bool;

    var map:ConsoleMap;
    var log:ConsoleLog;
    var output:ConsoleOutput;
    var input:ConsoleInput;
    var container:Stage;

    @inject
    public function new(map:ConsoleMap, input:ConsoleInput, output:ConsoleOutput, stage:Stage)
    {
        super();

        this.map = map;
        this.output = output;
        this.input = input;
        this.container = stage;
        log = new ConsoleLog();
        addChild(output);
        addChild(input);
        input.command.bind(onCommand);
    }

    public function write(value:String, ?color:Int = 0xFFFFFF)
    {
        output.write(value, color);
    }

    public function enable()
    {
        if (!isEnabled)
        {
            container.addChild(this);
            input.enable();
            isEnabled = true;
        }
    }

    public function disable()
    {
        if (isEnabled)
        {
            container.removeChild(this);
            input.disable();
            isEnabled = false;
        }
    }

        function onCommand(text:String)
        {
            log.log(text);
            output.write("> " + text, 0xFFEE00);

            var values = text.split(" ");
            var name = values[0];
            var data = values.length > 1 ? values[1].split(",") : [];
            map.execute(name, data);
        }
}