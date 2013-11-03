package dust.graphics.data;

class SurfaceVertex
{
    public var vertex:Vertex3D;
    public var template:Vertex2D;
    public var texture:Vertex2D;

    public function new(vertex:Vertex3D, texture:Vertex2D)
    {
        this.vertex = vertex;
        this.template = texture;
        this.texture = texture.clone();
    }

    public function toString():String
    {
        return '[SurfaceVertex vertex: $vertex texture: $texture]';
    }
}
