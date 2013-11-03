package dust.graphics.colorAndTexture.systems;

import dust.systems.System;
import dust.collections.api.Collection;
import dust.geom.data.Position;
import dust.graphics.data.Surface;
import dust.graphics.data.IndexTriple;
import dust.graphics.data.SurfaceVertex;
import dust.graphics.data.Texture;
import dust.graphics.data.Surface;
import dust.graphics.renderer.data.RenderableBuffer;
import dust.gui.data.Color;

class UpdateRenderBufferSystem implements System
{
    @inject public var collection:Collection;
    @inject public var buffer:RenderableBuffer;

    var working:Array<Float>;

    public function new()
    {
        working = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    }

    public function start() {}
    public function stop() {}

    public function iterate(deltaTime:Float)
    {
        for (entity in collection)
        {
            var position:Position = entity.get(Position);
            var surface:Surface = entity.get(Surface);
            var color:Color = entity.get(Color);
            var texture:Texture = entity.get(Texture);
            apply(position, surface, color, texture);
        }
    }

        inline function apply(position:Position, surface:Surface, color:Color, texture:Texture)
        {
            addTriangles(surface, buffer.getFirstVertexIndex());
            addVertices(surface, position, surface, color);
        }

            inline function addTriangles(surface:Surface, zeroIndex:Int)
            {
                for (triangle in surface.getTriangles())
                {
                    buffer.addTriangle(zeroIndex, triangle);
                }
            }

            inline function addVertices(surface:Surface, position:Position, surface:Surface, color:Color)
            {
                for (vertex in surface.getVertices())
                {
                    addVertex(position, color, vertex);
                }
            }

                inline function addVertex(position:Position, color:Color, vertex:SurfaceVertex)
                {
                    working[0] = position.x + vertex.vertex.x;
                    working[1] = position.y + vertex.vertex.y;
                    working[2] = position.z + vertex.vertex.z;
                    working[3] = vertex.texture.x;
                    working[4] = vertex.texture.y;
                    working[5] = color.getRed();
                    working[6] = color.getGreen();
                    working[7] = color.getBlue();
                    working[8] = color.getAlpha();
                    buffer.addVertex(working);
                }
}
