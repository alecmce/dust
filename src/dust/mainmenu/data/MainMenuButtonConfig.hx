package dust.mainmenu.data;

import dust.app.data.App;
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
    public var width:Int;
    public var height:Int;
    public var padding:Int;

    var app:App;

    public function new(app:App, font:BitmapFont, paint:Paint, width:Int, height:Int, padding:Int)
    {
        this.app = app;

        this.font = font;
        this.paint = paint;
        this.width = width;
        this.height = height;
        this.padding = padding;
    }

    public function setPosition(sprite:Sprite, index:Int)
    {
        var r = rows();
        var row = index % r;
        var column = Std.int(index / r);

        sprite.x = padding + width * 0.5 + (width + padding) * column;
        sprite.y = padding + height * 0.5 + (height + padding) * row;
    }

    public function rows():Int
        return Std.int((app.stageHeight - padding) / (height + padding))
}
