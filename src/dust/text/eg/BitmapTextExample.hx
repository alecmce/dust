package dust.text.eg;

import dust.text.control.BitmapFonts;
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
    @inject public var fonts:BitmapFonts;
    @inject public var bitmapFactory:BitmapTextFactory;
    @inject public var camera:Camera;

    public function dependencies():Array<Class<Config>>
        return [CameraConfig, MathConfig, Michroma24WhiteFontConfig, PaintersConfig]

    public function configure()
    {
        var font = fonts.get(Michroma24WhiteFontConfig.MICHROMA_24_WHITE);
        var bitmap = bitmapFactory.make(font, "Hello World!");
        var painter = new BitmapPainter(bitmap);

        var entity = entities.require();
        entity.add(new Position(0, 0));
        entity.addAsType(painter, Painter);
        entity.add(camera);
    }
}
