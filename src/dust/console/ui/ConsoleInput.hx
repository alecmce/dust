package dust.console.ui;

import nme.display.BlendMode;
import dust.signals.Signal;

import nme.display.Sprite;
import nme.events.KeyboardEvent;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFieldType;

class ConsoleInput extends Sprite
{
    public var command:Signal<String>;

    var format:ConsoleFormat;
    var input:TextField;

    @inject
    public function new(format:ConsoleFormat)
    {
        super();
        this.format = format;
        this.input = makeInput();
        command = new Signal<String>();
    }

        function makeInput()
        {
            var width = nme.Lib.current.stage.stageWidth;
            var height = nme.Lib.current.stage.stageHeight;

            var input = new TextField();
            input.y = height - 20;
            input.width = width;
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
        var stage = nme.Lib.current.stage;
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.focus = input;
    }

    public function disable()
    {
        var stage = nme.Lib.current.stage;
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.focus = stage;
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
