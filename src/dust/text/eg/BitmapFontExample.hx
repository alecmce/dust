package dust.text.eg;

import dust.text.control.BitmapFonts;
import dust.graphics.data.Painter;
import dust.graphics.data.BitmapPainter;
import dust.camera.data.Camera;
import dust.camera.CameraConfig;
import dust.math.Random;
import dust.math.MathConfig;
import nme.display.Bitmap;
import dust.text.control.BitmapTextFactory;
import nme.Assets;
import dust.text.control.BitmapFontFactory;
import dust.geom.data.Position;
import dust.entities.api.Entities;
import dust.text.BitmapTextConfig;
import dust.graphics.PaintersConfig;
import dust.context.Config;
import dust.context.DependentConfig;

class BitmapFontExample implements DependentConfig
{
    static var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

    @inject public var entities:Entities;
    @inject public var fonts:BitmapFonts;
    @inject public var bitmapFactory:BitmapTextFactory;
    @inject public var camera:Camera;

    public function dependencies():Array<Class<Config>>
        return [CameraConfig, Fixed24WhiteMichromaFontConfig, PaintersConfig]

    public function configure()
    {
        var x = -200;
        var y = -100;

        var font = fonts.get(Fixed24WhiteMichromaFontConfig.FONT);

        var list = makeCharCodes();
        for (n in list)
        {
            var bitmap = font.getChar(n).data;
            var painter = new BitmapPainter(bitmap);

            var entity = entities.require();
            entity.add(new Position(x, y));
            entity.addAsType(painter, Painter);
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
