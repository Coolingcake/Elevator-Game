import java.util.Random;

Table saveFile;
TableRow score;
int highScore;

ArrayList<Platform> platforms = new ArrayList<Platform>();
int platformDistance = 100;

Player player;
StaminaBar stamina;

MusicPlayer musicPlayer;

int stepCount = 0;

int platformLength = 125;
Random r = new Random();
boolean shifted = false;

boolean setup = true;

boolean paused = false;

void setup() {
  size(1000, 1000);
  frameRate(60);

  saveFile = loadTable("data/saveFile.csv", "header");
  score = saveFile.getRow(0);
  highScore = score.getInt("score");


  musicPlayer = new MusicPlayer();
  stamina = new StaminaBar(100);

  platforms.add(new Platform(r.nextInt(3)-1));

  for (int i = 0; i < ((height+platformDistance) / platformDistance)-1; i++) {
    move();
  }

  stepCount = 0;

  float offsetX = (width/2 - platformLength) - (platforms.get(1).pos.x);

  for (int i = 0; i < platforms.size(); i++) {
    platforms.get(i).moveX(offsetX);
  }

  player = new Player();

  setup = false;
}

void draw() {
  background(#c2d6f6);
  musicPlayer.musicRun();
  musicPlayer.spawnSoundRun();

  fill(stepCount == 0 ? color(255, 0, 0, 150) : color(64, 64, 64, 150));
  textSize(100);
  text(stepCount, 25, 75);

  fill(color(64, 64, 64, 150));
  text(highScore, 25, height-25);

  for (int i = 0; i < platforms.size(); i++) {
    if (!paused) {
      platforms.get(i).move();
    }
    platforms.get(i).render(i == 1 ? #FF0000 : #000000);
  }

  stamina.changeColor();
  stamina.render();


  if (!paused) {
    if (stamina.stamina < 0) {
      kill();
    } else {
      stamina.changeStamina(-0.4);
    }
  }

  if (!paused) {
    player.move();
  }

  player.render();

  if (paused) {
    fill(50, 50, 50, 100);
    rect(0, 0, width, height);
    fill(100);
    triangle(width-40, 10, width-40, 40, width-15, 25);
    musicPlayer.muteText();
  } else {
    fill(100);
    rect(width-40, 10, 10, 30);
    rect(width-25, 10, 10, 30);
  }
}

void kill() {
  stamina.setToMax();
  musicPlayer.played = false;
  
  if (stepCount > highScore) {
    highScore = stepCount;
    
    score.setInt("score", highScore);
    saveTable(saveFile, "data/saveFile.csv");
  }
  
  stepCount = 0;
}

void movePlayer(int direction) {
  if ((direction == 0 && platforms.get(2).side == 0) ||
    (direction == 1 && platforms.get(2).side == 1) ||
    (direction == -1 && platforms.get(2).side == -1)) {
    move();
    musicPlayer.randomStepSound();
    stamina.setToMax();

    if (direction != 0) {
      for (Platform platform : platforms) {
        platform.moveX(-direction * platformLength);
      }
    }
    return;
  }
  kill();
}

void move() {
  for (Platform platform : platforms) {
    platform.moveY(platformDistance);
  }
  platforms.add(new Platform(r.nextInt(3)-1));
  shift(platforms.size()-2, platforms.size()-1);
  if (!setup) {
    platforms.remove(0);
  }
  stepCount++;
}

void shift(int prev, int post) {
  Platform postPlatform = platforms.get(post);
  postPlatform.setX(platforms.get(prev).pos.x);
  postPlatform.moveX(platformLength * postPlatform.side);
  //platforms.get(post).moveX((-platforms.get(post).pos.x)+(platforms.get(prev).pos.x)+(platformLength * platforms.get(post).side));
}

void keyPressed() {
  if (!paused) {
    if (keyCode == SHIFT) {
      shifted = true;
    }
    if (key == 'a' || keyCode == LEFT) {
      movePlayer(-1);
    }
    if (key == 'd' || keyCode == RIGHT) {
      movePlayer(1);
    }
    if (key == 'w' || keyCode == UP) {
      movePlayer(0);
    }
  }
  if (key == 'p') {
    paused = !paused;
  }
  if (key == 'm') {
    musicPlayer.mute();
  }
}

void mouseClicked() {
  if (mouseX > 50 && mouseY < 50) {
    paused = !paused;
  }
}

void keyReleased() {
  if (keyCode == SHIFT) {
    shifted = false;
  }
}
