package dust.graphics.colorAndTexture.control;

import dust.gui.data.Color;
import dust.collections.control.CollectionMap;
import dust.systems.impl.Systems;
import dust.geom.data.Position;
import dust.graphics.renderer.data.Program;
import dust.graphics.renderer.data.RenderableBuffer;
import dust.graphics.colorAndTexture.systems.ApplyTextureToSurface;
import dust.graphics.data.Texture;
import dust.graphics.data.Surface;
import dust.graphics.colorAndTexture.systems.UpdateRenderBufferSystem;
import dust.entities.Entity;
import dust.graphics.renderer.data.RendererTexture;
import dust.commands.Command;

class StartColorAndTextureRendererCommand implements Command<RendererTexture>
{
    @inject public var injector:Injector;
    @inject public var systems:Systems;
    @inject public var collections:CollectionMap;

    @inject public var programFactory:ColorAndTextureProgramFactory;
    @inject public var bufferFactory:ColorAndTextureRenderableBufferFactory;

    public function execute(texture:RendererTexture)
    {
        injector.mapValue(RendererTexture, texture);

        injector.mapValue(Program, programFactory.make());
        injector.mapValue(RenderableBuffer, bufferFactory.make());

        systems
            .map(UpdateRenderBufferSystem, 0)
            .toCollection([Position, Surface, Color, Texture], sortCollection);

        collections
            .map([Surface, Texture])
            .toListeners(ApplyTextureToSurface);

        injector
            .mapSingleton(ColorAndTextureRenderer)
            .getInstance(ColorAndTextureRenderer)
            .start();
    }

        function sortCollection(a:Entity, b:Entity):Int
        {
            return Std.int(b.get(Position).z - a.get(Position).z);
        }
}
