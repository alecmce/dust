package dust.mainmenu.control;

import flash.events.MouseEvent;
import flash.events.TouchEvent;
import dust.app.data.App;
import dust.context.Config;
import dust.text.data.BitmapTextData;
import dust.mainmenu.ui.MainMenuButton;
import dust.text.control.BitmapTextFactory;
import dust.mainmenu.data.MainMenuButtonConfig;
import dust.graphics.data.Paint;
import dust.text.data.BitmapFont;
import flash.display.Bitmap;
import flash.display.Graphics;
import flash.display.Sprite;

class MainMenuButtonFactory
{
    @inject public var app:App;
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
            var width = buttonConfig.width;
            var height = buttonConfig.height;
            graphics.drawRect(-width * 0.5, -height * 0.5, width, height);
        }

        function makeLabel(name:String):Bitmap
        {
            var text = textFactory.make(new BitmapTextData(buttonConfig.font, name));
            if (text == null)
                return null;

            var bitmap = new Bitmap(text);
            bitmap.x = -text.width * 0.5;
            bitmap.y = -text.height * 0.5;
            return bitmap;
        }
}
