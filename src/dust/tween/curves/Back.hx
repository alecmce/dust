package dust.tween.curves;

class Back
{

	inline public static function easeIn(p:Float):Float
	{
		return p * p * (2.70158 * p - 1.70158);
	}
	
	inline public static function easeOut(p:Float):Float
	{
		return (p -= 1) * p * (2.70158 * p + 1.70158) + 1;
	}
	
	inline public static function easeInOut(p:Float):Float
	{
		var n = 0.0;
		
		if ((p *= 2) < 1)
			n = .5 * p * p * (3.5949095 * p - 2.5949095);
		else
			n = .5 * ((p -= 2) * p * (3.5949095 * p + 2.5949095) + 2);
		
		return n;
	}
	
}