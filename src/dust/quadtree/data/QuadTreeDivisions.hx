package dust.quadtree.data;

import dust.quadtree.data.QuadTreeRange;
import dust.geom.data.Position;

class QuadTreeDivisions<T> implements QuadTreeNode<T>
{
    inline static var LEFT:Int = 0;
    inline static var RIGHT:Int = 1;
    inline static var TOP:Int = 0;
    inline static var BOTTOM:Int = 2;

    public var range:QuadTreeRange;

    var nodes:Array<QuadTreeNode<T>>;
    var threshold:Float;
    var maxItemsPerAtom:Int;

    public function new(range:QuadTreeRange, maxItemsPerAtom:Int, threshold:Float)
    {
        this.range = range;
        this.threshold = threshold;
        this.maxItemsPerAtom = maxItemsPerAtom;
        this.nodes = makeNodes(range.subdivide());
    }

        inline function makeNodes(ranges:QuadTreeRanges):Array<QuadTreeNode<T>>
        {
            var nodes = new Array<QuadTreeNode<T>>();
            nodes[LEFT | TOP] = new QuadTreeAtom<T>(ranges.tl, maxItemsPerAtom, threshold);
            nodes[RIGHT | TOP] = new QuadTreeAtom<T>(ranges.tr, maxItemsPerAtom, threshold);
            nodes[LEFT | BOTTOM] = new QuadTreeAtom<T>(ranges.bl, maxItemsPerAtom, threshold);
            nodes[RIGHT | BOTTOM] = new QuadTreeAtom<T>(ranges.br, maxItemsPerAtom, threshold);
            return nodes;
        }

    public function add(datum:QuadTreeData<T>):QuadTreeNode<T>
    {
        var index = getIndex(datum.position);
        nodes[index] = nodes[index].add(datum);
        return this;
    }

    inline function getIndex(position:Position):Int
        return (position.x < range.position.x ? LEFT : RIGHT) + (position.y < range.position.y ? TOP : BOTTOM)

    public function populateDataInRange(dataRange:QuadTreeRange, output:Array<T>)
    {
        if (range.intersects(dataRange))
            for (node in nodes)
                node.populateDataInRange(dataRange, output);
    }

    public function populateRanges(dataRange:QuadTreeRange, output:Array<QuadTreeRange>)
    {
        if (range.intersects(dataRange))
            for (node in nodes)
                node.populateRanges(dataRange, output);
    }

    public function getRange(position:Position):QuadTreeRange
    {
        for (node in nodes)
        {
            if (node.range.contains(position))
                return node.getRange(position);
        }

        return null;
    }

    public function toString(indent:Int = 0):String
    {
        var space = "";
        for (i in 0...indent)
           space += " ";

        var list = [space + "[QuadTreeDivisions range=" + range.toString() + "]"];
        for (node in nodes)
            list.push(node.toString(indent + 1));

        return list.join("\n");
    }
}