package dust.type;


class TypeIndexTest
{
    @Test public function reflectorGoesAbove32()
    {
        TypeIndex.getClassID(TypeExample1);
        TypeIndex.getClassID(TypeExample2);
        TypeIndex.getClassID(TypeExample3);
        TypeIndex.getClassID(TypeExample4);
        TypeIndex.getClassID(TypeExample5);
        TypeIndex.getClassID(TypeExample6);
        TypeIndex.getClassID(TypeExample7);
        TypeIndex.getClassID(TypeExample8);
        TypeIndex.getClassID(TypeExample9);
        TypeIndex.getClassID(TypeExample10);
        TypeIndex.getClassID(TypeExample11);
        TypeIndex.getClassID(TypeExample12);
        TypeIndex.getClassID(TypeExample13);
        TypeIndex.getClassID(TypeExample14);
        TypeIndex.getClassID(TypeExample15);
        TypeIndex.getClassID(TypeExample16);
        TypeIndex.getClassID(TypeExample17);
        TypeIndex.getClassID(TypeExample18);
        TypeIndex.getClassID(TypeExample19);
        TypeIndex.getClassID(TypeExample20);
        TypeIndex.getClassID(TypeExample21);
        TypeIndex.getClassID(TypeExample22);
        TypeIndex.getClassID(TypeExample23);
        TypeIndex.getClassID(TypeExample24);
        TypeIndex.getClassID(TypeExample25);
        TypeIndex.getClassID(TypeExample26);
        TypeIndex.getClassID(TypeExample27);
        TypeIndex.getClassID(TypeExample28);
        TypeIndex.getClassID(TypeExample29);
        TypeIndex.getClassID(TypeExample30);
        TypeIndex.getClassID(TypeExample31);
        TypeIndex.getClassID(TypeExample32);
        Assert.isTrue(TypeIndex.getClassID(TypeExample33) > 32);
    }
}

class TypeExample1 {}
class TypeExample2 {}
class TypeExample3 {}
class TypeExample4 {}
class TypeExample5 {}
class TypeExample6 {}
class TypeExample7 {}
class TypeExample8 {}
class TypeExample9 {}
class TypeExample10 {}
class TypeExample11 {}
class TypeExample12 {}
class TypeExample13 {}
class TypeExample14 {}
class TypeExample15 {}
class TypeExample16 {}
class TypeExample17 {}
class TypeExample18 {}
class TypeExample19 {}
class TypeExample20 {}
class TypeExample21 {}
class TypeExample22 {}
class TypeExample23 {}
class TypeExample24 {}
class TypeExample25 {}
class TypeExample26 {}
class TypeExample27 {}
class TypeExample28 {}
class TypeExample29 {}
class TypeExample30 {}
class TypeExample31 {}
class TypeExample32 {}
class TypeExample33 {}