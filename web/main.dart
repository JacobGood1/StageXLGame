library main;

import 'package:stagexl/stagexl.dart';

import 'dart:html' as html;
import 'dart:math' as math;

part 'lib/entities.dart';
part 'lib/levels.dart';
part 'lib/gameObjects.dart';

math.Random rand = new math.Random();

Stage stage;
RenderLoop renderLoop;
Juggler juggler;
ResourceManager resourceManager = new ResourceManager();
html.Element canvas;
GameSprite player;
List gameSprites = [];

var lvl;

GlassPlate gameSurface;

num mouseX,
    mouseY;

main()
{
  lvl = new Level1();
  stage.addChild(lvl);
}

