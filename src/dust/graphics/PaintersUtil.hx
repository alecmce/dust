package dust.graphics;

import dust.graphics.data.Painters;
import dust.graphics.data.Painter;
import dust.entities.api.Entity;

class PaintersUtil
{
    public static function addPainter(entity:Entity, painter:Painter)
    {
        var painters:Painters = entity.get(Painters);
        if (painters == null)
            entity.add(painters = new Painters());

        painters.add(painter);
    }

    public static function removePainter(entity:Entity, painter:Painter)
    {
        var painters:Painters = entity.get(Painters);
        if (painters != null)
            painters.remove(painter);
    }
    
    public static function setPaintersPriority(entity:Entity, priority:Int)
    {
        var painters:Painters = entity.get(Painters);
        if (painters != null)
            painters.setPriority(priority);
    }
}
