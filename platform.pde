class Platform {
  int side;
  PVector pos;

  PVector projectedPos;
  
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
    projectedPos = new PVector(pos.x, pos.y);
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
  
  void move() {
    projectedPos.y = lerp(projectedPos.y, pos.y, 0.1);
    projectedPos.x = lerp(projectedPos.x, pos.x, 0.1);
  }

  void render(int c) {
    stroke(0);
    fill(c);
    
    p = createShape();
    p.beginShape();
    p.vertex(0,0);
    p.vertex(platformLength*2, 0);
    p.vertex(platformLength*2, 10);
    p.vertex(0, 10);
    p.vertex(0,0);
    p.endShape();
    shape(p, projectedPos.x, projectedPos.y);
  }
}
