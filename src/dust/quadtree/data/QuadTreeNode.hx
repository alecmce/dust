package dust.quadtree.data;

import dust.quadtree.data.QuadTreeRange;

interface QuadTreeNode<T>
{
    var range:QuadTreeRange;

    function add(data:QuadTreeData<T>):QuadTreeNode<T>;
    function populateDataInRange(dataRange:QuadTreeRange, output:Array<T>):Void;
    function populateRanges(dataRange:QuadTreeRange, output:Array<QuadTreeRange>):Void;

    function toString(indent:Int = 0):String;
}