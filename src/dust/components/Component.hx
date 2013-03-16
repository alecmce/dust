package dust.components;

import haxe.macro.Expr.Field;
import haxe.macro.Context;
import haxe.macro.Expr;

@:autoBuild(dust.components.ComponentMacro.setComponentID())
class Component
{
    public static var ID:Int = 0;

    public var componentID(getComponentID, null):Int;
    function getComponentID():Int { return 0; }
}

@:macro class ComponentMacro
{
    static var ID:Int = 1;
    static var components:Array<Dynamic>;

    public static function reset():Void
    {
        ID = 1;
    }

    public static function setComponentID():Array<Field>
    {
        var local = Context.getLocalClass();
        if (components == null)
            components = [local];
        else
            components.push(local);

        var pos = Context.currentPos();
        var wrapExpr = function(expr) return {expr:expr, pos:pos};
        var wrapField = function(name, access, kind) return {name:name, access:access, kind:kind, doc:null, meta:[], pos:pos};

        var value = EConst(CInt(Std.string(ID++)));
        var intType = TPath({pack:[], name:"Int", params:[], sub:null});

        var staticVariable = FVar(intType, wrapExpr(value));
        var staticField = wrapField("ID", [AStatic, APublic], staticVariable);

        var localReturn = wrapExpr(EReturn(wrapExpr(value)));
        var localFunction = FFun({ret:intType, params:[], args:[], expr:localReturn});
        var localField = wrapField("getComponentID", [AOverride], localFunction);

        var fields = Context.getBuildFields();
        fields.push(staticField);
        fields.push(localField);
        return fields;
    }

}