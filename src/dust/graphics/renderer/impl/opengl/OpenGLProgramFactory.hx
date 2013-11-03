package dust.graphics.renderer.impl.opengl;

import dust.graphics.renderer.impl.opengl.OpenGLProgram;
import dust.graphics.renderer.control.ProgramFactory;
import openfl.gl.GLProgram;
import openfl.gl.GLShader;
import openfl.gl.GL;
import dust.graphics.renderer.data.Program;

class OpenGLProgramFactory implements ProgramFactory
{
    public function make(vertexShaderSource:String, fragmentShaderSource:String):Program
    {
        var vertexShader = makeShader(vertexShaderSource, GL.VERTEX_SHADER);
        var fragmentShader = makeShader(fragmentShaderSource, GL.FRAGMENT_SHADER);

        var program = makeProgram(vertexShader, fragmentShader);
        if (isLinkError(program))
            throwProgrammError(program);

        return new OpenGLProgram(program, vertexShader, fragmentShader);
    }

        function makeShader(source:String, type:Int):GLShader
        {
            var shader = GL.createShader(type);
            GL.shaderSource(shader, source);
            GL.compileShader(shader);

            if (isCompileError(shader))
                throwShaderError(source, shader);

            return shader;
        }

            function isCompileError(shader:GLShader):Bool
            {
                return GL.getShaderParameter(shader, GL.COMPILE_STATUS) == 0;
            }

            function throwShaderError(source:String, shader:GLShader)
            {
                var error = GL.getShaderInfoLog(shader);
                if (error != '')
                    throw 'Unable to generate shader (error: $error)\n\n$source\n';
            }

        function makeProgram(vertexShader:GLShader, fragmentShader:GLShader):GLProgram
        {
            var program = GL.createProgram();
            GL.attachShader(program, vertexShader);
            GL.attachShader(program, fragmentShader);
            GL.linkProgram(program);
            return program;
        }

        function isLinkError(program:GLProgram):Bool
        {
            return GL.getProgramParameter(program, GL.LINK_STATUS) == 0;
        }

        function throwProgrammError(program:GLProgram)
        {
            var error:String = GL.getProgramInfoLog(program);
            if (error != '')
                throw 'Unable to generate program (error: $error)';
        }
}
