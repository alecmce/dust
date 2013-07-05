package dust.physics.data;


class Box
{
    inline static function root2():Float
        return Math.sqrt(2);

    inline static function shortEdge():Float
        return root2() * 0.5;

    public var size:Float;

    public function new(size:Float)
        this.size = size;

    inline public function setDistanceToEdge(value:Float)
        size = root2() * value;

    inline public function getDistanceFromEdge():Float
        return size * shortEdge();
}
