package dust.collections.control;

import dust.collections.data.CollectionList;
import dust.collections.api.Collection;
import dust.Injector;
import dust.components.BitfieldFactory;
import dust.entities.EntityList;
import dust.components.Bitfield;
import dust.entities.Entities;
import dust.lists.LinkedList;
import dust.lists.SimpleList;

import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.Type;

class CollectionMap
{
    @inject public var injector:Injector;
    @inject public var bitfieldFactory:BitfieldFactory;
    @inject public var entities:Entities;
    @inject public var collectionList:CollectionList;
    @inject public var subscriber:CollectionSubscriber;

    var configMap:Map<String, CollectionMapping>;

    public function new()
        configMap = new Map<String, CollectionMapping>();

    macro public function map(self:ExprOf<CollectionMap>, components:Expr):Expr
    {
        var ids = macro dust.type.TypeIndex.getClassIDList($components, '${self.pos}');
        return macro (untyped $self.mapDefined)($ids);
    }

        function mapDefined(ids:Array<Int>):CollectionMapping
        {
            var bitfield = bitfieldFactory.makeDefined(ids);
            var key = bitfield.toString();
            return getOrMakeMapping(key, bitfield);
        }

    public function mapBitfield(bitfield:Bitfield):CollectionMapping
    {
        var key = bitfield.toString();
        return getOrMakeMapping(key, bitfield);
    }

        function getOrMakeMapping(key:String, bitfield:Bitfield):CollectionMapping
        {
            return if (configMap.exists(key))
                configMap.get(key);
            else
                makeAndRecordMapping(key, bitfield);
        }

        function makeAndRecordMapping(key:String, bitfield:Bitfield):CollectionMapping
        {
            var config = new CollectionMapping(injector, bitfield, collectionList, subscriber);
            configMap.set(key, config);
            return config;
        }

    macro public function getCollection(self:ExprOf<CollectionMap>, components:Expr):Expr
    {
        var ids = macro dust.type.TypeIndex.getClassIDList($components, '${self.pos}');
        return macro (untyped $self.getDefined)($ids);
    }

        function getDefined(ids:Array<Int>):Collection
        {
            var bitfield:Bitfield = bitfieldFactory.makeDefined(ids);
            var key = bitfield.toString();
            return getOrMakeMapping(key, bitfield).getCollection();
        }

    public function instantiateAll()
    {
        for (config in configMap)
            config.getCollection();
    }
}