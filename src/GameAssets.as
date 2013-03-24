package  
{
	import org.flixel.FlxSound;

	public class GameAssets 
	{
		//Player Stuff
		[Embed(source = "../src/Data/Images/player.png")] public static var player:Class;
		[Embed(source = "../src/Data/Images/hearts.png")] public static var heartPNG:Class;
		[Embed(source = "../src/Data/Images/blood.png")] public static var blood:Class;
		//G Stuff
		[Embed(source = "../src/Data/Images/g-new_2.png")] public static var elevatorPIC:Class;
		[Embed(source = "../src/Data/Images/g-new_2.png")] public static var elevator2PIC:Class;
		
		//Moving Objects
		[Embed(source =  "../src/Data/Images/humanNew.png")] public static var imgHuman:Class;
		[Embed(source = "../src/Data/Images/bullet.png")] public static var bullet:Class;
		[Embed(source =  "../src/Data/Images/humanHunter.png")] public static var imgHunter:Class;
		
		//Map Stuff
		[Embed(source = "../src/Data/MapData/mapCSV_Group1_Background.csv", mimeType = "application/octet-stream")] public static var backCSV:Class;
		[Embed(source = "../src/Data/MapData/mapCSV_Group1_Main.csv", mimeType = "application/octet-stream")] public static var mainCSV:Class;
		[Embed(source = "../src/Data/MapData/mapCSV_Group1_treeMap.csv", mimeType = "application/octet-stream")] public static var treeCSV:Class;
		[Embed(source = "../src/Data/MapData/mapCSV_Group1_humanMap.csv", mimeType = "application/octet-stream")] public static var humanCSV:Class;
		[Embed(source = "../src/Data/MapData/mapCSV_Group1_woodHouse.csv", mimeType = "application/octet-stream")] public static var woodCSV:Class;
		[Embed(source = "../src/Data/Images/backdrop.png")] public static var skyTilesPNG:Class;
		[Embed(source = "../src/Data/Images/tiles.png")] public static var mapTilesPNG:Class;
		
		//Other Game objects
		[Embed(source = "../src/Data/Images/coin16x16.png")] public static var coin16x16PNG:Class;
		[Embed(source = "../src/Data/Images/leafBits.png")] public static var leafBits:Class;
		[Embed(source = "../src/Data/Images/barkBits.png")] public static var barkBits:Class;
		[Embed(source = "../src/Data/Images/woodHouseNew.png")] public static var woodPNG:Class;
		[Embed(source = "../src/Data/Images/bunker.png")] public static var bunkerPNG:Class;
		[Embed(source = "../src/Data/Images/_woodHouseBits.png")] public static var woodHouseBits:Class;
		[Embed(source = "../src/Data/Images/woodBits.png")] public static var woodBits:Class;
		[Embed(source = "../src/Data/Images/tree1.png")] public static var treePNG:Class;
		[Embed(source = "../src/Data/Images/suv1.png")] public static var suv1PNG:Class;
		[Embed(source = "../src/Data/Images/wheel1.png")] public static var wheel1PNG:Class;
		[Embed(source = "../src/Data/Images/glass1.png")] public static var glass1PNG:Class;
		
		//Sounds
		[Embed(source = "../src/Data/Sounds/hurtPlayer.mp3")] public static var playerHit:Class;
		[Embed(source = "../src/Data/Sounds/82371__gynation__paper-crush-medium-2.mp3")] public static var humanHit:Class;
		[Embed(source = "../src/Data/Sounds/humanScream1.mp3")] public static var humanScream1:Class;
		[Embed(source = "../src/Data/Sounds/coinPickup.mp3")] public static var coinGet:Class;
		[Embed(source = "../src/Data/Sounds/35642__sandyrb__boom2.mp3")] public static var stompBoom:Class;
		//[Embed(source = "../src/Data/Sounds/35642__sandyrb__boom2.mp3")] public static var gGrunt:Class;
		[Embed(source = "../src/Data/Sounds/gLaugh.mp3")] public static var gLaugh:Class;
		[Embed(source = "../src/Data/Sounds/stompTree.mp3")] public static var stompTree:Class;
		
	}

}