import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.serial.*;
import cc.arduino.*;

Muscle mus;
int i;
boolean isAvr;
float data;
int chkWidth, threadshold;
int lHeight;
int timeWidth;

void setup(){
  println("setup");
  mus = new Muscle(this);
  textFont(createFont("../bin/mosamosa.ttf", 12));
  
  size(1280, 800);
  smooth();
  colorMode(HSB);
  background(40);
  
  i = 0;
  data = 0;
  chkWidth = 1;
  threadshold = 100;
  lHeight = height - 100;
  timeWidth = 5;
}

void draw(){
  mus.update();
  if(!isAvr)
    data = mus.rawData[0];
  else
    data = mus.avrVal;

  fill(255);
  stroke(255);
  
  //draw the graph
  noFill();
  curve(int((i-3*timeWidth)*2), int((mus.rawData[16]-0.5)/1024*lHeight),
        int((i-2*timeWidth)*2), int((mus.rawData[17]-0.5)/1024*lHeight),
        int((i-timeWidth)*2), int((mus.rawData[18]-0.5)/1024*lHeight),
        int(i*2), int((mus.rawData[19]-0.5)/1024*lHeight));
  
  //judging data
  if(abs(mus.rawData[19-chkWidth] - mus.rawData[19]) > threadshold) {
    fill(0);
    rect(i*2, 50, 3, 40);
    println(millis() + ":17/19!!!");
  }
  println("threadshold:" + threadshold + ", chkWidth:" + chkWidth);
  
  i += timeWidth;
  
  //clearing
  if(i*2 > width) {
    i = 0;
    stroke(255, 0, 40, 255);
    fill(255, 0, 40, 255);
    rect(0, 0, width, height);
    fill(0);
  }
}

void stop(){
  mus.stop();
  super.stop();
}

void keyPressed(){
  if(key == 'c') isAvr = !isAvr;
  if(key == 'w') threadshold++;
  if(key == 'a') chkWidth--;
  if(key == 's') threadshold--;
  if(key == 'd') chkWidth++;

}

////////////////////
/* Custom Classes */
////////////////////
class Muscle {
  Arduino arduino;
  Minim minim;
  //FFT fft;
  
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
  
  void stop(){
    this.minim.stop();
  }
}

