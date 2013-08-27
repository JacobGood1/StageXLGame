part of main;

class Player extends GameSprite
{
  
  int health = 100; 
  
  List keys = [];
  Map keyCodes = new Map();
     
  Player([startX = 0, startY = 0]):super('mario')
  {
    keyCodes[87] = 'w';
    keyCodes[65] = 'a';
    keyCodes[83] = 's';
    keyCodes[68] = 'd';
    
    this
      ..x = startX
      ..y = startY
      ..scaleX = 1/10
      ..scaleY = 1/10
      ..pivotX = width / 2
      ..pivotY = height / 2;
    
    canvas.onKeyDown.listen((keyPressed)
        {
          var key = keyPressed.keyCode;
          if(!keys.contains(key)){keys.add(keyPressed.keyCode);}
          
        });
    canvas.onKeyUp.listen((keyReleased)
        {
          keys.remove(keyReleased.keyCode);
        });
    
    juggler.add(this);
    
  }
  
  bool advanceTime(num time)
  {
    keys.forEach((key) 
        {
          var keyCode = keyCodes[key];
          if(keyCode == 'w'){y -= 3;}
          if(keyCode == 'a'){x -= 3;}
          if(keyCode == 's'){y += 3;}
          if(keyCode == 'd'){x += 3;}
        });
    
    return true;
  }
}



//GAME OBJECTS

class Bomb extends GameSprite
{
  num speed = 200.0,
        _vx,
        _vy,
        _dx,
        _dy;
  
  Bomb():super('bomb')
  {
    
      this
        ..pivotX = width / 2
        ..pivotY = height / 2
        ..x = player.center.x
        ..y = player.center.y;
    
    var magnitude = distanceToMouse;
    
    _dx = mouseDistanceX / magnitude;
    _dy = mouseDistanceY / magnitude;
    
    juggler.add(this);
    
  }
  var rotation_speed = rand.nextInt(100) / 100;
  get rotate
  {
    rotation += rotation_speed;
  }
  
  bool advanceTime(num time)
  {
   
    //rotate;
    if(stageBounds)
    {
      //terminate;
      return false;
    }
    else if(isHit([gameSprites[1]]))
    {
      return false;
    }
    else
    {
      x += _dx * speed * time;
      y += _dy * speed * time;
      return true;  
    }
      
  }
}

//EVIL CHARACTERS

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