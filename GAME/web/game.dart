library main;

import 'package:stagexl/stagexl.dart';

import 'dart:html' as html;
import 'dart:math' as math;

part '../lib/Player.dart';
part '../lib/Bomb.dart';
part '../lib/GameSprite.dart';
part '../lib/Vector.dart';


Stage stage;
RenderLoop renderLoop;
Juggler juggler;
ResourceManager resourceManager = new ResourceManager();
html.Element canvas;
GameSprite player;

GlassPlate gameSurface;

num mouseX,
    mouseY;



class GameWorld extends DisplayObjectContainer
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
  Vector buttonVector;
  Level1()  
  {
    gameSurface.onMouseMove.listen((me)
        {
      print("still recieving");
          mouseX = me.localX;
          mouseY = me.localY;
        });
    canvas.onMouseDown.listen((me)
        {
          addChild(new Bomb());
        });
    addChild(gameSurface);
    
    resourceManager
      ..addBitmapData('mario', 'Assets/MARIO.png')
      ..addBitmapData('bomb', 'Assets/bomb.png')
      ..addBitmapData('buttonUp', 'http://www.clker.com/cliparts/a/9/3/e/1194984754884631372button-blue_benji_park_01.svg.hi.png')
      ..load().then((result)
        {
          player = new Player(300,300); 
          
          addChild(player);
          
          addChild(new Vector());
        });;
  }
}


main()
{
  var lvl1 = new Level1();
  stage.addChild(lvl1);  
}