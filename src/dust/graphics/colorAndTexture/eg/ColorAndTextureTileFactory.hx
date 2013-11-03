package dust.graphics.colorAndTexture.eg;

import dust.graphics.control.XYPlaneSurfaceFactory;
import dust.graphics.renderer.data.RendererTexture;
import dust.graphics.data.Texture;
import dust.gui.data.Color;
import dust.graphics.data.Surface;
import dust.geom.data.Position;
import dust.math.Random;
import dust.entities.Entities;
import dust.entities.Entity;

class ColorAndTextureTileFactory
{
    @inject public var entities:Entities;
    @inject public var random:Random;
    @inject public var factory:XYPlaneSurfaceFactory;
    @inject public var textures:RendererTexture;

    public function make(x:Float, y:Float, z:Float, size:Float, color:Int, tx:Int, ty:Int):Entity
    {
        var entity = entities.require();
        entity.add(new Position(x, y, z));
        entity.add(factory.makeSquare(size));
        entity.add(new Color(color, 1.0));
        entity.add(textures.get('tx$tx$ty'));
        return entity;
    }
}
