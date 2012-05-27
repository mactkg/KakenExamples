import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim; //Minim object
AudioPlayer player; //AudioPlayer object
FFT fft; //FFT object
int position;
float scope;

void setup(){
  position = 0;
  scope = 2.5;
  
  size(1280, 600); //set up canvas
  colorMode(HSB);
  
  minim = new Minim(this); //init Minim
  player = minim.loadFile("music.mp3"); //load the sound data
  
  fft = new FFT(player.bufferSize(), player.sampleRate()); //init FFT
  textFont(createFont("mosamosa.ttf", 12)); //Set up a font
  
  player.play(); //Play a sound
}

void draw(){
 stroke(150, 20, 255);
 fill(150, 20, 255, 80);
 rect(0, 0, width, height);
 
 stroke(250, 150, 140);
 fill(250, 150, 140);
 
 fft.forward(player.mix);
 for(int i = 0; i < fft.specSize() + position; i++){
   line(i*scope+position, height - 40, i*scope+position, height - 40 - fft.getBand(i)*16);
   if(i % 50 == 0) text("^" + str(i), i*scope+position, height - 10);
 }
 
 fill(0);
 text("position:" + position, 100, 100);
 text("scope:" + scope, 100, 150);
 
 stroke(255, 30, 0);
 fill(255);
 line(0, height - 40, width, height - 40);
}

void stop(){
  player.close();
  minim.stop();
  
  super.stop();
}

void keyPressed(){
  if(key == 'd') position += 10;
  if(key == 'a') position -= 10;
  if(key == 'w') scope += 0.2;
  if(key == 's') scope -= 0.2;
  println(key);
}
