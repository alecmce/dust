package dust.graphics.data;

class Solid
{
    var faces:Array<Surface>;

    public function new(faces:Array<Surface>)
    {
        this.faces = faces;
    }

    public function getFaces():Array<Surface>
    {
        return faces;
    }

    public function toString():String
    {
        return '[Solid faces: ${faces.join(",")}]';
    }
}
