package dust.context;

import dust.signals.PromiseVoid;

interface AsyncConfig extends Config
{
    var ready:PromiseVoid;
}
