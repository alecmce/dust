import massive.munit.TestSuite;

import dust.app.CommandMapConfigTest;
import dust.app.SignalMapConfigTest;
import dust.ArrayUtilTest;
import dust.camera.CameraConfigTest;
import dust.camera.config.CameraDecoratorTest;
import dust.camera.data.CameraTest;
import dust.camera.eg.KeysMoveCameraSystemTest;
import dust.camera.eg.MoveCameraExampleTest;
import dust.canvas.CanvasConfigTest;
import dust.canvas.control.PrioritizedPaintersSystemTest;
import dust.canvas.data.PaintTest;
import dust.canvas.PrioritizedPaintersConfigTest;
import dust.collections.api.CollectionTest;
import dust.collections.CollectionsConfigTest;
import dust.collections.control.CollectionMapTest;
import dust.collections.control.CollectionSubscriberTest;
import dust.commands.CommandMapTest;
import dust.components.BitfieldFactoryTest;
import dust.components.BitfieldListenersTest;
import dust.components.BitfieldTest;
import dust.console.ConsoleConfigTest;
import dust.console.impl.ConsoleInputTest;
import dust.console.impl.ConsoleLogTest;
import dust.console.impl.ConsoleMappingTest;
import dust.console.impl.ConsoleMapTest;
import dust.console.impl.ConsoleOutputTest;
import dust.console.impl.ConsoleTest;
import dust.context.ContextTest;
import dust.entities.EntitiesConfigTest;
import dust.entities.EntitiesTest;
import dust.entities.EntityTest;
import dust.entities.SimpleEntityListTest;
import dust.FloatUtilTest;
import dust.geom.CircleTest;
import dust.interactive.control.MouseSystemTest;
import dust.interactive.InteractiveConfigTest;
import dust.keys.impl.KeyControlsTest;
import dust.keys.KeysConfigTest;
import dust.lists.LinkedListTest;
import dust.lists.PooledListTest;
import dust.lists.PoolTest;
import dust.lists.SimpleListTest;
import dust.lists.SortedListTest;
import dust.position.PositionTest;
import dust.quadtree.control.LineSegmentIntersectionTest;
import dust.quadtree.data.QuadTreeAtomTest;
import dust.quadtree.data.QuadTreeDivisionsTest;
import dust.quadtree.data.QuadTreeRangeTest;
import dust.quadtree.data.QuadTreeTest;
import dust.signals.SignalMapTest;
import dust.stats.RollingMeanTest;
import dust.systems.impl.SystemMetricsTest;
import dust.systems.SystemMappingTest;
import dust.systems.SystemMapTest;
import dust.systems.SystemMetricsConfigTest;
import dust.systems.SystemsConfigTest;
import dust.systems.SystemsTest;
import dust.systems.TimedSystemTest;
import dust.tween.systems.TweenSystemTest;
import dust.type.TypeIndexTest;
import dust.type.TypeMapTest;
import dust.ui.components.ColorTest;
import dust.ui.LabelTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(dust.app.CommandMapConfigTest);
		add(dust.app.SignalMapConfigTest);
		add(dust.ArrayUtilTest);
		add(dust.camera.CameraConfigTest);
		add(dust.camera.config.CameraDecoratorTest);
		add(dust.camera.data.CameraTest);
		add(dust.camera.systems.KeysMoveCameraSystemTest);
		add(dust.camera.eg.MoveCameraExampleTest);
		add(dust.canvas.CanvasConfigTest);
		add(dust.canvas.control.PrioritizedPaintersSystemTest);
		add(dust.canvas.data.PaintTest);
		add(dust.canvas.PrioritizedPaintersConfigTest);
		add(dust.collections.api.CollectionTest);
		add(dust.collections.CollectionsConfigTest);
		add(dust.collections.control.CollectionMapTest);
		add(dust.collections.control.CollectionSubscriberTest);
		add(dust.commands.CommandMapTest);
		add(dust.components.BitfieldFactoryTest);
		add(dust.components.BitfieldListenersTest);
		add(dust.components.BitfieldTest);
		add(dust.console.ConsoleConfigTest);
		add(dust.console.impl.ConsoleInputTest);
		add(dust.console.impl.ConsoleLogTest);
		add(dust.console.impl.ConsoleMappingTest);
		add(dust.console.impl.ConsoleMapTest);
		add(dust.console.impl.ConsoleOutputTest);
		add(dust.console.impl.ConsoleTest);
		add(dust.context.ContextTest);
		add(dust.entities.EntitiesConfigTest);
		add(dust.entities.EntitiesTest);
		add(dust.entities.EntityTest);
		add(dust.entities.SimpleEntityListTest);
		add(dust.FloatUtilTest);
		add(dust.geom.CircleTest);
		add(dust.interactive.control.MouseSystemTest);
		add(dust.interactive.InteractiveConfigTest);
		add(dust.keys.impl.KeyControlsTest);
		add(dust.keys.KeysConfigTest);
		add(dust.lists.LinkedListTest);
		add(dust.lists.PooledListTest);
		add(dust.lists.PoolTest);
		add(dust.lists.SimpleListTest);
		add(dust.lists.SortedListTest);
		add(dust.position.PositionTest);
		add(dust.quadtree.control.LineSegmentIntersectionTest);
		add(dust.quadtree.data.QuadTreeAtomTest);
		add(dust.quadtree.data.QuadTreeDivisionsTest);
		add(dust.quadtree.data.QuadTreeRangeTest);
		add(dust.quadtree.data.QuadTreeTest);
		add(dust.signals.SignalMapTest);
		add(dust.stats.RollingMeanTest);
		add(dust.systems.impl.SystemMetricsTest);
		add(dust.systems.SystemMappingTest);
		add(dust.systems.SystemMapTest);
		add(dust.systems.SystemMetricsConfigTest);
		add(dust.systems.SystemsConfigTest);
		add(dust.systems.SystemsTest);
		add(dust.systems.TimedSystemTest);
		add(dust.tween.systems.TweenSystemTest);
		add(dust.type.TypeIndexTest);
		add(dust.type.TypeMapTest);
		add(dust.ui.components.ColorTest);
		add(dust.ui.LabelTest);
	}
}
