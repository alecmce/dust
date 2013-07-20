package dust.type;

#if macro
import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.Type;
#end

class TypeIndex
{
	inline static var IGNORE_GENERIC_TYPES = true;

    macro public static function getInstanceID(component:Expr, reference:String):Expr
    {
        var name = getTypeName(Context.follow(Context.typeof(component), false), reference);
        var index = mapNameToID(name);
        return Context.makeExpr(index, component.pos);
    }

    macro public static function getClassID(component:Expr, reference:String):Expr
    {
        var name = getTypeName(Context.typeof(component), reference);
        var index = mapNameToID(name);
        return Context.makeExpr(index, component.pos);
    }

    macro public static function getClassIDList(components:Expr, reference:String):Expr
    {
    	var ids = new Array<Int>();
		switch (components.expr)
		{
			case EArrayDecl(values):
				for (value in values)
				{
					var name = getTypeName(Context.typeof(value), reference);
					var index = mapNameToID(name);
					ids.push(index);
				}
			default:
				Context.error('TypeIndex error: class definition must be explicitly defined in the macro method at at ${Context.getLocalClass()}.${Context.getLocalMethod()}', Context.currentPos());
		}

    	return Context.makeExpr(ids, components.pos);
    }

    #if macro
    static var types:Array<String>;

	static function getTypeName(type:Type, reference:String):String
	{
		var str = new StringBuf();

		switch(type)
		{
			case TInst(ref, params):
				str.add(parseTypeRef(ref));
				str.add(parseParams(params));
			case TEnum(ref, params):
				str.add(parseTypeRef(ref));
				str.add(parseParams(params));
			case TAnonymous(ref):
				var fields:Array<ClassField> = ref.get().fields;
				str.addChar("{".code);
				var fieldStrArr = Lambda.map(fields, function(field) { return '${field.name}:${getTypeName(field.type, reference)}'; });
				str.add(fieldStrArr.join(","));
				str.addChar("}".code);
			case TFun(args, ret):
				
				var namesList = [];
				for (arg in args)
					namesList.push(getTypeName(arg.t, reference));
				namesList.push(getTypeName(ret, reference));
				if (namesList.length == 1)
					namesList.push("Void");

				str.add(namesList.join("->"));

			case TLazy(f):
				str.add(getTypeName(f(), reference));
			case TMono(ref):
				var val = ref.get();
				if (val == null)
					Context.error('Cannot index untyped value, at ${reference}.', Context.currentPos());
				else
					str.add(getTypeName(val, reference));
			case TDynamic(t):
				Context.error('Cannot index dynamic value, at ${reference}', Context.currentPos());
			case TType(ref, params):
				str.add(parseTypeRef(ref));
				str.add(parseParams(params));
			case TAbstract(ref, params):
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

		static function stringifyParams(params:Array<Type>, reference:String = ""):String
		{
			var str = new StringBuf();
			if (!IGNORE_GENERIC_TYPES)
			{
				var names = [];
				for (type in params)
					names.push(getTypeName(type, reference));
				
				str.addChar("<".code);
				str.add(names.join(","));
				str.addChar(">".code);
			}
			return str.toString();
		}

    static function mapNameToID(name:String):Int
    {
        if (types == null)
            types = new Array<String>();

        var isDefined = false;
        var index = types.length;
        while (!isDefined && --index >= 0)
            isDefined = types[index] == name;

        if (!isDefined)
            index = types.push(name) - 1;

        return index + 1;
    }
    #end
}