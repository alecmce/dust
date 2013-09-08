package dust.inspector.data;

class InspectorIterator
{
    static var nullTypeIterator:NullTypeIterator = new NullTypeIterator();
    static var nullFieldIterator:NullFieldIterator = new NullFieldIterator();

    var typeIterator:Iterator<FieldHash>;
    var fieldIterator:Iterator<InspectedField>;

    public function new(typeHash:TypeHash)
    {
        if (typeHash != null)
            typeIterator = typeHash.iterator();
        else
            typeIterator = nullTypeIterator;

        if (typeIterator.hasNext())
            fieldIterator = typeIterator.next().iterator();
        else
            fieldIterator = nullFieldIterator;
    }

    public function hasNext():Bool
    {
        return fieldIterator.hasNext() || typeIterator.hasNext();
    }

    public function next():InspectedField
    {
        var value = fieldIterator.next();
        if (!fieldIterator.hasNext() && typeIterator.hasNext())
            fieldIterator = typeIterator.next().iterator();
        return value;
    }
}

class NullTypeIterator
{
    public function new() {}

    public function hasNext():Bool
    {
        return false;
    }

    public function next():FieldHash
    {
        return null;
    }
}

class NullFieldIterator
{
    public function new() {}

    public function hasNext():Bool
    {
        return false;
    }

    public function next():InspectedField
    {
        return null;
    }
}
