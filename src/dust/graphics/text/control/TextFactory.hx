package dust.graphics.text.control;

import dust.gui.data.VAlign;
import dust.gui.data.HAlign;
import dust.gui.data.Alignment;
import snake.offsets.data.PositionOffset;
import dust.entities.Entity;
import dust.graphics.text.data.TextData;
import dust.graphics.control.XYPlaneSurfaceFactory;
import snake.offsets.data.PositionOffset;
import dust.graphics.text.data.Char;
import dust.entities.Entity;
import dust.geom.data.Position;
import dust.entities.Entities;
import dust.graphics.text.data.Text;
import flash.geom.Rectangle;

class TextFactory
{
    @inject public var entities:Entities;
    @inject public var factory:XYPlaneSurfaceFactory;

    var x:Float;
    var y:Float;
    var data:TextData;

    var left:Float;
    var right:Float;
    var top:Float;
    var bottom:Float;

    public function apply(data:TextData, master:Entity):Entity
    {
        return master == null ? make(data) : applyTo(data, master);
    }

        function applyTo(data:TextData, master:Entity):Entity
        {
            var text:Text = master.get(Text);
            resetBounds(data);
            resizeChars(text.characters, data.text.length);
            applyChars(text.characters, data.alignment);
            return master;
        }

            function resetBounds(data:TextData)
            {
                left = 0.0;
                top = data.font.lineHeight;
                right = 0.0;
                bottom = data.height;
            }

        function resizeChars(list:Array<Entity>, count:Int)
        {
            var delta = count - list.length;
            if (delta < 0)
                removeExtraEntities(list, -delta);
            else
                addExtraEntities(list, delta);
        }

            function removeExtraEntities(list:Array<Entity>, delta:Int)
            {
                while (delta-- > 0)
                    list.shift().dispose();
            }

            function addExtraEntities(list:Array<Entity>, delta:Int)
            {
                while (delta-- > 0)
                    list.push(entities.require());
            }

    public function make(data:TextData):Entity
    {
        this.data = data;
        resetBounds(data);
        return makeMaster();
    }

        function makeMaster():Entity
        {
            var text = new Text();
            text.characters = makeEntities();
            applyChars(text.characters, data.alignment);

            var entity = entities.require();
            entity.add(data);
            entity.add(data.color);
            entity.add(new Position());
            entity.add(data.offset);
            entity.add(text);
            return entity;
        }

            function makeEntities():Array<Entity>
            {
                var list = new Array<Entity>();
                for (i in 0...data.text.length)
                    list.push(makeEntity());
                return list;
            }

                inline function makeEntity()
                {
                    var entity = entities.require();
                    entity.add(new PositionOffset(data.offset.source, 0, 0));
                    entity.add(new Position());
                    return entity;
                }

            function applyChars(entities:Array<Entity>, alignment:Alignment)
            {
                x = 0;
                y = 0;

                var dx = data.offset.dx;
                var dy = data.offset.dy;

                for (i in 0...data.text.length)
                {
                    var char = data.font.getChar(data.text.charCodeAt(i));
                    if (char != null)
                    {
                        applyChar(entities[i], char, dx + x + char.dx, dy + y + char.dy);
                        updateBounds(char);
                    }
                }

                applyAlignment(alignment, entities);
            }

                function applyChar(entity:Entity, char:Char, x:Float, y:Float)
                {
                    var surface = factory.makeRectangle(0, 0, char.bounds.width, char.bounds.height);

                    entity.add(char);
                    entity.add(data.color);
                    entity.add(char.texture);
                    entity.add(surface);
                    entity.get(PositionOffset).set(data.offset.source, x, y, 0);
                }

                function updateBounds(char:Char)
                {
                    x += char.advance - data.condense;

                    var t = y + char.dy;
                    if (t < top)
                        top = t;

                    var r = x + char.dx;
                    if (r > right)
                        right = r;

                    var b = y + char.dy + char.bounds.height;
                    if (b > bottom)
                        bottom = b;
                }

                function applyAlignment(alignment:Alignment, characters:Array<Entity>)
                {
                    var dx = getDX(alignment.hAlign);
                    var dy = getDY(alignment.vAlign);
                    for (entity in characters)
                        entity.get(PositionOffset).offset(dx, dy, 0.0);
                }

                    function getDX(hAlign:HAlign):Float
                    {
                        return switch (hAlign)
                        {
                            case HAlign.LEFT:
                                0;
                            case HAlign.CENTER:
                                -(left + right) * 0.5;
                            case HAlign.RIGHT:
                                -right;
                        }
                    }

                    function getDY(vAlign:VAlign):Float
                    {
                        return switch (vAlign)
                        {
                            case VAlign.TOP:
                                0;
                            case VAlign.MIDDLE:
                                -(top + bottom) * 0.5;
                            case VAlign.BOTTOM:
                                -bottom;
                        }
                    }

}
