package;

import dust.systems.eg.FastInsertionSortAlgorithmExample;
import dust.Injector;
import dust.ui.eg.UIExample;
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

import nme.Assets;
import nme.display.DisplayObjectContainer;
import nme.display.MovieClip;
import nme.display.Sprite;
import nme.display.Stage;
import nme.events.KeyboardEvent;
import nme.events.MouseEvent;
import nme.ui.Keyboard;
import nme.text.TextField;
import nme.text.TextFormat;

class DustExamples implements DependentConfig
{
    static var app:Context;

    public static function main()
    {
        app = new Context()
            .configure(DustExamples)
            .start(new Sprite());
    }

    @inject public var parent:Context;
    @inject public var root:DisplayObjectContainer;
    @inject public var mainMenu:MainMenu;

    var module:Context;

    public function dependencies():Array<Class<Config>>
        return [MainMenuConfig]

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
            .add("UI", UIExample)
            .add("FastInsertionSort", FastInsertionSortAlgorithmExample);

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
                .configure(config)
                .start(new Sprite());
        }
}