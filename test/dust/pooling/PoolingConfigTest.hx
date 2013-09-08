package dust.pooling;

import dust.pooling.data.Pool;
import dust.pooling.system.PoolFactory;
import flash.display.Sprite;
import dust.context.Context;

class PoolingConfigTest
{
    var context:Context;
    var factory:PoolFactory;

    function setupContext()
    {
        context = new Context()
            .configure(PoolingConfig)
            .start(new Sprite());
    }

    function makePool():Pool<MockPooledA>
    {
        factory = context.injector.getInstance(PoolFactory);
        return factory.make(100, MockPooledA.make);
    }

    @Test public function sanityTest()
    {
        setupContext();
    }

    @Test public function mapsPoolFactory()
    {
        setupContext();
        var pool = makePool();
    }
}

class MockPooledA
{
    public static function make():MockPooledA
    {
        return new MockPooledA();
    }

    public function new() {}
}