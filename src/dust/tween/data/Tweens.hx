package dust.tween.data;

class Tweens
{
    var list:Array<Tween>;

    public function new()
        list = new Array<Tween>();

    inline public function add(tween:Tween):Tweens
    {
        list.push(tween);

        return this;
    }

    inline public function remove(tween:Tween):Tweens
    {
        list.remove(tween);
        return this;
    }

    inline public function iterator():Iterator<Tween>
        return list.iterator();

    inline public function getCount():Int
        return list.length;
}
