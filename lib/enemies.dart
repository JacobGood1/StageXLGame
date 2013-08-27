part of main;
abstract class Enemies extends GameSprite
{
  Enemies(String bitmapInfo):super(bitmapInfo)
  {
    juggler.add(this);
  }
  
  
}

class Goomba extends Enemies
{
  Goomba():super('goomba')
  {
    x = 100;
    y = 100;
    scaleX = .5;
    scaleY = .5;
  }
  
  bool advanceTime(num time)
  {
    /*if(isHit([player]))
    {
      return false;
    }*/
    return true;
  }
  
}
