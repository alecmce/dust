package dust.type;

import haxe.macro.Expr.ExprOf;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.Type;

class TypeIndex
{
    static var types:Hash<Int>;
    static var nextId:Int;

    @:macro
    public static function getInstanceID(component:Expr):Expr
    {
        var name = getTypeName(Context.follow(Context.typeof(component), false));
        var index = mapNameToID(name);
        return Context.makeExpr(index, component.pos);
    }

    @:macro
    public static function getClassID(component:Expr):Expr
    {
        var name = getTypeName(Context.typeof(component));
        var index = mapNameToID(name);
        return Context.makeExpr(index, component.pos);
    }

    #if macro
	static function getTypeName(type:Type):String
	{
		var str = new StringBuf();

		switch(type)
		{
			case TInst(classRef, params):
				var typeDef = classRef.get();

				var nameArr = typeDef.pack.copy();
				nameArr.push(typeDef.name);

				str.add(nameArr.join("."));
				if (params.length > 0)
				{
					str.addChar("<".code);
					var pStrArr = Lambda.map(params, getTypeName);
					str.add(pStrArr.join(","));
					str.addChar(">".code);
				}
			case TEnum(enumRef, params):
				var typeDef = enumRef.get();

				var nameArr = typeDef.pack.copy();
				nameArr.push(typeDef.name);

				str.add(nameArr.join("."));
				if (params.length > 0)
				{
					str.addChar("<".code);
					var pStrArr = Lambda.map(params, getTypeName);
					str.add(pStrArr.join(","));
					str.addChar(">".code);
				}
			case TAnonymous(fieldsRef):
				var fields:Array<ClassField> = fieldsRef.get().fields;
				str.addChar("{".code);
				var fieldStrArr = Lambda.map(fields, function(field) { return field.name + ":" + getTypeName(field.type); } );
				str.add(fieldStrArr.join(","));
				str.addChar("}".code);
			case TFun(args, ret):
				var argsList = Lambda.map(args, function(arg) { return arg.t; } );
				argsList.add(ret);
				var argsStrList = Lambda.map(argsList, getTypeName);
				if (argsStrList.length == 1)
					argsStrList.push("Void");
				str.add(argsStrList.join("->"));
			case TLazy(f):
				str.add(getTypeName(f()));
			case TMono(ref):
				var val = ref.get();
				if (val == null)
					Context.error("Untyped value. Cannot use, try storing in a manually typed variable", Context.currentPos());
				else
					str.add(getTypeName(val));
			case TDynamic(t):
				Context.error("Cannot store dynamic values", Context.currentPos());
			case TType(defRef, params):
			    var typeDef = defRef.get();

			    var nameArr = typeDef.pack.copy();
				nameArr.push(typeDef.name);

				str.add(nameArr.join("."));
				if (params.length > 0)
				{
					str.addChar("<".code);
					var pStrArr = Lambda.map(params, getTypeName);
					str.add(pStrArr.join(","));
					str.addChar(">".code);
				}
		}

		return StringTools.replace(str.toString(), "#", "");
	}

    static function mapNameToID(name:String):Int
    {
        if (types == null)
        {
            nextId = 0;
            types = new Hash<Int>();
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