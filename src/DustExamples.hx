package;

import flash.display.StageScaleMode;
import flash.display.StageAlign;
import dust.physics.eg.PhysicsExample;
import dust.systems.SystemMetricsConfig;
import dust.systems.eg.FastInsertionSortAlgorithmExample;
import dust.gui.eg.GUIExample;
import dust.context.DependentConfig;
import dust.mainmenu.MainMenuConfig;
import dust.text.eg.NoScaleBitmapFontExample;
import dust.text.eg.BitmapFontExample;
import dust.text.eg.BitmapTextExample;
import dust.console.ConsoleConfig;
import dust.context.Config;
import dust.interactive.eg.ReflectionDragExample;
import dust.quadtree.eg.QuadTreeVisualizationExample;
import dust.interactive.eg.OffsetDragExample;
import dust.camera.eg.MoveCameraExample;
import dust.interactive.eg.DragExample;
import dust.mainmenu.MainMenu;
import dust.context.Context;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

class DustExamples implements DependentConfig
{
    static var app:Context;

    public static function main()
    {
        flash.Lib.current.stage.align = StageAlign.TOP_LEFT;
        flash.Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        app = new Context()
            .configure(DustExamples)
            .start(new Sprite());
    }

    @inject public var parent:Context;
    @inject public var root:DisplayObjectContainer;
    @inject public var mainMenu:MainMenu;

    var module:Context;

    public function dependencies():Array<Class<Config>>
        return [MainMenuConfig];

    public function configure()
    {
        mainMenu
            .add("Drag", DragExample)
            .add("OffsetDrag", OffsetDragExample)
            .add("ReflectionDrag", ReflectionDragExample)
            .add("BitmapFont 1", NoScaleBitmapFontExample)
            .add("BitmapFont 2", BitmapFontExample)
            .add("BitmapText", BitmapTextExample)
            .add("QuadTree", QuadTreeVisualizationExample)
            .add("GUI", GUIExample)
            .add("FastInsertionSort", FastInsertionSortAlgorithmExample)
            .add("Physics", PhysicsExample);

        root.addChild(mainMenu);
        mainMenu.reset.bind(onReset);
        mainMenu.selected.bind(onSelection);
        mainMenu.enable();
    }

        function onReset()
        {
            if (module != null)
                module.stop();
            module = null;
        }

        function onSelection(config:Class<Config>)
        {
            module = new Context(parent)
                .configure(MoveCameraExample)
                .configure(ConsoleConfig)
                .configure(SystemMetricsConfig)
                .configure(config)
                .start(new Sprite());
        }
}