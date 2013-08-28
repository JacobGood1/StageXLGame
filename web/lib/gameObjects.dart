part of main;

class Bomb extends GameSprite
{
  var norm,
      xMovement,
      yMovement;
  Bomb():super('bomb')
  {
    setX = player.xPos;
    setY = player.yPos;
    
    norm = distanceToMouse;
    xMovement = mouseDistanceX / norm;
    yMovement = mouseDistanceY / norm;
  }
  
  void personalUpdate()
  {
    print(gameSprites.length);
    vx = xMovement;
    vy = yMovement;
  }
  void collision()
  {
    gameSprites.forEach((sprite)
        {
          if(this != sprite && sprite.ID != "player")
          {
            collide(sprite);
          }
        });
  }
  void terminate(){} 
}