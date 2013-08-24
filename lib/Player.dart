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



