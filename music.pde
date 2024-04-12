import processing.sound.*;
class MusicPlayer {
  ArrayList<SoundFile> stepSounds = new ArrayList<SoundFile>();
  int totalFiles = 13;
  SoundFile spawnSound;
  SoundFile music;
  boolean played = true;
  boolean muted = true;
  boolean musicPlayed = false;
  boolean musicStarted = false;

  MusicPlayer() {
    spawnSound = new SoundFile(elevator.this, "Sounds/Player Spawn Sound.wav");
    music = new SoundFile(elevator.this, "Music/Queue Time Song 1.wav");
    
    for (int i = 1; i <= totalFiles; i++) {
      String stepSoundName = String.format("Sounds/Step Up Sound %d.wav", i);
      stepSounds.add(new SoundFile(elevator.this, stepSoundName));
    }
  }

  void musicRun() {
    musicPlayed = music.isPlaying();

    if (muted) {
      if (musicStarted && musicPlayed) {
        music.pause();
        musicPlayed = false;
      }
    } else {
      if (!musicPlayed) {
        //music.play();
        //musicStarted = true;
        //musicPlayed = true;
      }
    }
  }

  void spawnSoundRun() {
    if (!played) {
      if (!muted) {
        spawnSound.play();
      }
      played = true;
    }
  }

  void muteText() {
    text(muted ? "press m to unmute" : "press m to mute", 100, 100);
  }

  void randomStepSound() {
    if (!muted) {
      stepSounds.get(r.nextInt(stepSounds.size())).play();
    }
  }

  void mute() {
    muted = !muted;
  }
}
