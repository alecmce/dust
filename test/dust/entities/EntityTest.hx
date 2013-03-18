package dust.entities;

import dust.entities.impl.PooledEntities;
import dust.components.MockComponentB;
import dust.components.MockComponentA;
import dust.components.BitfieldFactory;
import dust.entities.api.Entities;
import dust.lists.Pool;
import dust.components.Component;
import dust.components.Bitfield;
import dust.entities.api.Entity;
import massive.munit.async.AsyncFactory;

class EntityTest
{
    var bitfieldFactory:BitfieldFactory;

    var entities:Entities;
    var entity:Entity;

	@Before public function before()
    {
        bitfieldFactory = new BitfieldFactory();
        entities = new PooledEntities(bitfieldFactory);
        entity = entities.require();
    }

	@Test public function addingComponentReportsTrue()
	{
		Assert.isTrue(entity.add(new MockComponentA()));
	}

    @Test public function byDefaultHasReportsFalse()
    {
        Assert.isFalse(entity.has(MockComponentA));
    }

    @Test public function afterAddingComponentHasReportsTrue()
    {
        entity.add(new MockComponentA());
        Assert.isTrue(entity.has(MockComponentA));
    }

	@Test public function canGetAddedComponent()
	{
		var mock = new MockComponentA();
		entity.add(mock);
		Assert.areEqual(mock, entity.get(MockComponentA));
	}

	@Test public function adding_same_component_twice_fails()
	{
		entity.add(new MockComponentA());
		Assert.isFalse(entity.add(new MockComponentA()));
	}

	@Test public function removing_added_component_reports_true()
	{
		entity.add(new MockComponentA());
		Assert.isTrue(entity.remove(MockComponentA));
	}

	@Test public function removing_component_that_is_not_added_reports_false()
	{
		Assert.isFalse(entity.remove(MockComponentA));
	}

	@Test public function retrievingNonExistentComponentReturnsNull()
	{
		Assert.isNull(entity.get(MockComponentB));
	}

    @Test public function hasReportsFalseAfterRemove()
    {
        var component = new MockComponentA();
        entity.add(component);
        entity.remove(MockComponentA);
        Assert.isFalse(entity.has(MockComponentA));
    }

    @Test public function componentIsAvailableAfterRemove()
    {
        var component = new MockComponentA();
        entity.add(component);
        entity.remove(MockComponentA);
        Assert.areSame(component, entity.get(MockComponentA));
    }

    @Test public function removedComponentIsUnavailableAfterUpdate()
    {
        var component = new MockComponentA();
        entity.add(component);
        entity.remove(MockComponentA);
        entity.update();
        Assert.isNull(entity.get(Component));
    }

    @Test public function disposeAndUpdateRemovesAllComponents()
    {
        entity.add(new MockComponentA());
        entity.dispose();
        entity.update();
        Assert.isFalse(entity.has(MockComponentA));
    }

    @Test public function entityReportsThatItDoesNotSatisfySupersetBitfield()
    {
        var components:Array<Class<Component>> = [MockComponentA, MockComponentB];
        var superset = bitfieldFactory.make(components);

        entity.add(new MockComponentA());
        Assert.isFalse(entity.satisfies(superset));
    }

    @Test public function entityReportsThatItDoesSatisfySubsetBitfield()
    {
        var components:Array<Class<Component>> = [MockComponentA];
        var subset = bitfieldFactory.make(components);

        entity.add(new MockComponentA());
        entity.add(new MockComponentB());
        Assert.isTrue(entity.satisfies(subset));
    }

    @Test public function canSpecifyToAddAsBaseclass()
    {
        entity.add(new ExtendedComponent(), BaseComponent);
        Assert.isTrue(entity.has(BaseComponent));
    }

    @Test public function canReferenceElementAddedAsBaseClassViaBaseClass()
    {
        var instance = new ExtendedComponent();
        entity.add(instance, BaseComponent);
        Assert.areSame(instance, entity.get(BaseComponent));
    }

    @Test public function disposeRemovesBaseClassedElement()
    {
        var instance = new ExtendedComponent();
        entity.add(instance, BaseComponent);
        entity.dispose();
    }
}

class BaseComponent extends Component
{
    public function new() {}
}

class ExtendedComponent extends BaseComponent
{

}