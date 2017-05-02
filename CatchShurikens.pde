// LoubiTek| Catch Shuriken's | 2017

// Booleans
boolean GameLoop = true;
boolean Intro = true;
boolean Collide = true;
boolean Event = true;
boolean Game = true;

boolean DebugsMode = false;

// Init
void Initialize()
{
    //fullScreen();
    size(320,720,P2D);
    println("Size: 320*720|P2D");
}

// Loads
void Loading()
{
  // Read Informations Text
  ReadText = loadStrings("Readme/Infos.txt");
  for (int Infos = 0; Infos < ReadText.length; Infos++)
  {
    println(ReadText[Infos]);
  }
  
  // Write Errors Text
  if (DebugsMode == true);
  {
    Errors = createWriter("/DetectErrors/Errors.txt");
    Errors.flush();
    Errors.println("DebugMode: Activate");
    Errors.close();
  }
  
  // Font and Images
  MyFont = loadFont("Tenderness.vlw");
  
  Background = loadImage("Background.png");
  ImgShuriken = loadImage("Shuriken.png");
  ImgPlayer = loadImage("Player.png");
  
  /*if (MyFont != null)
  {
    MyFont = loadFont("Tenderness.vlw");
  }
  else println("Load Font Tenderness.vlw | Succes");
  
  if (Background != null)
  {
    Background = loadImage("Background.png");
  }
  else println("Load Image Background.png| Succes");
  
  if (Shuriken != null)
  {
    ImgShuriken = loadImage("Shuriken.png");
  }
  else println("Load Image Shuriken.png| Succes");
  
  if (Player != null)
  {
    ImgPlayer = loadImage("Player.png");
  }
  else println("Load Image Player.png| Succes");*/
}

void LoadAudio()
{
  minim = new Minim(this);
  Music_01 = minim.loadFile("LoubiTek-Eternal Love.mp3",256);
  Sound_01 = minim.loadFile("Sound_01.mp3",256);
}

// Settings
void settings()
{
  Initialize();
  Loading();
  LoadAudio();
}

// Indicator
void Indicator()
{
  beginShape();
  if (Player[0] <= Shuriken[0] - 64 || Player[0] >= Shuriken[0] + 32)
  {
    texture(Indicator_ON);
    fill(Others_Palette[0]);
    rect(5,10,310,16);
  }
  
  else
  {
    texture(Indicator_OFF);
    fill(Others_Palette[3]);
    rect(5,10,310,16);
  }
  endShape();
}

void Intro()
{
  background(4);
  textSize(28);
  textAlign(CENTER);
  text("Welcome to my game !",width/2,height/2);
  textSize(20);
  textAlign(LEFT);
  text("Press a key on the keyboard",28,400);
  text("or click the mouse",28,420);
  
  if (keyPressed || mousePressed)
  {
    Intro = false;
  }
}

// Frame
void Frame()
{
  strokeWeight(1);
  background(Binary_Palette[0]);
  
  //tint(c,255,255,255);
  image(Background,0,0);
  //noTint();
  
  // Cobwebs
  for(int Cobwebs=0; Cobwebs < width; Cobwebs += 32)
  {
    stroke(Binary_Palette[1]);
    line(320,Cobwebs,Cobwebs,0);
  }
  
  // Cadres
  
  // Title
  int CTitle_x = 5;
  int CTitle_y = 60;
  fill(Binary_Palette[0],191);
  stroke(Binary_Palette[1],191);
  rect(CTitle_x,CTitle_y,310,75);
  
  if (Player[0] >= CTitle_x)
  {
    Player[2] =+ 28;
    Player[2] = 28;
  }
  
  // Score
  int CScore_x = 5;
  int CScore_y = 275;
  fill(Binary_Palette[0],191);
  stroke(Binary_Palette[1],191);
  rect(CScore_x,CScore_y,310,32);
  
  // Explaine
  int CExplain_x = 5;
  int CExplain_y = 685;
  fill(Binary_Palette[1],191);
  stroke(Binary_Palette[0],191);
  rect(CExplain_x,CExplain_y,310,32);
  
  int CClock_x = 210;
  int CClock_y = 652;
  fill(Others_Palette[1],191);
  stroke(Binary_Palette[0]);
  rect(CClock_x,CClock_y, 105, 32);
}

// Setup
void setup()
{
  frameRate(60);
  colorMode(HSB);
  smooth(4);
  strokeCap(1);
  strokeJoin(MITER);
  //noCursor();
}

void Clock()
{
  int h = hour();
  int m = minute();
  int s = second();
  
  textSize(22);
  fill(Binary_Palette[1],191);
  text(h + ":" + m + ":" + s, 215, 678);
}

// Draw
void draw()
{ 
  if (GameLoop == Intro)
  {
    Intro();
  }
  else Game();
}

