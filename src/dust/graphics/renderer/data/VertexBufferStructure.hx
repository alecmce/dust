package dust.graphics.renderer.data;

class VertexBufferStructure
{
	public var name:String;
	public var offset:Int;
	public var size:Int;

	public function new(pointer:String, offset:Int, size:Int)
	{
		this.name = pointer;
		this.offset = offset;
		this.size = size;
	}
}