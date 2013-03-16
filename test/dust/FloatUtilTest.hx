package dust;

import massive.munit.Assert;

using dust.FloatUtil;

class FloatUtilTest
{
    @Test public function toFixedWorksForBigValues()
    {
        var n = 1.00234;
        Assert.areEqual(n.toFixed(3), "1.002");
    }

    @Test public function toFixedWorksForSmallNumbers()
    {
        var n = 0.0123;
        Assert.areEqual(n.toFixed(3), "0.012");
    }

    @Test public function toFixedRoundsUp()
    {
        var n = 0.0126;
        Assert.areEqual(n.toFixed(3), "0.013");
    }

    @Test public function toFixedAddsDecimalsToIntegralFloatValues()
    {
        var n = 1.0;
        Assert.areEqual(n.toFixed(3), "1.000");
    }

    @Test public function toFixedAddsDecimalPlacesWhenRequired()
    {
        var n = 1.1;
        Assert.areEqual(n.toFixed(3), "1.100");
    }

    @Test public function toFixedZeroLeavesIntegralValue()
    {
        var n = 4123.12;
        Assert.areEqual(n.toFixed(0), "4123");
    }

    @Test public function toFixedZeroDoesntAlterInteger()
    {
        var n = 123;
        Assert.areEqual(n.toFixed(0), "123");
    }
}
