package dust.graphics.text.eg;

import dust.graphics.text.control.TextFactory;
import dust.graphics.text.control.Fonts;
import dust.graphics.data.Painters;
import dust.graphics.data.NoScaleBitmapPainter;
import dust.camera.data.Camera;
import dust.camera.CameraConfig;
import dust.math.Random;
import dust.math.MathConfig;
import flash.display.Bitmap;
import openfl.Assets;
import dust.graphics.text.control.FontFactory;
import dust.geom.data.Position;
import dust.entities.Entities;
import dust.graphics.text.TextConfig;
import dust.graphics.PaintersConfig;
import dust.context.Config;
import dust.context.DependentConfig;

class NoScaleBitmapFontExample implements DependentConfig
{
    static var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

    @inject public var entities:Entities;
    @inject public var fonts:Fonts;
    @inject public var textFactory:TextFactory;
    @inject public var camera:Camera;

    public function dependencies():Array<Class<Config>>
        return [CameraConfig, Fixed24WhiteMichromaFontConfig, PaintersConfig];

    public function configure()
    {
        var font = fonts.get(Fixed24WhiteMichromaFontConfig.FONT);

        var x = -200;
        var y = -100;

        var list = makeCharCodes();
        for (n in list)
        {
            var bitmap = font.getChar(n).data;
            var painter = new NoScaleBitmapPainter(bitmap);

            var entity = entities.require();
            entity.add(new Position(x, y));
            entity.add(new Painters().add(painter));
            entity.add(camera);

            x += 50;
            if (x > 200)
            {
                x = -200;
                y += 30;
            }
        }
    }

        function makeCharCodes():Array<Int>
        {
            var codes = new Array<Int>();
            for (i in 0...chars.length)
                codes.push(chars.charCodeAt(i));
            return codes;
        }
}
