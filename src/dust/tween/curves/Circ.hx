package dust.tween.curves;

class Circ
{

	inline public static function easeIn(p:Float):Float
	{
		return -Math.sqrt(1 - p * p) + 1;
	}
	
	inline public static function easeOut(p:Float):Float
	{
		return Math.sqrt(1 - (p -= 1) * p);
	}

	inline public static function easeInOut(p:Float):Float
	{
		var n = 0.0;
		
		if ((p *= 2) < 1)
			n = -.5 * (Math.sqrt(1 - p * p) - 1);
		else
			n = .5 * (Math.sqrt(1 - (p -= 2) * p) + 1);
		
		return n;
	}
	
}