package dust.tween.curves;

class Sine
{

	inline static var HALF_PI = Math.PI * 0.5;

	inline public static function easeIn(p:Float):Float
	{
		return 1 - Math.cos(-p * HALF_PI);
	}

	inline public static function easeOut(p:Float):Float
	{
		return Math.sin(p * HALF_PI);
	}

	inline public static function easeInOut(p:Float):Float
	{
		return -0.5 * (Math.cos(Math.PI * p) - 1);
	}
	
}