package dust.graphics.renderer.impl.opengl;

import dust.gui.data.Color;
import dust.graphics.renderer.data.CullFaces;
import openfl.gl.GLUniformLocation;
import dust.graphics.renderer.data.OutputBuffer;
import dust.graphics.renderer.data.IndexBuffer;
import dust.graphics.renderer.impl.opengl.OpenGLOutputBuffer;
import dust.graphics.renderer.impl.opengl.OpenGLVertexBuffer;
import flash.geom.Matrix3D;
import dust.graphics.renderer.impl.RetrieveMap;
import dust.graphics.renderer.data.RendererTexture;
import dust.graphics.renderer.data.VertexBuffer;
import dust.graphics.renderer.data.VertexBufferStructure;
import openfl.gl.GL;
import openfl.gl.GLShader;
import dust.graphics.renderer.data.Program;
import openfl.gl.GLProgram;

class OpenGLProgram implements Program
{
    public var cullFaces:CullFaces;
    public var depthTest:Bool;
    public var zNear:Float = -1000;
    public var zFar:Float = 1000;

    var program:GLProgram;
    var vertexShader:GLShader;
    var fragmentShader:GLShader;

    var uniformLocations:RetrieveMap<GLUniformLocation>;
    var attributeLocations:RetrieveMap<Int>;

    public function new(program:GLProgram, vertexShader:GLShader, fragmentShader:GLShader)
    {
        this.program = program;
        this.vertexShader = vertexShader;
        this.fragmentShader = fragmentShader;

        uniformLocations = new RetrieveMap<GLUniformLocation>();
        attributeLocations = new RetrieveMap<Int>();
    }
    
    public function setShaderParameter(name:String, matrix:Matrix3D, transposed:Bool = false)
    {
        var location = uniformLocations.get(name, getUniformLocation);
        GL.uniformMatrix3D(location, transposed, matrix);
    }

        function getUniformLocation(name:String)
        {
            return GL.getUniformLocation(program, name);
        }

    public function setTexture(name:String, texture:RendererTexture)
    {
        var location = uniformLocations.get(name, getUniformLocation);
        if (texture != null)
            applyTexture(location, texture);
    }

        function applyTexture(location:GLUniformLocation, texture:RendererTexture)
        {
            GL.activeTexture(GL.TEXTURE0);
            GL.bindBitmapDataTexture(cast (texture, OpenGLRendererTexture).source);
            GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
            GL.uniform1i(location, 0);
        }

    public function activate()
    {
        GL.useProgram(program);

        if (cullFaces == CullFaces.DISABLE)
            GL.disable(GL.CULL_FACE);
        else
            GL.enable(parseCullFace());

        depthTest ? GL.enable(GL.DEPTH_TEST) : GL.disable(GL.DEPTH_TEST);
        GL.depthMask(depthTest);

        GL.enable(GL.BLEND);
        GL.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);
    }

        function parseCullFace()
        {
            return switch (cullFaces)
            {
                case CullFaces.NONE: GL.NONE;
                case CullFaces.BACK: GL.BACK;
                case CullFaces.FRONT: GL.FRONT;
                case CullFaces.FRONT_AND_BACK: GL.FRONT_AND_BACK;
                default: null;
            }
        }

    public function clear(color:Color)
    {
        GL.clearColor(color.getRed(), color.getGreen(), color.getBlue(), color.getAlpha());
        GL.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT);
    }

    public function drawTriangles(buffer:IndexBuffer, firstIndex:Int = 0, numTriangles:Int = 0)
    {
        var size = numTriangles == 0 ? buffer.count : numTriangles * 3;

        buffer.update();
        GL.drawElements(GL.TRIANGLES, size, GL.UNSIGNED_SHORT, firstIndex);
        GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, null);
    }

    public function setVertexBuffer(buffer:VertexBuffer)
    {
        var glBuffer = cast(buffer, OpenGLVertexBuffer);

        GL.bindBuffer(GL.ARRAY_BUFFER, glBuffer.buffer);
        GL.bufferData(GL.ARRAY_BUFFER, glBuffer.array, GL.STATIC_DRAW);

        for (structure in buffer.structure)
           applyStructure(glBuffer, structure);

        GL.bindBuffer(GL.ARRAY_BUFFER, null);
    }

        inline function applyStructure(buffer:OpenGLVertexBuffer, structure:VertexBufferStructure)
        {
            var index = attributeLocations.get(structure.name, getAttributeLocation);
            GL.vertexAttribPointer(index, structure.size, GL.FLOAT, false, 4 * buffer.perVertex, 4 * structure.offset);
            GL.enableVertexAttribArray(index);
        }

            function getAttributeLocation(name:String)
            {
                return GL.getAttribLocation(program, name);
            }

    public function setOutputBuffer(buffer:OutputBuffer)
    {
        if (Std.is(buffer, OpenGLOutputBuffer))
            GL.bindFramebuffer(GL.FRAMEBUFFER, cast (buffer, OpenGLOutputBuffer).frameBuffer);
    }

    public function finishOutputBuffer(buffer:OutputBuffer)
    {
        // noop
    }
}