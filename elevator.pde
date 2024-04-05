ArrayList<Platform> platforms = new ArrayList<Platform>();
int platformDistance = 100;

int cooldownDuration = 100;
int lastPlatformAddedTime = 0;

int stepCount = 0;


void setup() {
  size(500, 800);

  for (int i = ((height+platformDistance) / platformDistance)-1; i >= 0; i--) {
    platforms.add(new Platform(int(random(0, 2))));
    for (int j = platforms.size()-1; j >= 0; j--) {
      platforms.get(j).moveY(platformDistance);
    }
  }
  platforms.add(new Platform(int(random(0, 2))));
  platforms.remove(0);
  /*
  for (int j = platforms.size()-1; j > 0; j--) {
    if (j == 1) {
      if (platforms.get(j).side == 0) {
        platforms.get(j).moveX(width/4);
      } else if (platforms.get(j).side == 1) {
        platforms.get(j).moveX(-width/4);
      }
    } else {
      if (platforms.get(j-1).side == 0) {
        platforms.get(j).moveX(-platforms.get(j).pos.x);
        platforms.get(j).moveX(width/2);
      } else if (platforms.get(j-1).side == 1) {
        platforms.get(j).moveX(platforms.get(j).pos.x);
        platforms.get(j).moveX(-width/2);
      }
      
    }
    
  }
  */
}

void draw() {
  background(255);
  textSize(100);
  fill(100);
  text(stepCount, 25, 75);
  for (int i = 0; i < platforms.size(); i++) {
    if (i == 1) {
      platforms.get(i).render(#FF0000);
    } else
      platforms.get(i).render(#000000);
  }
}

void move() {
  for (int i = 0; i < platforms.size(); i++) {
    platforms.get(i).moveY(platformDistance);
  }



  platforms.add(new Platform(int(random(0, 2))));

  platforms.remove(0);

  stepCount++;
}

void keyPressed() {
  if (millis() - lastPlatformAddedTime >= cooldownDuration) {
    if (key == 'a' || keyCode == LEFT) {
      if (platforms.get(2).side == 0) {
        move();
      } else {
        stepCount = 0;
      }
    }
    if (key == 'd' || keyCode == RIGHT) {
      if (platforms.get(2).side == 1) {
        move();
      } else {
        stepCount = 0;
      }
    }
    lastPlatformAddedTime = millis();
  }
}
