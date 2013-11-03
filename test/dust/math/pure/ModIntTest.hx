package dust.math.pure;

class ModIntTest
{
    @Test
    public function sanityTest()
    {
        var int = new ModInt(3, 7);
        Assert.areEqual(3, int.value);
    }

    @Test
    public function largeValueWraps()
    {
        var int = new ModInt(10, 7);
        Assert.areEqual(3, int.value);
    }

    @Test
    public function negativeValueWraps()
    {
        var int = new ModInt(-3, 7);
        Assert.areEqual(4, int.value);
    }

    @Test
    public function settingLargeValueWraps()
    {
        var int = new ModInt(3, 7);
        int.value = 10;
        Assert.areEqual(3, int.value);
    }

    @Test
    public function settingNegativeValueWraps()
    {
        var int = new ModInt(3, 7);
        int.value = -3;
        Assert.areEqual(4, int.value);
    }
}
