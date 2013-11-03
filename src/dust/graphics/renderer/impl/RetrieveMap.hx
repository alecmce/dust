package dust.graphics.renderer.impl;

class RetrieveMap<T>
{
    var map:Map<String, T>;

    public function new()
        map = new Map<String, T>();

    inline public function get(key:String, retrieveMethod:String->T):T
    {
        return if (map.exists(key))
            map.get(key);
        else
            set(key, retrieveMethod);
    }

        inline function set(key:String, retrieve:String->T):T
        {
            var value = retrieve(key);
            map.set(key, value);
            return value;
        }
}
