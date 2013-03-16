package dust.context;

interface DependentConfig implements Config
{
    function dependencies():Array<Class<Config>>;
}