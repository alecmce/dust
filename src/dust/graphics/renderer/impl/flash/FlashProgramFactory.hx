package dust.graphics.renderer.impl.flash;

import com.adobe.utils.AgalMiniAssembler;
import dust.graphics.renderer.control.ProgramFactory;
import dust.graphics.renderer.data.Program;
import flash.display3D.Context3D;

class FlashProgramFactory implements ProgramFactory
{
    public static var VERTEX = AgalMiniAssembler.VERTEX;
    public static var FRAGMENT = AgalMiniAssembler.FRAGMENT;

    @inject public var context:Context3D;
    @inject public var shaderFactory:FlashShaderFactory;

    public function make(vertexShaderSource:String, fragmentShaderSource:String):Program
    {
        var program = context.createProgram();

        var vertexShader = shaderFactory.make(VERTEX, vertexShaderSource);
        var fragmentShader = shaderFactory.make(FRAGMENT, fragmentShaderSource);
        program.upload(vertexShader.shader, fragmentShader.shader);

        return new FlashProgram(context, program, vertexShader, fragmentShader);
    }
}
