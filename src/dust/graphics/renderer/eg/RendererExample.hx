package dust.graphics.renderer.eg;

import dust.gui.data.Color;
import openfl.Assets;
import dust.platonic.control.DodecahedronFactory;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.entities.Entities;
import dust.geom.control.QuaternionFactory;
import dust.geom.control.MatrixFactory;
import dust.graphics.data.Quaternion;
import dust.graphics.renderer.control.ConstrainToPartialTexture;
import dust.graphics.renderer.data.CullFaces;
import dust.graphics.renderer.data.OutputBuffer;
import dust.graphics.renderer.data.Program;
import dust.graphics.renderer.data.RendererTexture;
import dust.graphics.renderer.control.IndexBufferFactory;
import dust.graphics.renderer.control.OutputBufferFactory;
import dust.graphics.renderer.control.ProgramFactory;
import dust.graphics.renderer.control.Renderer;
import dust.graphics.renderer.control.SolidRenderableBufferFactory;
import dust.graphics.renderer.control.TextureFactory;
import dust.graphics.renderer.control.VertexBufferFactory;
import dust.graphics.renderer.data.RenderableBuffer;
import dust.platonic.control.DodecahedronFactory;
import dust.platonic.PlatonicGeometryConfig;

import flash.display.DisplayObjectContainer;
import flash.geom.Rectangle;
import flash.geom.Vector3D;
import flash.display.BitmapData;
import flash.geom.Matrix3D;


class RendererExample implements DependentConfig
{
    @inject public var injector:Injector;
    @inject public var entities:Entities;
    @inject public var renderer:Renderer;
    @inject public var root:DisplayObjectContainer;

    @inject public var solidFactory:DodecahedronFactory;
    @inject public var renderableFactory:SolidRenderableBufferFactory;
    @inject public var constrain:ConstrainToPartialTexture;

    @inject public var programFactory:ProgramFactory;
    @inject public var textureFactory:TextureFactory;
    @inject public var outputBufferFactory:OutputBufferFactory;
    @inject public var vertexBufferFactory:VertexBufferFactory;
    @inject public var indexBufferFactory:IndexBufferFactory;
    @inject public var matrixFactory:MatrixFactory;
    @inject public var quaternionFactory:QuaternionFactory;

    var background:Color;

    var cameraTransform:Matrix3D;
    var bodyQuaternion:Quaternion;
    var bodyDelta:Quaternion;

    var workingTransform:Matrix3D;
    var bodyTransform:Matrix3D;
    var texture:RendererTexture;
    var mainOutputBuffer:OutputBuffer;

    var renderable:RenderableBuffer;

    var program:Program;
    var rotation:Float;

    public function dependencies():Array<Class<Config>>
    {
        return [RendererConfig, PlatonicGeometryConfig];
    }

    public function configure()
    {
        background = new Color(0x330099, 1.0);

        bodyQuaternion = quaternionFactory.makeIdentity();
        bodyDelta = quaternionFactory.makeFromAxialRotation(new Vector3D(0.5, 0.4, 0.3), 0.02);
        rotation = 0.0;

        cameraTransform = new Matrix3D();
        workingTransform = new Matrix3D();
        bodyTransform = new Matrix3D();
        mainOutputBuffer = outputBufferFactory.make(true);

        var bitmapData = openfl.Assets.getBitmapData('assets/testnumbers.png');
        var textureData = openfl.Assets.getText('assets/testnumbers.json');
        texture = textureFactory.make(bitmapData, textureData);

        var solid = solidFactory.make(100);
        constrain.constrainSolid(solid, getTextureConstraints);
        renderable = renderableFactory.make(solid, getExtra);

//        program = makeProgram();
//        renderer.addRenderCall(onRender);
    }

        function getExtra(index:Int):Array<Float>
        {
            var rgb = [0xFF0000, 0xFF8800, 0xFFEE00, 0x00FF00, 0x1E90FF, 0x0000CD, 0x99000FF][index % 7];
            var r = ((rgb >> 16) & 0xFF) / 0xFF;
            var g = ((rgb >> 8) & 0xFF) / 0xFF;
            var b = (rgb & 0xFF) / 0xFF;
            return [r, g, b];
        }

        function getTextureConstraints(index:Int):Rectangle
        {
            var x = index % 4;
            var y = Std.int(index / 4);
            return new Rectangle(x * 0.25, y * 0.25, 0.25, 0.25);
        }

    function makeProgram():Program
    {
        var vertexShaderSource =
        '
            attribute vec3 vertexPosition;
            attribute vec3 vertexColor;
            attribute vec2 positionOnFace;

            uniform mat4 bodyTransform;
            uniform mat4 cameraTransform;

            varying vec3 color;
            varying vec2 texturePosition;

            void main(void) {
                gl_Position = cameraTransform * bodyTransform * vec4(vertexPosition, 1.0);
                color = vertexColor;
                texturePosition = positionOnFace;
            }
        ';

        var fragmentShaderSource =
        '
            precision mediump float;

            uniform sampler2D textureSample;

            varying vec3 color;
            varying vec2 texturePosition;

            void main(void) {
                vec3 t = texture2D(textureSample, texturePosition).rgb;
                gl_FragColor = vec4(color * t, 0.5);
            }
        ';

        var program = programFactory.make(vertexShaderSource, fragmentShaderSource);
        program.cullFaces = CullFaces.DISABLE;
        program.depthTest = true;
        return program;
    }


    function onRender(width:Int, height:Int)
    {
        var w = width * 0.5;
        var h = height * 0.5;

        bodyQuaternion.postMultiply(bodyDelta);
        bodyQuaternion.applyToMatrix(workingTransform);

        bodyTransform = workingTransform.clone();
        bodyTransform.appendTranslation(w, h, 0.0);

        cameraTransform = matrixFactory.makeOrthographic(0.0, width, height, 0, 1000.0, -1000.0);

        program.activate();
        program.setVertexBuffer('vertexPosition', renderable.vertices, 0, 3);
        program.setVertexBuffer('positionOnFace', renderable.vertices, 3, 2);
        program.setVertexBuffer('vertexColor', renderable.vertices, 5, 3);
        program.setShaderParameter('bodyTransform', bodyTransform, false);
        program.setShaderParameter('cameraTransform', cameraTransform, false);
        program.setTexture('textureSample', texture);
        program.setOutputBuffer(mainOutputBuffer);
        program.clear(background);
        program.drawTriangles(renderable.triangles);
        program.finishOutputBuffer(mainOutputBuffer);
    }
}