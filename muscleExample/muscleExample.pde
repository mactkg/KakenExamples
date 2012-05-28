import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.serial.*;
import cc.arduino.*;

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
    fft = new FFT()
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
    int avrBuf = 0;
    for(int i = 0; i < 20; i++) avrBuf += buf[i];
    avrVal = avrBuf / 20;    
  }
}

Muscle mus;
int i;

void setup(){
  println("setup");
  mus = new Muscle(this);
  size(1280, 800);
  i = 0;
  
  colorMode(HSB);
  
  background(255);
}

void draw(){
  mus.update();
  float data = mus.rawData[19];
  println(data + ", " + data/1024*600);
  //fill(data/1024*255, 70, 255);
  //stroke(data/1024*255, 70, 255);
  fill(0);
  stroke(0);
  ellipse(i*2, data/1024*600 + 100, 3, 3);
  i++;
  if(i*2 > width) {
    i = 0;
    stroke(255, 0, 255, 90);
    fill(255, 0, 255, 90);
    rect(0, 0, width, height);
    fill(0);
  }
}
