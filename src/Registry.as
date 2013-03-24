package  
{
	import org.flixel.FlxRect;
	import Giantess.*;
	import NPC.*;
	import org.flixel.*;
	/**
	 * ...
	 * @author 
	 */
	public class Registry 
	{
		public static var player:Player;
		public static var _humanShooter:shooter;
		public static var _humanReg:humanReg;
		public static var elevator1:Elevator1;
		public static var elevator2:Elevator2;
		public static var followO:followObject;
		public static var map:FlxTilemap;
		public static var hand:Hand;
		
		public static var bounds:FlxRect = new FlxRect(0, 0, FlxG.width, FlxG.height);
	}

}