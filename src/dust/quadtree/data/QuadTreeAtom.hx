package dust.quadtree.data;

import dust.position.data.Position;

class QuadTreeAtom<T> implements QuadTreeNode<T>
{
    public var range:QuadTreeRange;

    public var count(default, null):Int;
    public var maxDataPerNode(default, null):Int;
    public var threshold(default, null):Float;

    var list:Array<QuadTreeData<T>>;

    public function new(range:QuadTreeRange, maxDataPerNode:Int, threshold:Float)
    {
        this.range = range;
        this.maxDataPerNode = maxDataPerNode;
        this.list = [];
        this.count = 0;
        this.threshold = threshold;
    }

    public function add(data:QuadTreeData<T>):QuadTreeNode<T>
        return isAddedToSelf(data) ? addToSelf(data) : subdivide(data)

        inline function isAddedToSelf(data:QuadTreeData<T>):Bool
            return count < maxDataPerNode || Position.areClose(data.position, range.position, threshold)

        inline function addToSelf(data:QuadTreeData<T>):QuadTreeNode<T>
        {
            count = list.push(data);
            return this;
        }

        inline function subdivide(data:QuadTreeData<T>):QuadTreeNode<T>
        {
            var divisions = new QuadTreeDivisions<T>(range, maxDataPerNode, threshold);
            for (item in list)
                divisions.add(item);
            divisions.add(data);
            return divisions;
        }

    public function populateDataInRange(dataRange:QuadTreeRange, output:Array<T>)
    {
        if (range.intersects(dataRange))
        {
            for (item in list)
                output.push(item.data);
        }
    }

    public function populateRanges(dataRange:QuadTreeRange, output:Array<QuadTreeRange>)
    {
        if (range.intersects(dataRange))
            output.push(range);
    }

    public function toString(indent:Int = 0):String
    {
        var space = "";
        for (i in 0...indent)
            space += " ";

        return space + "[QuadTreeAtom range=" + range.toString() + "]";
    }
}
