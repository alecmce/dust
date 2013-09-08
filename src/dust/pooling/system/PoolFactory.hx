package dust.pooling.system;

import dust.pooling.data.Pool;

interface PoolFactory
{
    function make<T>(count:Int, factory:Void->T):Pool<T>;
}
