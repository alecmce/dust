package dust.graphics.renderer.control;

import dust.graphics.renderer.data.Program;

interface ProgramFactory
{
    function make(vertexShaderSource:String, fragmentShaderSource:String):Program;
}
