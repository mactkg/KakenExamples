import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim; //Minim object
AudioPlayer player; //AudioPlayer object
FFT fft; //FFT object


void setup(){
  size(1280, 600); //set up canvas
  colorMode(HSB);
  
  minim = new Minim(this); //init Minim
  player = minim.loadFile("../bin/music.mp3"); //load the sound data
  
  fft = new FFT(player.bufferSize(), player.sampleRate()); //init FFT
  textFont(createFont("../bin/mosamosa.ttf", 12)); //Set up a font
  
  player.play(); //Play a sound
}

void draw(){
 stroke(150, 20, 255, 10);
 fill(150, 20, 255, 10);
 rect(0, 0, width, height);
 
 stroke(250, 150, 140);
 fill(250, 150, 140);
 
 fft.forward(player.mix);
 for(int i = 0; i < fft.specSize(); i++){
   line(i*2.5, height - 40, i*2.5, height - 40 - fft.getBand(i)*16);
   if(i % 50 == 0) text("^" + str(i), i*2.5, height - 10);
 }
 fill(255);
 
 stroke(255, 30, 0);
 line(0, height - 40, width, height - 40);
}

void stop(){
  player.close();
  minim.stop();
  
  super.stop();
}
