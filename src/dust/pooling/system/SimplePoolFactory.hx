package dust.pooling.system;

import dust.pooling.data.Pool;

class SimplePoolFactory implements PoolFactory
{
    public function make<T>(count:Int, factory:Void->T):Pool<T>
    {
        var pool = new Pool<T>(factory);
        pool.populate(count);
        return pool;
    }
}
