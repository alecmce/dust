package dust.graphics.text.eg;

import dust.graphics.text.data.Font;
import dust.gui.data.VAlign;
import dust.gui.data.HAlign;
import dust.gui.data.Alignment;
import dust.graphics.text.data.TextData;
import game.GameConfig;
import dust.gui.data.Color;
import dust.entities.Entity;
import dust.graphics.text.control.TextFactory;
import dust.graphics.PaintersUtil;
import dust.graphics.text.control.Fonts;
import dust.camera.CameraConfig;
import dust.math.MathConfig;
import dust.geom.data.Position;
import dust.context.Config;
import dust.context.DependentConfig;

using dust.graphics.PaintersUtil;

class TextExample implements DependentConfig
{
    @inject public var fonts:Fonts;
    @inject public var textFactory:TextFactory;

    var font:Font;
    var position:Position;

    public function dependencies():Array<Class<Config>>
        return [CameraConfig, MathConfig, GameConfig];

    public function configure()
    {
        font = fonts.get(GameConfig.TITLE);
        position = new Position(0, 0);

        makeTopLeft();
        makeCentered();
        makeBottomRight();
    }

    function makeTopLeft()
    {
        var color = new Color(0xFF0000);

        var data = new TextData(font, 'Hello World!', color, position);
        data.alignment = new Alignment(HAlign.LEFT, VAlign.TOP);
        textFactory.make(data);
    }

    function makeCentered()
    {
        var color = new Color(0x00FF00);
        color.alpha = 0.5;

        var data = new TextData(font, 'Hello World!', color, position);
        data.alignment = new Alignment(HAlign.CENTER, VAlign.MIDDLE);
        textFactory.make(data);
    }

    function makeBottomRight()
    {
        var color = new Color(0x0000FF);

        var data = new TextData(font, 'Hello World!', color, position);
        data.alignment = new Alignment(HAlign.RIGHT, VAlign.BOTTOM);
        textFactory.make(data);
    }
}
