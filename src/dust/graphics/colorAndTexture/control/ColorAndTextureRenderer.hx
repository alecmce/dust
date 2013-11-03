package dust.graphics.colorAndTexture.control;

import dust.graphics.renderer.data.Program;
import dust.geom.control.MatrixFactory;
import dust.graphics.colorAndTexture.data.ColorAndTextureSetup;
import dust.graphics.renderer.data.RendererTexture;
import dust.graphics.renderer.data.RenderableBuffer;
import dust.graphics.renderer.control.OutputBufferFactory;
import dust.graphics.renderer.data.OutputBuffer;
import dust.camera.data.Camera;
import flash.geom.Matrix3D;
import dust.graphics.renderer.control.Renderer;

class ColorAndTextureRenderer
{
    @inject public var outputBufferFactory:OutputBufferFactory;
    @inject public var matrixFactory:MatrixFactory;
    @inject public var setup:ColorAndTextureSetup;
    @inject public var buffer:RenderableBuffer;
    @inject public var texture:RendererTexture;
    @inject public var renderer:Renderer;
    @inject public var camera:Camera;
    @inject public var program:Program;

    var outputBuffer:OutputBuffer;
    var bodyTransform:Matrix3D;
    var cameraTransform:Matrix3D;

    public function start():ColorAndTextureRenderer
    {
        outputBuffer = outputBufferFactory.make(true);
        renderer.addRenderCall(onRender);
        return this;
    }

    public function stop():ColorAndTextureRenderer
    {
        renderer.removeRenderCall(onRender);
        return this;
    }

        function onRender(width:Int, height:Int)
        {
            bodyTransform = getBodyTransform();
            cameraTransform = getCameraTransform(width, height);

            program.activate();
            program.clear(setup.background);
            program.setShaderParameter('bodyTransform', bodyTransform, false);
            program.setShaderParameter('cameraTransform', cameraTransform, false);
            program.setTexture('textureSample', texture);
            program.setOutputBuffer(outputBuffer);
            program.setVertexBuffer(buffer.vertices);
            program.drawTriangles(buffer.triangles, 0, buffer.getTriangleCount());
            program.finishOutputBuffer(outputBuffer);
            buffer.clear();
        }

            inline function getBodyTransform():Matrix3D
            {
                var x = camera.screenCenterX;
                var y = camera.screenCenterY;
                return matrixFactory.make2D(x, y);
            }

            inline function getCameraTransform(width:Float, height:Float):Matrix3D
            {
                return if (camera.isPerspective)
                    getPerspectiveTransform(width, height);
                else
                    getOrthogonalTransform(width, height);
            }

                inline function getPerspectiveTransform(width:Float, height:Float):Matrix3D
                {
                    var aspectRatio = width / height;
                    return matrixFactory.makePerspective(camera.fieldOfView, aspectRatio, 1000.0, 1.0);
                }

                inline function getOrthogonalTransform(width:Float, height:Float):Matrix3D
                {
                    var x = camera.worldX + width * 0.5;
                    var y = camera.worldY + height * 0.5;

                    var s = 0.5 / camera.scalar;
                    var dx = width * s;
                    var dy = height * s;
                    return matrixFactory.makeOrthographic(x - dx, x + dx, y + dy, y - dy, 1000.0, -1000.0);
                }
}
