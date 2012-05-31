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

void setup(){
  println("setup");
  mus = new Muscle(this);
  textFont(createFont("mosamosa.ttf", 12));
  
  size(1280, 800);
  i = 0;
  
  data = 0;
  
  smooth();
  colorMode(HSB);
  background(40);
  chkWidth = 1;
  threadshold = 100;
  lHeight = height - 100;
}

void draw(){
  mus.update();
  if(!isAvr)
    data = mus.rawData[0];
  else
    data = mus.avrVal;
  //debug
  //println(millis() + ":" + data + ", " + data/1024*600);
  fill(data/1024*255, 70, 255);
  stroke(data/1024*255, 70, 255);
  
  /*fill(0);
  stroke(0);
  ellipse(i*2, data/1024*600 + 100, 3, 3);*/
  
  line(i*2, mus.rawData[17]/1024*lHeight-50, i*2 + 1, mus.rawData[18]/1024*lHeight-50);
  line(i*2, mus.rawData[18]/1024*lHeight-50, i*2 + 1, mus.rawData[19]/1024*lHeight-50);
  if(abs(mus.rawData[19-chkWidth] - mus.rawData[19]) > threadshold) {
    fill(138, 120, 180);
    rect(i*2, 50, 3, 40);
    println(millis() + ":17/19!!!");
  }
  println("threadshold:" + threadshold + ", chkWidth:" + chkWidth);
  /*f(abs(mus.rawData[18] - mus.rawData[19]) > 90) {
    println(millis() + ":18/19!!!");
    fill(138, 120, 180);
    rect(i*2, 50, 3, 40);
  }*/
  i += 3;
  if(i*2 > width) {
    i = 0;
    stroke(255, 0, 40, 255);
    fill(255, 0, 40, 255);
    rect(0, 0, width, height);
    fill(0);
  }
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

