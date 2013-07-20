package dust.tween;

import dust.tween.data.Tween;
import dust.tween.systems.TweenSystem;
import dust.context.Config;
import dust.context.DependentConfig;
import dust.systems.impl.Systems;
import dust.systems.SystemsConfig;

class TweenConfig implements DependentConfig
{
    @inject public var systems:Systems;

    public function dependencies():Array<Class<Config>>
        return [SystemsConfig];

    public function configure()
    {
        systems.map(TweenSystem)
            .toCollection([Tween])
            .withName("Tween");
    }
}
