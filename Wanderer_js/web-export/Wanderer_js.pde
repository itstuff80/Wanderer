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
  


void mousePressed(){
  
  click();
}

void mouseClicked(){
  click();
}


void click(){
  if (finishIntro && mouseX>btX && mouseY>btY-30){
    playSteps.setLooping(true);
    playSteps.play();
    playZSpeak.play();
    //System.out.println("clicked");
    started=true;    
  }else{
    if (zombie.hit(new Point(mouseX,mouseY))){
      //System.out.println("clicked");
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
 zombie.drawZombie();
 zombie.walk();
 zX-=10;
}



public class Board {

  private Point topLeft, topRight, bottomLeft, bottomRight;

  public Point getTopLeft() {
    return topLeft;
  }

  public void setTopLeft(Point topLeft) {
    this.topLeft = topLeft;
  }

  public Point getTopRight() {
    return topRight;
  }

  public void setTopRight(Point topRight) {
    this.topRight = topRight;
  }

  public Point getBottomLeft() {
    return bottomLeft;
  }

  public void setBottomLeft(Point bottomLeft) {
    this.bottomLeft = bottomLeft;
  }

  public Point getBottomRight() {
    return bottomRight;
  }

  public void setBottomRight(Point bottomRight) {
    this.bottomRight = bottomRight;
  }

  public Board(Point topLeft, Point topRight, Point bottomLeft,
      Point bottomRight) {
    super();
    this.topLeft = topLeft;
    this.topRight = topRight;
    this.bottomLeft = bottomLeft;
    this.bottomRight = bottomRight;
  }
  
  public Board(){
  }
  
}



public class Point {
  private float x;
  private float y;
  
  public Point(float x, float y) {
    super();
    this.x = x;
    this.y = y;
  }
  

  public float getX() {
    return x;
  }
  public void setX(float x) {
    this.x = x;
  }
  public float getY() {
    return y;
  }
  public void setY(float y) {
    this.y = y;
  }
}


public class Zombie {

  private PImage imgLeft[];
  private PImage imgRight[];
  private int direction;
  private Point p1,p2;
  private Board board;
  private int posX;
  private int step=10;
  private int index=0;

  private PImage currentImage(){
    PImage img;
    index++;
    if (index>=imgLeft.length){
      index=0;
    }
    if (direction==1){
      img= imgLeft[index];
    }else{
      img= imgRight[index];
    }
    return img;
  }

  public void walk(){
    edges();
    posX-=step*direction;
  }

  public void drawZombie(){
   // PImage img=currentImage();
    image(currentImage(),posX, p1.getY(),p2.getX()-p1.getX(), p2.getY()-p1.getY()); 
    //image(img,posX, height-img.height,img.width, img.height);  
     //System.out.println("dimensions: " + +" "+img.height);
  }  
  public boolean hit(Point p){
    float x1=p1.getX();
    float x2=p2.getX();
    boolean hit=false;
    if (p.getY()>p1.getY()){
      if (p.getX()>posX && p.getX()<(posX+x2-x1)){
        hit= true;
      }
    }
    return hit;
  }
  
  
  public void edges(){
    if (posX<board.getTopLeft().getX() || posX>board.getTopRight().getX()){
      direction*=-1;
    }
  }


  public PImage[] getImgLeft() {
    return imgLeft;
  }


  public void setImgLeft(PImage[] imgLeft) {
    this.imgLeft = imgLeft;
  }


  public PImage[] getImgRight() {
    return imgRight;
  }


  public void setImgRight(PImage[] imgRight) {
    this.imgRight = imgRight;
  }


  public int getDirection() {
    return direction;
  }


  public void setDirection(int direction) {
    this.direction = direction;
  }


  public Point getP1() {
    return p1;
  }


  public void setP1(Point p1) {
    this.p1 = p1;
  }


  public Point getP2() {
    return p2;
  }


  public void setP2(Point p2) {
    this.p2 = p2;
  }


  public Board getBoard() {
    return board;
  }


  public void setBoard(Board board) {
    this.board = board;
  }


  public Zombie(PImage[] imgLeft, PImage[] imgRight, int direction, Point p1,
      Point p2, Board board) {
    super();
    this.imgLeft = imgLeft;
    this.imgRight = imgRight;
    this.direction = direction;
    this.p1 = p1;
    this.p2 = p2;
    this.board = board;
    posX=(int)p1.getX();
  }
  
  public Zombie(){
    posX=640;
  }
  
  
}

//The MIT License (MIT)

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies

//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


PImage [] loadImages(String stub, String extension, int numImages)
{
  PImage [] images = new PImage[0];
  for(int i =0; i < numImages; i++)
  {
    PImage img = loadImage(stub+i+extension);
    if(img != null)
    {
      images = (PImage [])append(images,img);
    }
    else
    {
      break;
    }
  }
  
  return images;
}

