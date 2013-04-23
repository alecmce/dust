package dust.quadtree.data;

import dust.geom.data.Position;
import dust.components.Component;

class QuadTree<T> extends Component
{
    public var range:QuadTreeRange;
    public var maxDataPerNode:Int;

//    public var atomProvider:QuadTreeRange->Int->QuadTreeAtom;
//    public var divisionsProvider:QuadTreeRange->Int->QuadTreeDivisions;

    var list:Array<QuadTreeData<T>>;
    var root:QuadTreeNode<T>;
    var threshold:Float;

    public function new(range:QuadTreeRange, maxDataPerNode:Int, threshold:Float)
    {
        this.range = range;
        this.maxDataPerNode = maxDataPerNode;
        this.threshold = threshold;

        this.list = new Array<QuadTreeData<T>>();
        this.root = new QuadTreeAtom(range, maxDataPerNode, threshold);

//        this.atomProvider = makeAtom;
//        this.divisionsProvider = makeDivision;
    }

//        function makeAtom(range:QuadTreeRange, maxDataPerNode:Int):QuadTreeAtom
//            return new QuadTreeAtom(range, maxDataPerNode)
//
//        function makeDivision(range:QuadTreeRange, maxDataPerNode:Int):QuadTreeDivisions
//            return new QuadTreeDivisions(range, maxDataPerNode)

    public function add(position:Position, data:T)
    {
        if (range.contains(position))
            addToRoot(new QuadTreeData<T>(position, data));
    }

        function addToRoot(data:QuadTreeData<T>)
        {
            list.push(data);
            root = root.add(data);
        }

    public function update()
    {
        root = new QuadTreeAtom(range, maxDataPerNode, threshold);
        for (data in list)
            root = root.add(data);
    }

    public function clear()
    {
        root = new QuadTreeAtom(range, maxDataPerNode, threshold);
        untyped list.length = 0;
    }

    public function getData(range:QuadTreeRange)
    {
        var output = new Array<T>();
        root.populateDataInRange(range, output);
        return output;
    }

    public function getRanges(range:QuadTreeRange):Array<QuadTreeRange>
    {
        var output = new Array<QuadTreeRange>();
        root.populateRanges(range, output);
        return output;
    }

    public function toString():String
        return "QuadTree range=" + range + ", maxDataPerNode=" + maxDataPerNode + ", threshold=" + threshold + "]"
}
