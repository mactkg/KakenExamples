/*
  minimExample.pde

  minimの扱い方
  再生と録音
  値の取得あたり
*/

//import libraries
import ddf.minim.*;

Minim minim; //Minim object
AudioPlayer player; //AudioPlayer object (for play a sound)

void setup(){
  size(100, 100); //set up canvas
  minim = new Minim(this); //init Minim
  player = minim.loadFile("music.mp3"); //load the sound data
  player.play();
}

void draw(){
  background(0); //draw background
}

void stop(){
  //this function is need when you are using minim library
  player.close(); //close sound data
  minim.stop(); //stop minim
  super.stop(); //stop all
}
