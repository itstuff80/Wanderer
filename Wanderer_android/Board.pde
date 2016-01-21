

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

