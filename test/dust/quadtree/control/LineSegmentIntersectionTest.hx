package dust.quadtree.control;

import dust.position.data.Position;
import massive.munit.Assert;

class LineSegmentIntersectionTest
{
    var intersection:LineSegmentIntersection;
    var position:Position;

    @Before public function before()
    {
        intersection = new LineSegmentIntersection();
        position = new Position();
    }

    @Test public function parallelLinesDoNotIntersect()
    {
        intersection
            .setLineA(0, 0, 0, 3)
            .setLineB(1, 0, 0, 3);

        Assert.isFalse(intersection.isIntersection());
    }

    @Test public function intersectionIsDetected()
    {
        intersection
            .setLineA(0, 5, 10, 0)
            .setLineB(5, 0, 0, 10);

        Assert.isTrue(intersection.isIntersection());
    }

    @Test public function setToIntersectionWorksForCrossExample()
    {
        intersection
            .setLineA(0, 5, 10, 0)
            .setLineB(5, 0, 0, 10)
            .isIntersection();

        intersection.setToIntersection(position);
        Assert.areEqual(position.x, 5);
        Assert.areEqual(position.y, 5);
    }

    @Test public function proportionWorksCorrectly()
    {
        intersection
            .setLineA(6, 0, 0, 10)
            .setLineB(0, 2, 10, 0)
            .isIntersection();

        intersection.setToIntersection(position);
        Assert.areEqual(position.x, 6);
        Assert.areEqual(position.y, 2);
    }

    @Test public function proportionWorksWithDiagonals()
    {
        intersection
            .setLineA(0, 0, 8, 8)
            .setLineB(0, 8, 8, -8)
            .isIntersection();

        intersection.setToIntersection(position);
        Assert.areEqual(position.x, 4);
        Assert.areEqual(position.y, 4);
    }

    @Test public function proportionWorksWithDiagonalsEtc()
    {
        intersection
            .setLineA(0, 0, 8, 8)
            .setLineB(0, 4, 4, -4)
            .isIntersection();

        intersection.setToIntersection(position);
        Assert.areEqual(position.x, 2);
        Assert.areEqual(position.y, 2);
    }
}
