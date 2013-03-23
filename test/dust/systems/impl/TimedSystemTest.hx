package dust.systems.impl;

import dust.systems.impl.MockSystem;
import dust.systems.impl.TimedSystem;


class TimedSystemTest
{
    var system:TimedSystem;
    var wrapped:MockSystem;

    @Before public function before()
    {
        wrapped = new MockSystem();
        system = new TimedSystem(100, wrapped);
    }

    @Test public function lessThanDelayMethodIsNotCalled()
    {
        system.iterate(60);
        Assert.isFalse(wrapped.isIterated);
    }

    @Test public function multipleMethodsAccumulate()
    {
        system.iterate(60);
        system.iterate(50);
        Assert.isTrue(wrapped.isIterated);
    }

    @Test public function theAccumulationIsPassedToMethod()
    {
        system.iterate(60);
        system.iterate(50);
        Assert.areEqual(wrapped.lastDeltaTime, 110);
    }

}