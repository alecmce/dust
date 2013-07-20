package dust.bitfield;

import dust.lists.SimpleList;
import dust.lists.LinkedList;

class BitfieldListenersTest
{
    var listeners:BitfieldListeners<MockItem>;
    var passedItem:MockItem;
    var methodItem:MockItem;
    var secondItem:MockItem;

    @Before public function before()
    {
        listeners = new BitfieldListeners<MockItem>(1, SimpleList.make);
        passedItem = {};
        methodItem = null;
    }

    function method(item:MockItem)
    {
        methodItem = item;
    }

    function secondMethod(item:MockItem)
    {
        secondItem = item;
    }

    @Test public function canAddListenerToBitfield()
    {
        var bitfield = new Bitfield(1);
        bitfield.assert(3);
        listeners.add(bitfield, method);
        listeners.dispatch(3, passedItem);
        Assert.areSame(passedItem, methodItem);
    }

    @Test public function listenerIsAddedToMultipleBits()
    {
        var bitfield = new Bitfield(1);
        bitfield.assert(3);
        bitfield.assert(6);

        listeners.add(bitfield, method);
        listeners.dispatch(6, passedItem);
        Assert.areSame(passedItem, methodItem);
    }

    @Test public function listenerIsNotCalledOnOtherBits()
    {
        var bitfield = new Bitfield(1);
        bitfield.assert(3);
        bitfield.assert(6);

        listeners.add(bitfield, method);
        listeners.dispatch(5, passedItem);
        Assert.isNull(methodItem);
    }

    @Test public function multipleListenersCanBindToSameBit()
    {
        var bitfield = new Bitfield(1);
        bitfield.assert(3);
        bitfield.assert(6);
        listeners.add(bitfield, method);

        var second = new Bitfield(1);
        second.assert(9);
        second.assert(6);
        listeners.add(bitfield, secondMethod);
        listeners.dispatch(6, passedItem);

        Assert.isTrue(passedItem == methodItem && passedItem == secondItem);
    }
}

typedef MockItem = {};
