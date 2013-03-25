package dust.mainmenu.control;

import dust.context.Config;
import dust.mainmenu.ui.MainMenuButton;
import dust.text.control.BitmapTextFactory;
import dust.mainmenu.data.MainMenuButtonConfig;
import dust.graphics.data.Paint;
import dust.text.data.BitmapFont;
import nme.display.Bitmap;
import nme.display.Graphics;
import nme.display.Sprite;

class MainMenuButtonFactory
{
    @inject public var textFactory:BitmapTextFactory;
    @inject public var buttonConfig:MainMenuButtonConfig;

    public function make(name:String, position:Int, config:Class<Config> = null):MainMenuButton
    {
        var sprite = makeSprite(name);
        buttonConfig.setPosition(sprite, position);
        return new MainMenuButton(config, sprite);
    }

        function makeSprite(name:String):Sprite
        {
            var sprite = new Sprite();
            buttonConfig.paint.paint(buttonConfig, sprite.graphics, paintBackground);

            var label = makeLabel(name);
            if (label != null)
                sprite.addChild(label);

            return sprite;
        }

        function paintBackground(buttonConfig:MainMenuButtonConfig, graphics:Graphics)
        {
            var size = buttonConfig.size;
            graphics.drawRect(-size * 0.5, -size * 0.5, size, size);
        }

        function makeLabel(name:String):Bitmap
        {
            var text = textFactory.make(buttonConfig.font, name);
            if (text == null)
                return null;

            var bitmap = new Bitmap(text);
            bitmap.x = -text.width * 0.5;
            bitmap.y = -text.height * 0.5;
            return bitmap;
        }
}
