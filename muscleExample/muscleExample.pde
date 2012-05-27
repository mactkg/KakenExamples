import ddf.minim.*;
import processing.serial.*;
import cc.arduino.*;

class Muscle {
  Arduino arduino;
  Minim minim;
  float rawData[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                      0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
  float avrVal = 0;
  
  Muscle(PApplet that){
    println("!MUSCLE SETUP!");
    arduino = new Arduino(that, Arduino.list()[0], 57600);
    println("Arduino ready.");
    minim = new Minim(that);
    println("Minim ready.");
  }
  
  void setup(){
    println("yet");
  }
  
  void update(){
    //input Data
    float buf[] = new float[20];
    arrayCopy(rawData, 1, buf, 0, 19);
    buf[19] = arduino.analogRead(10);
    arrayCopy(buf, rawData);
    
    //calculate Average of Data
    int avrBuf = 0;
    for(int i = 0; i < 20; i++) avrBuf += buf[i];
    avrVal = avrBuf / 20;    
  }
}

Muscle mus;
void setup(){
  println("setup");
  mus = new Muscle(this);
}

void draw(){
  mus.update();
  println(mus.avrVal);
  line(0, 0, mouseX, mouseY);
}
