package dust.quadtree.data;

import dust.position.data.Position;
import dust.position.data.Position;
import massive.munit.Assert;

class QuadTreeRangeTest
{
    function assertRangeEquals(range:QuadTreeRange, x:Float, y:Float, extent:Float)
    {
        if (range.position.x != x)
            Assert.fail("range.x is " + range.position.x + ", expected value " + x);

        if (range.position.y != y)
            Assert.fail("range.y is " + range.position.y + ", expected value " + y);

        if (range.position.x != x)
            Assert.fail("range.x is " + range.extent + ", expected value " + extent);
    }

    @Test public function canSubdivideRange()
    {
        var range = new QuadTreeRange(new Position(10, 10), 10);
        var ranges = range.subdivide();

        assertRangeEquals(ranges.tl, 5, 5, 5);
        assertRangeEquals(ranges.tr, 15, 5, 5);
        assertRangeEquals(ranges.bl, 5, 15, 5);
        assertRangeEquals(ranges.br, 15, 15, 5);
    }

    @Test public function canSubdivideWithFloatingPoints()
    {
        var range = new QuadTreeRange(new Position(3, 3), 5);
        var ranges = range.subdivide();

        assertRangeEquals(ranges.tl, 0.5, 0.5, 2.5);
        assertRangeEquals(ranges.tr, 5.5, 0.5, 2.5);
        assertRangeEquals(ranges.bl, 0.5, 5.5, 2.5);
        assertRangeEquals(ranges.br, 5.5, 5.5, 2.5);
    }

    @Test public function canSubdivideWithNegatives()
    {
        var range = new QuadTreeRange(new Position(-2, -2), 4);
        var ranges = range.subdivide();

        assertRangeEquals(ranges.tl, -4, -4, 2);
        assertRangeEquals(ranges.tr, 0, -4, 2);
        assertRangeEquals(ranges.bl, -4, 0, 2);
        assertRangeEquals(ranges.br, 0, 0, 2);
    }

    @Test public function intersectingRangesAreDetected()
    {
        var first = new QuadTreeRange(new Position(3, 3), 2);
        var second = new QuadTreeRange(new Position(4, 4), 2);
        Assert.isTrue(first.intersects(second));
    }

    @Test public function nonIntersectingRangesAreDetected()
    {
        var first = new QuadTreeRange(new Position(3, 3), 2);
        var second = new QuadTreeRange(new Position(10, 10), 2);
        Assert.isFalse(first.intersects(second));
    }

    @Test public function canEvaluateThatAPositionIsContained()
    {
        var range = new QuadTreeRange(new Position(0, 0), 10);
        var position = new Position(3, 5);
        Assert.isTrue(range.contains(position));
    }

    @Test public function canEvaluateThatAPositionIsNotContained()
    {
        var range = new QuadTreeRange(new Position(0, 0), 10);
        var position = new Position(12, 4);
        Assert.isFalse(range.contains(position));
    }

    @Test public function positionOnLeftEdgeIsContained()
    {
        var range = new QuadTreeRange(new Position(0, 0), 10);
        var position = new Position(-10, 4);
        Assert.isTrue(range.contains(position));
    }

    @Test public function positionOnTopEdgeIsContained()
    {
        var range = new QuadTreeRange(new Position(0, 0), 10);
        var position = new Position(3, -10);
        Assert.isTrue(range.contains(position));
    }

    @Test public function positionOnRightEdgeIsContained()
    {
        var range = new QuadTreeRange(new Position(0, 0), 10);
        var position = new Position(10, 7);
        Assert.isFalse(range.contains(position));
    }

    @Test public function positionOnBottomEdgeIsContained()
    {
        var range = new QuadTreeRange(new Position(0, 0), 10);
        var position = new Position(1, 10);
        Assert.isFalse(range.contains(position));
    }
}
