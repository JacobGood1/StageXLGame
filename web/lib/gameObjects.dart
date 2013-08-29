part of main;

class Bomb extends GameSprite
{
  var norm,
      xMovement,
      yMovement;
  Bomb():super('bomb')
  {
    collideObjects = ['minotaur'];
    correction = true;
    
    setX = player.xPos;
    setY = player.yPos;
    
    norm = distanceToMouse;
    xMovement = mouseDistanceX / norm;
    yMovement = mouseDistanceY / norm;
  }
  
  void personalUpdate()
  {
    vx = xMovement;
    vy = yMovement;
  }
  void personalCollision(GameSprite sprite)
  {
    if(this != sprite && sprite.ID != "player")
    {
      collide(sprite);
    }
  }
  
  void terminate(){} 
}