package dust.console.ui;

import dust.app.data.App;
import flash.display.BlendMode;
import dust.signals.Signal;

import flash.display.Sprite;
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldType;

class ConsoleInput extends Sprite
{
    public var command:Signal<String>;

    var format:ConsoleFormat;
    var container:Stage;
    var input:TextField;

    @inject
    public function new(app:App, format:ConsoleFormat, container:Stage)
    {
        super();
        this.format = format;
        this.container = container;
        this.input = makeInput(app);
        command = new Signal<String>();
    }

        function makeInput(app:App)
        {
            var input = new TextField();
            input.y = app.stageHeight - 20;
            input.width = app.stageWidth;
            input.height = 20;
            input.background = true;
            input.backgroundColor = 0x006600;
            input.defaultTextFormat = format;
            input.blendMode = BlendMode.LAYER;
            input.type = TextFieldType.INPUT;
            addChild(input);
            return input;
        }

    public function enable()
    {
        container.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        container.focus = input;
    }

    public function disable()
    {
        container.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        container.focus = container;
    }

        function onKeyDown(event:KeyboardEvent)
        {
            if (event.keyCode == 13)
            {
                var text = input.text;
                command.dispatch(text);
                input.text = "";
            }
        }
}
