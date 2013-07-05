package dust.type;

import haxe.macro.Expr.ExprOf;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.Type;

class TypeIndex
{
    static var types:Map<String, Int>;
    static var nextId:Int;

    macro public static function getInstanceID(component:Expr):Expr
    {
        var name = getTypeName(Context.follow(Context.typeof(component), false));
        var index = mapNameToID(name);
        trace('TypeIndex $name => $index');
        return Context.makeExpr(index, component.pos);
    }

    macro public static function getClassID(component:Expr):Expr
    {
        var name = getTypeName(Context.typeof(component));
        var index = mapNameToID(name);
        trace('TypeIndex $name => $index');
        return Context.makeExpr(index, component.pos);
    }

    #if macro
	static function getTypeName(type:Type):String
	{
		var str = new StringBuf();

		switch(type)
		{
			case TInst(ref, params):
				trace('TInst $ref,$params');
				str.add(parseTypeRef(ref));
				str.add(parseParams(params));
			case TEnum(ref, params):
				trace('TEnum $ref,$params');
				str.add(parseTypeRef(ref));
				str.add(parseParams(params));
			case TAnonymous(ref):
				trace('TAnonymous $ref');
				var fields:Array<ClassField> = ref.get().fields;
				str.addChar("{".code);
				var fieldStrArr = Lambda.map(fields, function(field) { return field.name + ":" + getTypeName(field.type); } );
				str.add(fieldStrArr.join(","));
				str.addChar("}".code);
			case TFun(args, ret):
				trace('TFun $args,$ret');
				var argsList = Lambda.map(args, function(arg) { return arg.t; } );
				argsList.add(ret);
				var argsStrList = Lambda.map(argsList, getTypeName);
				if (argsStrList.length == 1)
					argsStrList.push("Void");
				str.add(argsStrList.join("->"));
			case TLazy(f):
				trace('TLazy $f');
				str.add(getTypeName(f()));
			case TMono(ref):
				trace('TMono $ref');
				var val = ref.get();
				if (val == null)
					Context.error("Untyped value. Cannot use, try storing in a manually typed variable", Context.currentPos());
				else
					str.add(getTypeName(val));
			case TDynamic(t):
				trace('TDynamic $t');
				Context.error("Cannot store dynamic values", Context.currentPos());
			case TType(ref, params):
				trace('TType $ref,$params');
				str.add(parseTypeRef(ref));
				str.add(parseParams(params));
			case TAbstract(ref, params):
				trace('TAbstract $ref,$params');
				str.add(parseTypeRef(ref));
				str.add(parseParams(params));
		}

		return StringTools.replace(str.toString(), "#", "");
	}

		static function parseTypeRef<T>(ref:Ref<T>):String
		{
			var def = cast ref.get();
			var list = def.pack.copy();
			list.push(def.name);
			return list.join(".");
		}

		static function parseParams(params:Array<Type>):String
			return params.length == 0 ? "" : stringifyParams(params);

		static function stringifyParams(params:Array<Type>):String
		{
			var str = new StringBuf();
			str.addChar("<".code);
			str.add(Lambda.map(params, getTypeName).join(","));
			str.addChar(">".code);
			return str.toString();
		}

    static function mapNameToID(name:String):Int
    {
        if (types == null)
        {
            nextId = 0;
            types = new Map<String, Int>();
        }

        var index = 0;
        if (types.exists(name))
        {
            index = types.get(name);
        }
        else
        {
            index = nextId++;
            types.set(name, index);
        }

        return index;
    }
    #end
}