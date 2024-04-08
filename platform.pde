class Platform {
  int side;
  PVector pos;
  float platformLength = 125;

  float projectedY;
  float projectedX;
  
  PShape p;

  Platform (int s) {
    side = s;
    initialize();
  }

  void initialize() {
    if (side == -1) {
      pos = new PVector((width/2) - platformLength * 2, 0);
    } else if (side == 0) {
      pos = new PVector((width/2) - (platformLength/2), 0);
    } else if (side == 1) {
      pos = new PVector(width/2, 0);
    }
    projectedY = pos.y;
    projectedX = pos.x;
    
    
  }

  void moveY(float num) {
    pos.y += num;
  }

  void moveX(float num) {
    pos.x += num;
  }

  void setX(float num) {
    pos.x = num;
  }

  void render(int c) {
    stroke(0);
    fill(c);
    projectedY = lerp(projectedY, pos.y, 0.1);
    projectedX = lerp(projectedX, pos.x, 0.1);
    
    p = createShape();
    p.beginShape();
    p.vertex(0,0);
    p.vertex(platformLength*2, 0);
    p.vertex(platformLength*2, 10);
    p.vertex(0, 10);
    p.vertex(0,0);
    p.endShape();
    shape(p, projectedX, projectedY);
    /*
    line(projectedX, projectedY, projectedX+platformLength*2, projectedY);
    line(projectedX, projectedY-10, projectedX+platformLength*2, projectedY-10);
    line(projectedX, projectedY, projectedX, projectedY-10);
    line(projectedX+platformLength*2, projectedY, projectedX+platformLength*2, projectedY-10);
    */
  }
}
