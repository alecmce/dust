package dust.keys.impl;

import dust.keys.impl.KeyControls;
import dust.systems.System;

import nme.display.Stage;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.ui.Keyboard;

class KeyControllerSystem implements System
{
    var keys:Keys;
    var controls:KeyControls;
    var stage:Stage;
    
    @inject
    public function new(keys:Keys, controls:KeyControls)
    {
        this.keys = keys;
        this.controls = controls;
        this.stage = nme.Lib.current.stage;
    }

    public function start()
    {
        keys.reset();
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }

        function onKeyDown(event:KeyboardEvent)
        {
            keys.setKeyDown(event.keyCode);
        }

        function onKeyUp(event:KeyboardEvent)
        {
            keys.setKeyUp(event.keyCode);
        }

    public function stop()
    {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }

    public function iterate(deltaTime:Float)
    {
        for (control in controls)
            if (keys.isDown(control.key))
                control.call(deltaTime);
    }
}
