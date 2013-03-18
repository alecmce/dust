package dust.stats;

class RollingMeanTest
{
    var mean:RollingMean;

    public function makeRollingMeanWithCount(count:Int)
        mean = new RollingMean(count)

    @Test public function firstValueIsMean()
    {
        makeRollingMeanWithCount(3);
        mean.update(1);
        Assert.areEqual(mean.getMean(), 1);
    }

    @Test public function returnsMeanValues()
    {
        makeRollingMeanWithCount(3);
        mean.update(1);
        mean.update(2);
        mean.update(3);
        Assert.areEqual(mean.getMean(), 2);
    }

    @Test public function afterMoreThanCountValuesOldValuesAreDropped()
    {
        makeRollingMeanWithCount(3);
        mean.update(1);
        mean.update(2);
        mean.update(3);
        mean.update(4);
        Assert.areEqual(mean.getMean(), 3);
    }

    @Test public function valuesAreRemovedOldestFirst()
    {
        makeRollingMeanWithCount(3);
        mean.update(1);
        mean.update(1);
        mean.update(4);
        mean.update(4);
        mean.update(4);
        Assert.areEqual(mean.getMean(), 4);
    }
}
