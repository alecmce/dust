package dust.ui.components;

import nme.Assets;
import nme.display.Sprite;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

class Label extends Sprite
{
    var textFormat:TextFormat;
    var textField:TextField;

    public function new(label:String)
    {
        super();

        mouseEnabled = false;
        mouseChildren = false;
        makeLabel(label);
    }

        function makeLabel(text:String)
        {
            var font = Assets.getFont("assets/Michroma.ttf");
            if (font == null)
                font = makeBlankFont();

            textFormat = new TextFormat(font.fontName, 15, 0xFFFFFF);
            textField = new TextField();
            textField.defaultTextFormat = textFormat;
            textField.selectable = false;
            textField.embedFonts = true;
            textField.text = text;
            textField.autoSize = TextFieldAutoSize.LEFT;
            textField.width = 250;
            textField.height = 30;
            addChild(textField);
        }

    public function setLabel(label:String)
    {
        textField.text = label;
    }

    function makeBlankFont():Font
    {
        #if (flash || js)
        return new Font();
        #else
        return new Font("Helvetica");
        #end
    }
}