void Game()
{
  Frame();
  Clock();
  DrawText();
  Indicator();
  Playlist();
  Collide();
  ColorsSwitch();
  CollideWindow();
  
  OtherShapes(160,340,random(8),random(16),2);
  OtherShapes(160,340,random(16),random(8),2);
  
  Gain();
  Player();
  Shuriken();
  //println("NombresImages = " + frameCount + " FPS = " + frameRate);
  GameOver();
}

// Playlist
void Playlist()
{
  Music_01.play();
}

void ColorsSwitch()
{
  if (c > 255) c = 0;
  {
   stroke(Binary_Palette[1]);
   fill(c,255,255,191);
   c++;
  }
}

// CollideWindow
void CollideWindow()
{
  if(Player[0] >= width -32)
  {
    Player[0] = 0;
  }
  
  if(Player[0] <= 0 -32)
  {
    Player[0] = 286;
  }
  
  if(Shuriken[1] >= height -8)
  {
    Shuriken[0] = random(255);
    Shuriken[1] = random(255);
  }
  else Shuriken[1] = Shuriken[1] + Shuriken_Gain[0];
}

// GameOver
void GameOver()
{
  /*if (Shuriken[1] >= height - 8)
  {
    textSize(32);
    text(GameOver,width/2 - 85 ,height/2 + 64);
    blendMode(SUBTRACT);
  }*/
}

// Collide
void Collide()
{
  if(Player[0] + Shuriken[0] >= Shuriken[2] &&
  Player[0] <= Player[2] + Shuriken[0] &&
  Player[1] + Shuriken[1] >= Shuriken[2] &&
  Player[1] <= Player[2] + Shuriken[1])
  {
    Collide = true;
    println("Test Collide: Ok");
    Gain++;
    tint(c,c,c,random(255));
    Shuriken[0] = Shuriken[1];
    Sound_01.play();
  }
  else Collide = false;
}

// OtherShapes
void OtherShapes(float x, float y, float radius1, float radius2, int npoints)
{
  float angle = PI/npoints;
  float halfAngle = angle/PI;
  beginShape();
  for (float a = 0; a <= TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

// Shuriken
void Shuriken()
{
  r += PI;
  pushMatrix();
  translate(Shuriken[0],Shuriken[1]);
  rotate(radians(r));
  
  noFill();
  noStroke();
  
  rect(0,0,16,16);
  scale(1.5);
  image(ImgShuriken,0,0);
  popMatrix();
  noTint();
}

// Drawtext
void DrawText()
{
  // Title
  textSize(32);
  fill(Others_Palette[1]);
  text(Title,10,100);
  
  // DevName
  textSize(22);
  fill(Binary_Palette[1]);
  text(DevName,10,130);
  
  // Explain
  textSize(20);
  fill(Others_Palette[2]);
  text(Explain,Explain_x,Explain_y);
  
  Explain_x++;
  
  if (Explain_x >= width)
  {
    Explain_x = ExplainPos_x;
  }
  
  // Score
  textSize(24);
  fill(Others_Palette[1]);
  text(Score + Gain, 110, 300);
}

// Player
void Player()
{
  noFill();
  noStroke();
  rect(Player[0],Player[1],Player[2],Player[2]);
  image(ImgPlayer,Player[0],Player[1]);
}

// Gain
void Gain()
{
  if (Gain >= 100)
  {
    text("Speed"+ Multiple + n, Score_x, Score_y - 175);
    Shuriken[1] = Shuriken[1] + Shuriken_Gain[0];
    n = 1;
  }
  
  if (Gain >= 200)
  {
    text("Speed"+ Multiple + n, Score_x, Score_y - 125);
    Shuriken[1] = Shuriken[1] + Shuriken_Gain[1];
    n = 2;
  }
  
  if (Gain >= 300)
  {
    text("Speed"+ Multiple + n, Score_x, Score_y - 100);
    Shuriken[1] = Shuriken[1] + Shuriken_Gain[2];
    n = 3;
  }
  
  if (Gain >= 400)
  {
    text("Speed"+ Multiple + n, Score_x, Score_y - 75);
    Shuriken[1] = Shuriken[1] + Shuriken_Gain[3];
    n = 4;
  }
  
  if (Gain >= 500)
  {
    text("Speed"+ Multiple + n, Score_x, Score_y - 50);
    Shuriken[1] = Shuriken[1] + Shuriken_Gain[4];
    n = 5;
  }
  
  if (Gain >= 1000)
  {
    text("Speed"+ Multiple + n, Score_x, Score_y - 25);
    Shuriken[1] = Shuriken[1] + Shuriken_Gain[5];
    n = 6;
  }
}

// KeyPressed
void keyPressed()
{
  if (keyPressed == Event)
  {
    if (key == CODED)
    {
      if (keyCode == RIGHT)
      {
        Player[0] = Player[0] + Player[2];
      }
      if (keyCode == LEFT)
      {
        Player[0] = Player[0] - Player[2];
      }
      if (keyCode == ESC)
      {
        exit();
      }
    }
  }
}