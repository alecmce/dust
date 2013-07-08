package dust.components;

import dust.type.TypeIndex;
import dust.components.BitfieldFactory;
import dust.components.Bitfield;
import dust.components.Bitfield.ZeroBitfieldDimensionError;

class BitfieldFactoryTest
{
    public var factory:BitfieldFactory;

    @Before public function before()
    {
        factory = new BitfieldFactory();
        factory.dimension = 1;
    }

    function isEmpty(bitfield:Bitfield):Bool
    {
        var isEmpty = true;
        for (i in 0...bitfield.size)
            isEmpty = isEmpty && !bitfield.get(i);
        return isEmpty;
    }

    @Test public function ifDimensionIsLessThan1ErrorIsThrown()
    {
        factory.dimension = 0;

        var isErrorCalled = false;
        try
        {
            factory.makeEmpty();
        }
        catch (error:ZeroBitfieldDimensionError)
        {
            isErrorCalled = true;
        }

        Assert.isTrue(isErrorCalled);
    }

    @Test public function makeEmptyCreatesBlankBitfield()
    {
        Assert.isTrue(isEmpty(factory.makeEmpty()));
    }

    @Test public function multipleDimensionBitfieldIsStillBlank()
    {
        factory.dimension = 2;
        Assert.isTrue(isEmpty(factory.makeEmpty()));
    }

    @Test public function makeWithComponentsMakesNonBlankBitfield()
    {
        var bitfield = factory.make([MockComponentA, MockComponentB]);
        Assert.isFalse(isEmpty(bitfield));
    }

    @Test public function makeWithComponentsAutomaticallySetsFlags()
    {
        var id = TypeIndex.getClassID(MockComponentA);
        var bitfield = factory.make([MockComponentA]);
        Assert.isTrue(bitfield.get(id));
    }

    @Test public function makeWithComponentsDoesNotSetFlagsForComponentsNotSet()
    {
        var id = TypeIndex.getClassID(MockComponentB);
        var bitfield = factory.make([MockComponentA]);
        Assert.isFalse(bitfield.get(id));
    }
}
