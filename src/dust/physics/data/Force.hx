package dust.physics.data;

import dust.physics.data.Derivative;

interface Force
{
    function apply(state:State, force:Derivative):Void;
}