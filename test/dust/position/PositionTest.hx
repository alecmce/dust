package dust.position;

import dust.position.data.Position;

class PositionTest
{
    @Test public function areEqualPositive()
    {
        var a = new Position(13, 12);
        var b = new Position(13, 12);
        Assert.isTrue(Position.areEqual(a, b));
    }

    @Test public function areEqualNegativeByX()
    {
        var a = new Position(11, 12);
        var b = new Position(13, 12);
        Assert.isFalse(Position.areEqual(a, b));
    }

    @Test public function areEqualNegativeByY()
    {
        var a = new Position(13, 12);
        var b = new Position(13, 19);
        Assert.isFalse(Position.areEqual(a, b));
    }

    @Test public function areCloseWorksPositive()
    {
        var a = new Position(12.9999, 11.9999);
        var b = new Position(13.0000, 12.0000);
        Assert.isTrue(Position.areClose(a, b, 0.01));
    }

    @Test public function areCloseWorksNegative()
    {
        var a = new Position(12.9999, 11.9999);
        var b = new Position(13.0000, 12.0000);
        Assert.isFalse(Position.areClose(a, b, 0.000001));
    }
}
