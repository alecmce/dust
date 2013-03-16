package dust.tween.curves;

class Cubic
{

	inline public static function easeIn(p:Float):Float
	{
		return p * p * p;
	}
	
	inline public static function easeOut(p:Float):Float
	{
		return (p -= 1) * p * p + 1;
	}

	inline public static function easeInOut(p:Float):Float
	{
		var n = 0.0;
		
		if ((p *= 2) < 1)
			n = .5 * p * p * p;
		else
			n = ((p -= 2) * p * p + 2) * .5;
		
		return n;
	}
	
}