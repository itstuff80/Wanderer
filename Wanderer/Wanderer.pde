int txtSize=64;
int alpha=250;
int it=0;
Maxim maxim;
AudioPlayer playZSpeak;
AudioPlayer playIntro;
AudioPlayer playSteps;
int itSpeak=50;
int itSteps=20;
int timeIntro=70;
boolean finishIntro=false;
PImage bkg, imgZombie;
int startAlpha=0;
int btX=550,btY=450,szX=90,szY=30;
int txtStart;
boolean started=false;
int zX,zY;
Zombie zombie;

void setup(){
  size(640,480);
  background(0);
  textSize(32);
  fill(0);
  frameRate(10);
  zX=width;
  zY=height;
  maxim = new Maxim(this);
  playZSpeak = maxim.loadFile("zombie-speaks.wav");
  playZSpeak.setLooping(false);
  playIntro = maxim.loadFile("intro.wav");
  playIntro.setLooping(true);
  playSteps = maxim.loadFile("steps.wav");
  playSteps.setLooping(false);
  playIntro.play();  
  bkg=loadImage("bkg.jpg");
  //imgZombie=loadImage("fyeah.jpg");
  //PImage[] imgLeft, PImage[] imgRigth, int direction, Point p1,
  //    Point p2, Board board)
  //loadImages("Animation_data/movie", ".jpg", 134);
  Board board=new Board();
  board.setTopLeft(new Point(0,0));
  board.setTopRight(new Point(width,0));
  board.setBottomLeft(new Point(0,height));
  board.setBottomRight(new Point(width,height));
  zombie=new Zombie(loadImages("zml", ".png", 20),loadImages("zmr", ".png", 20),1,new Point(526,115),new Point(width,height),board);
}


void draw(){
  
  if (!started){
    drawIntro();
  }else{
    backGroundStarted();
  }
}

void drawIntro(){
  fill(255);
  textSize(txtSize);
  if (alpha>0){
    background(0);
    text("Wanderer",180,260);
    fill(255,alpha);
    rect(0,0,width,height);
    alpha-=5;
  }
  it++;
  if (it%itSpeak==0){
    playZSpeak.play();
    itSpeak=200;
    
  }
  if (it%itSteps==0){
    playSteps.play();
    itSteps=150;
  }
  if (it%timeIntro==0){
    finishIntro=true;
  }
  if (finishIntro){
    textSize(32);
    fill(155,0,0,startAlpha);
    text("Start",btX,btY);
    if (startAlpha<255){
      startAlpha+=10;
    }

  }
}
  


void mouseClicked(){
  if (finishIntro && mouseX>btX && mouseY>btY-30){
    playSteps.setLooping(true);
    playSteps.play();
    playZSpeak.play();
    started=true;    
  }else{
    if (zombie.hit(new Point(mouseX,mouseY))){
      playZSpeak.play();
    }
  }
}

void mouseDragged(){
   if (pmouseX>mouseX){
    zombie.setDirection(1);
  }else{
    zombie.setDirection(-1);
  }
}

void backGroundStarted(){
 image(bkg, 0, 0, width, height);
 //imgZombie=zombie.currentImage();
 //image(imgZombie,zX, width-imgZombie.width,imgZombie.width, imgZombie.height); 
 //image(imgZombie,zX, height-imgZombie.height,imgZombie.width, imgZombie.height); 
 //currentImage()
 zombie.drawZombie();
 zombie.walk();
 zX-=10;
}

