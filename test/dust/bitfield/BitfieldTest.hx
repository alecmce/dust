package dust.bitfield;

import dust.bitfield.Bitfield;
import massive.munit.async.AsyncFactory;

class BitfieldTest
{
    @Test public function isSubset_is_true_when_all_bits_in_second_mask_are_in_first():Void
    {
        var bitfield:Bitfield = new Bitfield(1);
        bitfield.set(1, true);
        bitfield.set(2, false);
        bitfield.set(3, true);
        bitfield.set(4, true);

        var subset:Bitfield = new Bitfield(1);
        subset.set(1, true);
        subset.set(2, false);
        subset.set(3, false);
        subset.set(4, true);

        Assert.isTrue(bitfield.isSubset(subset));
    }

    @Test public function isSubset_is_not_affected_by_extra_indices():Void
    {
        var bitfield:Bitfield = new Bitfield(2);
        bitfield.set(1, true);
        bitfield.set(2, false);
        bitfield.set(3, true);
        bitfield.set(4, true);
        bitfield.set(33, true);

        var subset:Bitfield = new Bitfield(2);
        subset.set(1, true);
        subset.set(2, false);
        subset.set(3, false);
        subset.set(4, true);
        bitfield.set(33, false);

        Assert.isTrue(bitfield.isSubset(subset));
    }

    @Test public function isSubset_is_false_when_bit_in_subset_is_not_in_first():Void
    {
        var bitfield:Bitfield = new Bitfield(1);
        bitfield.set(1, true);
        bitfield.set(2, false);
        bitfield.set(3, false);
        bitfield.set(4, true);

        var subset:Bitfield = new Bitfield(1);
        subset.set(1, true);
        subset.set(2, false);
        subset.set(3, true);
        subset.set(4, false);

        Assert.isFalse(bitfield.isSubset(subset));
    }

    @Test public function isSubset_is_false_works_for_indices_above_32():Void
    {
        var bitfield:Bitfield = new Bitfield(2);
        bitfield.set(1, true);
        bitfield.set(2, false);
        bitfield.set(3, true);
        bitfield.set(4, true);

        var subset:Bitfield = new Bitfield(2);
        subset.set(1, true);
        subset.set(2, false);
        subset.set(3, true);
        subset.set(4, true);
        subset.set(33, true);

        Assert.isFalse(bitfield.isSubset(subset));
    }

    @Test public function can_get_intersection_of_sets():Void
    {
        var first:Bitfield = new Bitfield(1);
        first.set(1, true);
        first.set(2, true);

        var second:Bitfield = new Bitfield(1);
        second.set(1, true);
        second.set(3, false);

        first.intersect(second);
        Assert.isTrue(first.get(1));
        Assert.isFalse(first.get(2));
        Assert.isFalse(first.get(3));
    }

    @Test public function can_get_intersection_of_sets_with_multiple_values():Void
    {
        var first:Bitfield = new Bitfield(2);
        first.set(1, true);
        first.set(2, true);
        first.set(33, true);
        first.set(34, true);

        var second:Bitfield = new Bitfield(2);
        second.set(1, true);
        second.set(3, false);
        second.set(33, true);
        second.set(35, true);

        first.intersect(second);
        Assert.isTrue(first.get(1));
        Assert.isFalse(first.get(2));
        Assert.isFalse(first.get(3));
        Assert.isTrue(first.get(33));
        Assert.isFalse(first.get(34));
        Assert.isFalse(first.get(35));
    }

    @Test public function can_get_intersection_of_sets_where_first_set_is_longer():Void
    {
        var first:Bitfield = new Bitfield(2);
        first.set(1, true);
        first.set(2, true);
        first.set(33, true);
        first.set(34, true);

        var second:Bitfield = new Bitfield(2);
        second.set(1, true);
        second.set(3, false);

        first.intersect(second);
        Assert.isTrue(first.get(1));
        Assert.isFalse(first.get(2));
        Assert.isFalse(first.get(3));
        Assert.isFalse(first.get(33));
        Assert.isFalse(first.get(34));
    }

    @Test public function can_get_intersection_of_sets_where_second_set_is_longer():Void
    {
        var first:Bitfield = new Bitfield(2);
        first.set(1, true);
        first.set(2, true);

        var second:Bitfield = new Bitfield(2);
        second.set(1, true);
        second.set(3, false);
        second.set(33, true);
        second.set(34, true);

        first.intersect(second);
        Assert.isTrue(first.get(1));
        Assert.isFalse(first.get(2));
        Assert.isFalse(first.get(3));
        Assert.isFalse(first.get(33));
        Assert.isFalse(first.get(34));
    }

    @Test public function can_get_union_of_sets():Void
    {
        var first:Bitfield = new Bitfield(1);
        first.set(1, true);
        first.set(2, true);

        var second:Bitfield = new Bitfield(1);
        second.set(1, true);
        second.set(3, true);

        first.union(second);
        Assert.isTrue(first.get(1));
        Assert.isTrue(first.get(2));
        Assert.isTrue(first.get(3));
    }

    @Test public function can_get_union_of_state_where_first_set_is_longer():Void
    {
        var first:Bitfield = new Bitfield(2);
        first.assert(1);
        first.assert(2);
        first.assert(33);

        var second:Bitfield = new Bitfield(2);
        second.assert(1);
        second.assert(3);

        first.union(second);
        Assert.isTrue(first.get(1));
        Assert.isTrue(first.get(2));
        Assert.isTrue(first.get(3));
        Assert.isTrue(first.get(33));
    }

    @Test public function can_get_union_of_state_where_second_set_is_longer():Void
    {
        var first:Bitfield = new Bitfield(2);
        first.assert(1);
        first.assert(2);

        var second:Bitfield = new Bitfield(2);
        second.assert(1);
        second.assert(3);
        second.assert(33);

        first.union(second);
        Assert.isTrue(first.get(1));
        Assert.isTrue(first.get(2));
        Assert.isTrue(first.get(3));
        Assert.isTrue(first.get(33));
    }

}
