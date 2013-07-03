package dust.systems.impl;

import dust.stats.RollingMean;


class SystemMetricsTest
{
    var metrics:SystemMetrics;

    @Before public function before()
        metrics = new SystemMetrics(3);

    @Test public function canRecordATimeAgainstLabel()
    {
        metrics.recordTime("dummy", 3);
        metrics.update();
        Assert.areEqual(metrics.getMean("dummy"), 3);
    }

    @Test public function timesRecordedAgainstSameLabelAreAccumulatedUntilUpdate()
    {
        metrics.recordTime("dummy", 3);
        metrics.recordTime("dummy", 5);
        metrics.update();
        Assert.areEqual(metrics.getMean("dummy"), 8);
    }

    @Test public function timesRecordedBetweenUpdatesAreAveraged()
    {
        metrics.recordTime("dummy", 3);
        metrics.update();
        metrics.recordTime("dummy", 5);
        metrics.update();
        Assert.areEqual(metrics.getMean("dummy"), 4);
    }

    @Test public function timesWithDifferentLabelsDoNotInteract()
    {
        metrics.recordTime("first", 1);
        metrics.recordTime("second", 100);
        metrics.update();
        Assert.areEqual(metrics.getMean("first"), 1);
    }
}