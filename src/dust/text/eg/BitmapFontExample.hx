package dust.text.eg;

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
    @inject public var entities:Entities;
    @inject public var fontFactory:BitmapFontFactory;
    @inject public var bitmapFactory:BitmapTextFactory;
    @inject public var camera:Camera;

    public function dependencies():Array<Class<Config>>
        return [CameraConfig, BitmapTextConfig, PaintersConfig]

    public function configure()
    {
        var fontDefinition = Assets.getText('assets/michroma-24-white.fnt');
        var fontBitmap = Assets.getBitmapData('assets/michroma-24-white.png');
        var font = fontFactory.make(fontDefinition, [fontBitmap]);

        var x = -200;
        var y = -100;

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
            var a = 'a'.charCodeAt(0);
            var z = 'z'.charCodeAt(0);
            var A = 'A'.charCodeAt(0);
            var Z = 'Z'.charCodeAt(0);

            var list = new Array<Int>();
            for (n in a...z) list.push(n);
            for (n in A...Z) list.push(n);
            return list;
        }
}
