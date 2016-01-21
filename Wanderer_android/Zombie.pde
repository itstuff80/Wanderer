
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

