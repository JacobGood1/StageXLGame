part of main;

partitionCollisions(List<GameSprite> sprites)
{
  Map checkThese = new Map();
  int history = 0;
  
  for(var i = 0; i < gameSprites.length; i++)
  {
    GameSprite sprite = gameSprites[i];
    checkThese[i] = [sprite];
    
    history += 1;
    for(var j = history; j < gameSprites.length; j++)
    {
      var otherSprite = gameSprites[j];
      if(sprite.collide(otherSprite))
      {
        checkThese[i].add(otherSprite);
      }
    }
    if(checkThese[i].length == 1)
    {
      checkThese.remove(i);
    }
  }
  //print(checkThese);
}

class GameLoop extends Animatable
{

  QuadTree quad = new QuadTree(0, new Rectangle(0,0, 800, 600));
  
  advanceTime(num time)
  {
    quad.clear();
    gameSprites.forEach((sprite) => quad.insert(sprite));
    var possibleCollisions = [];
    gameSprites.forEach((sprite)
        {
          possibleCollisions.clear();
          quad.retrieve(possibleCollisions, sprite);
          
          sprite
            ..update()
            ..collision(possibleCollisions)
            ..stageBounds()
            ..x = sprite.xPos
            ..y = sprite.yPos;
          
        });
   
  }
}


abstract class GameWorld extends DisplayObjectContainer
{
  GameWorld()
  {
    //init stage and render loop
    canvas = html.query('#stage');
    stage = new Stage('stage', canvas);
    renderLoop = new RenderLoop();
    renderLoop.addStage(stage);
    juggler = renderLoop.juggler;  
    gameSurface = new GlassPlate(800, 600);
  }
}

class Level1 extends GameWorld
{
  Level1()  
  {
    resourceManager
      ..addBitmapData('mario', 'Assets/MARIO.png')
      ..addBitmapData('bomb', 'Assets/bomb.png')
      ..addBitmapData('minotaur', 'http://guerrasdraconicas.files.wordpress.com/2009/03/minoaturo1.jpg')
      ..addBitmapData('buttonUp', 'http://www.clker.com/cliparts/a/9/3/e/1194984754884631372button-blue_benji_park_01.svg.hi.png')
      
      ..load().then((result)
        {
        gameSurface.onMouseMove.listen((me)
          {
            mouseX = me.localX;
            mouseY = me.localY;
          });
        
        canvas.onMouseDown.listen((me)
            {
              addChild(new Bomb());
            });
        
        addChild(gameSurface);
        
        player = new Player();
        addChild(player);
        
        addChild(new Minotaur());
        juggler.add(new GameLoop());
        // resourceManager end
        });;
        
  }
}