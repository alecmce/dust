package dust.text.eg;

import dust.text.control.BitmapTextFactory;
import nme.Assets;
import dust.text.control.BitmapFontFactory;
import dust.canvas.data.BitmapPainter;
import dust.geom.data.Position;
import dust.entities.api.Entities;
import dust.text.BitmapTextConfig;
import dust.canvas.PrioritizedPaintersConfig;
import dust.context.Config;
import dust.context.DependentConfig;

class BitmapTextExample implements DependentConfig
{
    @inject public var entities:Entities;
    @inject public var fontFactory:BitmapFontFactory;
    @inject public var bitmapFactory:BitmapTextFactory;

    public function dependencies():Array<Class<Config>>
        return [BitmapTextConfig, PrioritizedPaintersConfig]

    public function configure()
    {
        var fontDefinition = Assets.getText('michroma-24-white.fnt');
        var fontBitmap = Assets.getBitmapData('michroma-24-white.png');
        var font = fontFactory.make(fontDefinition, [fontBitmap]);

        var bitmap = bitmapFactory.make(font, "Hello World!");
        var painter = new BitmapPainter(bitmap);

        var entity = entities.require();
        entity.add(new Position());
        entity.add(painter);
    }
}
