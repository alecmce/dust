package dust.console.ui;

import nme.display.Shape;
import nme.display.Sprite;
import nme.display.BlendMode;
import nme.text.TextFormat;
import nme.text.TextField;

class ConsoleOutput extends Sprite
{
    inline static var LINEBREAK = "\n";

    var lines:Array<String>;
    var format:ConsoleFormat;
    var background:Shape;
    var textfield:TextField;
    var previous:Int;

    @inject
    public function new(format:ConsoleFormat)
    {
        super();
        this.lines = new Array<String>();
        this.format = format;
        this.background = makeBackground();
        this.textfield = makeTextfield();
        this.previous = 0;
    }

    function makeBackground():Shape
    {
        var width = nme.Lib.current.stage.stageWidth;
        var height = nme.Lib.current.stage.stageHeight;

        var shape = new Shape();
        shape.graphics.beginFill(0x006600, 0.8);
        shape.graphics.drawRect(0, 0, width, height);
        shape.graphics.endFill();
        addChild(shape);
        return shape;
    }

    function makeTextfield():TextField
    {
        var width = nme.Lib.current.stage.stageWidth;
        var height = nme.Lib.current.stage.stageHeight;

        var textfield = new TextField();
        textfield.width = width;
        textfield.height = height - 20;
        textfield.background = false;
        textfield.defaultTextFormat = format;
        textfield.multiline = true;
        textfield.blendMode = BlendMode.LAYER;
        addChild(textfield);
        return textfield;
    }

    public function write(value:String, ?color:Int = 0xFFFFFF)
    {
        lines.push(value);
        textfield.text = lines.join(LINEBREAK);
    }

    public function overwrite(value:String, ?color:Int = 0xFFFFFF)
    {
        lines[lines.length - 1] = value;
        textfield.text = lines.join(LINEBREAK);
    }
}