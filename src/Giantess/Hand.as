package Giantess 
{
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import Giantess.*;
	import Registry;
	/**
	 * This is hand of the G, if the player is too close to the G then the hand will be activated 
	 * @author 
	 */
	public class Hand extends FlxSprite
	{
		private var releaseCount:int;
		
		public function Hand(X:int, Y:int) 
		{
			super(X, Y);
			this.makeGraphic(25, 25, 0xffaa1111);
			releaseCount = 0;
			
		}
		
		override public function update():void
		{
			super.update();
			
			//If the player is too close to the follow object then stop the G and start the hand 
			if (Registry.followO.attackNumber == 2){
				FlxVelocity.moveTowardsObject(this, Registry.player, 100); //Move the hand 
				Registry.elevator1.down = true;//Stop the g from moving
				Registry.elevator2.down = true;
				
					if (this.overlaps(Registry.player)) //When the hand touches the player
					{
						//Registry.player.moves = false;
						
						this.velocity.y = -50; //Once it touches the player and the player stops move up
						
						Registry.player.y = this.y; //This will have to be modified once we add the real sprite in
						Registry.player.x = this.x;
						 
					//Hand capture
					//This is where the player will button mash the space bar to get released from the G
					
						if (FlxG.keys.justReleased("SPACE"))
						{
							releaseCount += 1;
							if (releaseCount > 2) //If the count is greater that 2, then release the player. 
							{
								Registry.player.x = this.x+ 10
								Registry.player.y = this.y + 25;
							}
						}
					
						if (this.y > 220) // If the player isn't releaseed by the time the hand moves away from the screen, kill the player
							Registry.player.kill();
					}
						Registry.followO.attackNumber = 0; //Reset the attack number
			}
		}//End of Update
	}

}