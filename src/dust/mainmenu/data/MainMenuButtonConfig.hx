package dust.mainmenu.data;

import nme.display.Graphics;
import nme.display.Sprite;
import dust.geom.data.Position;
import nme.geom.Point;
import dust.text.data.BitmapFont;
import dust.graphics.data.Paint;

class MainMenuButtonConfig
{
    public var font:BitmapFont;
    public var paint:Paint;
    public var size:Int;
    public var padding:Int;

    public function new(font:BitmapFont, paint:Paint, size:Int, padding:Int)
    {
        this.font = font;
        this.paint = paint;
        this.size = size;
        this.padding = padding;
    }

    public function setPosition(sprite:Sprite, index:Int)
    {
        var c = columns();
        var column = index % c;
        var row = Std.int(index / c);
        var offset = padding + size * 0.5;

        sprite.x = offset + (size + padding) * column;
        sprite.y = offset + (size + padding) * row;
    }

    public function columns():Int
        return Std.int((nme.Lib.current.stage.stageWidth - padding) / (size + padding))
}
