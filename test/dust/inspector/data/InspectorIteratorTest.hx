package dust.inspector.data;

import dust.geom.data.Position;

class InspectorIteratorTest
{
    macro static function POSITION_ID()
    {
        return macro dust.type.TypeIndex.getClassID(Position, '');
    }

    public var iterator:InspectorIterator;

    @Test public function iteratesThroughOneField()
    {
        var dummy = new InspectedField(Position, POSITION_ID(), 'x');

        var fieldHash = new FieldHash();
        fieldHash.set('hello', dummy);

        var typeHash = new TypeHash();
        typeHash.set(1, fieldHash);

        iterator = new InspectorIterator(typeHash);
        for (field in iterator)
            Assert.areSame(dummy, field);
    }

    @Test public function nullCase()
    {
        iterator = new InspectorIterator(null);
        for (field in iterator)
            Assert.fail('An InspectorIterator defined with null argument should never iterate');
    }

    @Test public function emptyCase()
    {
        iterator = new InspectorIterator(new TypeHash());
        for (field in iterator)
            Assert.fail('An InspectorIterator defined with empty hash should never iterate');
    }

    @Test public function iteratesThroughTwoFieldsInSameType()
    {
        var x = new InspectedField(Position, POSITION_ID(), 'x');
        var y = new InspectedField(Position, POSITION_ID(), 'x');

        var fieldHash = new FieldHash();
        fieldHash.set('x', x);
        fieldHash.set('y', y);

        var typeHash = new TypeHash();
        typeHash.set(1, fieldHash);

        iterator = new InspectorIterator(typeHash);

        var matchedX = false;
        var matchedY = false;
        for (field in iterator)
        {
            matchedX = matchedX || field == x;
            matchedY = matchedY || field == y;
        }
        Assert.isTrue(matchedX && matchedY);
    }

    @Test public function iteratesThroughFieldsInDifferentTypes()
    {
        var x = new InspectedField(Position, POSITION_ID(), 'x');
        var y = new InspectedField(Position, POSITION_ID(), 'y');

        var xHash = new FieldHash();
        xHash.set('x', x);

        var yHash = new FieldHash();
        yHash.set('y', y);

        var typeHash = new TypeHash();
        typeHash.set(1, xHash);
        typeHash.set(2, yHash);

        iterator = new InspectorIterator(typeHash);

        var matchedX = false;
        var matchedY = false;
        for (field in iterator)
        {
            matchedX = matchedX || field == x;
            matchedY = matchedY || field == y;
        }
        Assert.isTrue(matchedX && matchedY);
    }
}
