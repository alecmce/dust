package dust.console.ui;

import dust.app.data.App;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.BlendMode;
import flash.text.TextFormat;
import flash.text.TextField;

class ConsoleOutput extends Sprite
{
    inline static var LINEBREAK = "\n";

    var lines:Array<String>;
    var format:ConsoleFormat;
    var background:Shape;
    var textfield:TextField;
    var previous:Int;

    @inject public function new(app:App, format:ConsoleFormat)
    {
        super();
        this.lines = new Array<String>();
        this.format = format;
        this.background = makeBackground(app);
        this.textfield = makeTextfield(app);
        this.previous = 0;
    }

    function makeBackground(app:App):Shape
    {
        var shape = new Shape();
        shape.graphics.beginFill(0x006600, 0.8);
        shape.graphics.drawRect(0, 0, app.stageWidth, app.stageHeight);
        shape.graphics.endFill();
        addChild(shape);
        return shape;
    }

    function makeTextfield(app:App):TextField
    {
        var textfield = new TextField();
        textfield.width = app.stageWidth;
        textfield.height = app.stageHeight - 20;
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