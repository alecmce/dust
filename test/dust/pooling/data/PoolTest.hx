package dust.pooling.data;

import dust.lists.MockData;
import dust.pooling.data.Pool;
import massive.munit.async.AsyncFactory;

class PoolTest
{
    var pool:Pool<MockData>;

    @Before public function before()
    {
        pool = new Pool<MockData>(factoryMethod);
    }

        function factoryMethod():MockData
        {
            return new MockData();
        }

    @Test public function requireGivesObject()
    {
        var example = pool.require();
        Assert.isType(example, MockData);
    }

    @Test public function recycleReusesItem()
    {
        var first = pool.require();
        pool.release(first);
        var second = pool.require();
        Assert.areSame(first, second);
    }

    @Test public function requiringTwiceReturnsTwoObjects()
    {
        var first = pool.require();
        var second = pool.require();
        Assert.areNotSame(first, second);
    }
}