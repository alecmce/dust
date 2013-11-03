package dust.graphics.colorAndTexture.systems;

import dust.entities.Entity;
import dust.collections.api.CollectionListeners;
import dust.graphics.data.Surface;
import dust.graphics.data.SurfaceVertex;
import dust.graphics.data.Texture;
import flash.geom.Rectangle;

class ApplyTextureToSurface implements CollectionListeners
{
    public function onEntityAdded(entity:Entity)
    {
        var surface:Surface = entity.get(Surface);
        var region:Rectangle = entity.get(Texture).region;

        for (vertex in surface.getVertices())
            applyTemplateRegion(vertex, region);
    }

        inline function applyTemplateRegion(vertex:SurfaceVertex, region:Rectangle)
        {
            var template = vertex.template;
            vertex.texture.x = region.left + template.x * region.width;
            vertex.texture.y = region.top + template.y * region.height;
        }

    public function onEntityRemoved(entity:Entity)
    {
        // noop
    }
}
