import massive.munit.TestSuite;

import dust.ArrayUtilTest;
import dust.bitfield.BitfieldFactoryTest;
import dust.bitfield.BitfieldListenersTest;
import dust.bitfield.BitfieldTest;
import dust.camera.CameraConfigTest;
import dust.camera.config.CameraDecoratorTest;
import dust.camera.data.CameraTest;
import dust.camera.eg.MoveCameraExampleTest;
import dust.camera.systems.KeysMoveCameraSystemTest;
import dust.collections.api.CollectionTest;
import dust.collections.CollectionsConfigTest;
import dust.collections.control.CollectionMapTest;
import dust.collections.control.CollectionSubscriberTest;
import dust.collections.control.CollectionUpdateTest;
import dust.commands.CommandMapConfigTest;
import dust.commands.CommandMapTest;
import dust.console.ConsoleConfigTest;
import dust.console.impl.ConsoleInputTest;
import dust.console.impl.ConsoleLogTest;
import dust.console.impl.ConsoleMappingTest;
import dust.console.impl.ConsoleMapTest;
import dust.console.impl.ConsoleOutputTest;
import dust.console.impl.ConsoleTest;
import dust.context.ChildContextTest;
import dust.context.ContextConfigsTest;
import dust.context.ContextTest;
import dust.entities.EntitiesConfigTest;
import dust.entities.EntitiesTest;
import dust.entities.EntityListTest;
import dust.entities.EntityTest;
import dust.FloatUtilTest;
import dust.geom.CircleTest;
import dust.graphics.CanvasConfigTest;
import dust.graphics.PrioritizedPaintersConfigTest;
import dust.gui.data.ColorTest;
import dust.InjectorTest;
import dust.interactive.InteractiveConfigTest;
import dust.keys.impl.KeyControlsTest;
import dust.keys.KeysConfigTest;
import dust.lists.LinkedListTest;
import dust.lists.PooledListTest;
import dust.lists.PoolTest;
import dust.lists.SimpleListTest;
import dust.lists.SortedListTest;
import dust.mainmenu.MainMenuConfigTest;
import dust.ParentInjectorTest;
import dust.position.PositionTest;
import dust.quadtree.control.LineSegmentIntersectionTest;
import dust.quadtree.data.QuadTreeAtomTest;
import dust.quadtree.data.QuadTreeDivisionsTest;
import dust.quadtree.data.QuadTreeRangeTest;
import dust.quadtree.data.QuadTreeTest;
import dust.signals.SignalMapConfigTest;
import dust.signals.SignalMapTest;
import dust.stats.RollingMeanTest;
import dust.systems.impl.CollectionSortsTest;
import dust.systems.impl.SystemMappingTest;
import dust.systems.impl.SystemMapTest;
import dust.systems.impl.SystemMetricsTest;
import dust.systems.impl.SystemsTest;
import dust.systems.impl.TimedSystemTest;
import dust.systems.SystemMetricsConfigTest;
import dust.systems.systems.SortCollectionsSystemTest;
import dust.systems.systems.UpdateCollectionsSystemTest;
import dust.systems.SystemsConfigTest;
import dust.text.control.BitmapFontCharFactoryTest;
import dust.text.control.BitmapFontFactoryTest;
import dust.text.control.BitmapTextFactoryTest;
import dust.tween.systems.TweenSystemTest;
import dust.type.TypeIndexTest;
import dust.type.TypeMapTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(dust.ArrayUtilTest);
		add(dust.bitfield.BitfieldFactoryTest);
		add(dust.bitfield.BitfieldListenersTest);
		add(dust.bitfield.BitfieldTest);
		add(dust.camera.CameraConfigTest);
		add(dust.camera.config.CameraDecoratorTest);
		add(dust.camera.data.CameraTest);
		add(dust.camera.eg.MoveCameraExampleTest);
		add(dust.camera.systems.KeysMoveCameraSystemTest);
		add(dust.collections.api.CollectionTest);
		add(dust.collections.CollectionsConfigTest);
		add(dust.collections.control.CollectionMapTest);
		add(dust.collections.control.CollectionSubscriberTest);
		add(dust.collections.control.CollectionUpdateTest);
		add(dust.commands.CommandMapConfigTest);
		add(dust.commands.CommandMapTest);
		add(dust.console.ConsoleConfigTest);
		add(dust.console.impl.ConsoleInputTest);
		add(dust.console.impl.ConsoleLogTest);
		add(dust.console.impl.ConsoleMappingTest);
		add(dust.console.impl.ConsoleMapTest);
		add(dust.console.impl.ConsoleOutputTest);
		add(dust.console.impl.ConsoleTest);
		add(dust.context.ChildContextTest);
		add(dust.context.ContextConfigsTest);
		add(dust.context.ContextTest);
		add(dust.entities.EntitiesConfigTest);
		add(dust.entities.EntitiesTest);
		add(dust.entities.EntityListTest);
		add(dust.entities.EntityTest);
		add(dust.FloatUtilTest);
		add(dust.geom.CircleTest);
		add(dust.graphics.CanvasConfigTest);
		add(dust.graphics.PrioritizedPaintersConfigTest);
		add(dust.gui.data.ColorTest);
		add(dust.InjectorTest);
		add(dust.interactive.InteractiveConfigTest);
		add(dust.keys.impl.KeyControlsTest);
		add(dust.keys.KeysConfigTest);
		add(dust.lists.LinkedListTest);
		add(dust.lists.PooledListTest);
		add(dust.lists.PoolTest);
		add(dust.lists.SimpleListTest);
		add(dust.lists.SortedListTest);
		add(dust.mainmenu.MainMenuConfigTest);
		add(dust.ParentInjectorTest);
		add(dust.position.PositionTest);
		add(dust.quadtree.control.LineSegmentIntersectionTest);
		add(dust.quadtree.data.QuadTreeAtomTest);
		add(dust.quadtree.data.QuadTreeDivisionsTest);
		add(dust.quadtree.data.QuadTreeRangeTest);
		add(dust.quadtree.data.QuadTreeTest);
		add(dust.signals.SignalMapConfigTest);
		add(dust.signals.SignalMapTest);
		add(dust.stats.RollingMeanTest);
		add(dust.systems.impl.CollectionSortsTest);
		add(dust.systems.impl.SystemMappingTest);
		add(dust.systems.impl.SystemMapTest);
		add(dust.systems.impl.SystemMetricsTest);
		add(dust.systems.impl.SystemsTest);
		add(dust.systems.impl.TimedSystemTest);
		add(dust.systems.SystemMetricsConfigTest);
		add(dust.systems.systems.SortCollectionsSystemTest);
		add(dust.systems.systems.UpdateCollectionsSystemTest);
		add(dust.systems.SystemsConfigTest);
		add(dust.text.control.BitmapFontCharFactoryTest);
		add(dust.text.control.BitmapFontFactoryTest);
		add(dust.text.control.BitmapTextFactoryTest);
		add(dust.tween.systems.TweenSystemTest);
		add(dust.type.TypeIndexTest);
		add(dust.type.TypeMapTest);
	}
}
