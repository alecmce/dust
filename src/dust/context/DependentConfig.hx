package dust.context;

interface DependentConfig extends Config
{
    function dependencies():Array<Class<Config>>;
}