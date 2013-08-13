package dust.text.eg;

import dust.graphics.PaintersUtil;
import dust.text.data.BitmapTextData;
import dust.text.control.BitmapFonts;
import dust.graphics.data.Painters;
import dust.graphics.data.BitmapPainter;
import dust.camera.data.Camera;
import dust.camera.CameraConfig;
import dust.math.MathConfig;
import dust.text.control.BitmapTextFactory;
import dust.geom.data.Position;
import dust.entities.Entities;
import dust.graphics.PaintersConfig;
import dust.context.Config;
import dust.context.DependentConfig;

using dust.graphics.PaintersUtil;

class BitmapTextExample implements DependentConfig
{
    @inject public var entities:Entities;
    @inject public var fonts:BitmapFonts;
    @inject public var bitmapFactory:BitmapTextFactory;
    @inject public var camera:Camera;

    public function dependencies():Array<Class<Config>>
        return [CameraConfig, MathConfig, Fixed24WhiteMichromaFontConfig, PaintersConfig];

    public function configure()
    {
        var font = fonts.get(Fixed24WhiteMichromaFontConfig.FONT);
        var data = new BitmapTextData(font, 'Hello World!');
        var bitmap = bitmapFactory.make(data);
        var painter = new BitmapPainter(bitmap);

        var entity = entities.require();
        entity.add(new Position(0, 0));
        entity.addPainter(painter);
        entity.add(camera);
    }
}
