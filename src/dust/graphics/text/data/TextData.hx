package dust.graphics.text.data;

import snake.offsets.data.PositionOffset;
import snake.offsets.data.PositionOffset;
import dust.gui.data.Alignment;
import dust.gui.data.Color;
import dust.graphics.text.data.Font;

class TextData
{
    public var font:Font;
    public var offset:PositionOffset;
    public var text:String;

    public var color:Color;
    public var scale:Float;
    public var height:Int;
    public var alignment:Alignment;
    public var condense:Float;

    public function new(font:Font, offset:PositionOffset, label:String)
    {
        this.font = font;
        this.offset = offset;
        this.text = label;

        this.color = new Color(0xFFFFFF);
        this.scale = 1.0;
        this.alignment = Alignment.DEFAULT();
        this.condense = 0.0;
    }
}
