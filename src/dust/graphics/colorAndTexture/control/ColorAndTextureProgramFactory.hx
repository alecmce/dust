package dust.graphics.colorAndTexture.control;

import dust.graphics.renderer.data.CullFaces;
import dust.graphics.renderer.control.ProgramFactory;
import dust.graphics.renderer.data.Program;

class ColorAndTextureProgramFactory
{
    @inject public var factory:ProgramFactory;

    static var VERTEX_SHADER_SOURCE =
    '
        attribute vec3 vertexPosition;
        attribute vec4 vertexColor;
        attribute vec2 positionOnFace;

        uniform mat4 bodyTransform;
        uniform mat4 cameraTransform;

        varying vec4 color;
        varying vec2 texturePosition;

        void main(void) {
            gl_Position = cameraTransform * bodyTransform * vec4(vertexPosition, 1.0);
            color = vertexColor;
            texturePosition = positionOnFace;
        }
    ';

    static var FRAGMENT_SHADER_SOURCE =
    '
        uniform sampler2D textureSample;

        varying vec4 color;
        varying vec2 texturePosition;

        void main(void) {
            vec4 t = texture2D(textureSample, texturePosition).rgba;
            if(t.a < 0.01)
                discard;
            gl_FragColor = color.xyzw * t;
        }
    ';

    public function make()
    {
        var program = factory.make(VERTEX_SHADER_SOURCE, makeFragmentShaderSource());
        program.cullFaces = CullFaces.DISABLE;
        program.depthTest = false;
        return program;
    }

        function makeFragmentShaderSource()
        {
            var buffer = [];
            #if js
            buffer.push('precision mediump float;');
            #end
            buffer.push(FRAGMENT_SHADER_SOURCE);
            return buffer.join('\n');
        }
}
