package dust.text.eg;

import dust.graphics.data.Painter;
import dust.graphics.data.BitmapPainter;
import dust.graphics.data.NoScaleBitmapPainter;
import dust.camera.data.Camera;
import dust.camera.CameraConfig;
import dust.camera.CameraConfig;
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

class BitmapTextExample implements DependentConfig
{
    @inject public var entities:Entities;
    @inject public var fontFactory:BitmapFontFactory;
    @inject public var bitmapFactory:BitmapTextFactory;
    @inject public var camera:Camera;

    public function dependencies():Array<Class<Config>>
        return [CameraConfig, MathConfig, BitmapTextConfig, PaintersConfig]

    public function configure()
    {
        var fontDefinition = Assets.getText('assets/michroma-24-white.fnt');
        var fontBitmap = Assets.getBitmapData('assets/michroma-24-white.png');
        var font = fontFactory.make(fontDefinition, [fontBitmap]);
        var bitmap = bitmapFactory.make(font, "Hello World!");
        var painter = new BitmapPainter(bitmap);

        var entity = entities.require();
        entity.add(new Position(0, 0));
        entity.addAsType(painter, Painter);
        entity.add(camera);
    }
}
