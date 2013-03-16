package dust.keys.impl;

import dust.keys.impl.KeyControl;
import dust.lists.LinkedList;

class KeyControls
{
    var controls:LinkedList<KeyControl>;

    public function new(controls:LinkedList<KeyControl>)
    {
        this.controls = controls;
    }

    public function map(key:Int, method:Float->Void):KeyControl
    {
        var control = new KeyControl(key, method);
        controls.append(control);
        return control;
    }

    public function unmap(control:KeyControl)
    {
        controls.remove(control);
    }

    public function iterator():Iterator<KeyControl>
    {
        return controls.iterator();
    }

}
