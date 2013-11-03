package dust.graphics.colorAndTexture.control;

import dust.graphics.renderer.control.IndexBufferFactory;
import dust.graphics.renderer.control.VertexBufferFactory;
import dust.graphics.colorAndTexture.data.ColorAndTextureSetup;
import dust.graphics.renderer.data.RenderableBuffer;
import dust.graphics.renderer.data.VertexBuffer;
import dust.graphics.renderer.data.VertexBufferStructure;
import dust.graphics.renderer.data.IndexBuffer;

class ColorAndTextureRenderableBufferFactory
{
    @inject public var setup:ColorAndTextureSetup;
    @inject public var vertexBufferFactory:VertexBufferFactory;
    @inject public var indexBufferFactory:IndexBufferFactory;

    public function make():RenderableBuffer
    {
        return new RenderableBuffer(makeVertices(), makeTriangles());
    }

        function makeVertices():VertexBuffer
        {
            var vertices = vertexBufferFactory.make(setup.maxVertices, 9);
            vertices.structure.push(new VertexBufferStructure('vertexPosition', 0, 3));
            vertices.structure.push(new VertexBufferStructure('positionOnFace', 3, 2));
            vertices.structure.push(new VertexBufferStructure('vertexColor', 5, 4));
            return vertices;
        }

        function makeTriangles():IndexBuffer
        {
            return indexBufferFactory.make(setup.maxFaces);
        }
}