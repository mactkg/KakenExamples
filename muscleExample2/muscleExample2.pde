import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.serial.*;
import cc.arduino.*;

Muscle mus;
int i;
boolean isAvr;
float data;

void setup(){
  println("setup");
  mus = new Muscle(this);
  textFont(createFont("../bin/mosamosa.ttf", 12));
  
  size(1280, 800);
  i = 0;
  
  data = 0;
  
  smooth();
  colorMode(HSB);
  background(130);
}

void draw(){
  background(130);
  mus.update();
  
  for(int i = 0; i < 20; i++){
    data = mus.rawData[i];
    println(data/1024);
    stroke(data/1024*255, 158, 169);
    fill(data/1024*255, 158, 169);
    rect(i*40, data/1024*(height-300), 20, height - 50);
  }
}

void keyPressed(){
  if(key == 'a') isAvr = !isAvr;
}

////////////////////
/* Custom Classes */
////////////////////
class Muscle {
  Arduino arduino;
  Minim minim;
  FFT fft;
  
  float rawData[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                      0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  float avrVal = 0;
  
  Muscle(PApplet that){
    println("!MUSCLE SETUP!");
    arduino = new Arduino(that, Arduino.list()[0], 57600);
    println("Arduino ready.");
    minim = new Minim(that);
    println("Minim ready.");
    //fft = new FFT();
  }
  
  void setup(){
    println("yet");
  }
  
  void update(){
    //input Data
    float buf[] = new float[20];
    arrayCopy(rawData, 1, buf, 0, 19);
    buf[19] = arduino.analogRead(0);
    arrayCopy(buf, rawData);
    
    //calculate Average of Data
    float avrBuf = 0;
    for(int i = 0; i < 20; i++) avrBuf += buf[i];
    avrVal = avrBuf / 20;  
  }
}

