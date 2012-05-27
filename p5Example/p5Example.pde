/*
主にProcessingについて
smoothやstroke、fillとか
classも作ってみる
*/

void setup(){
  size(400, 400);
  smooth();
  colorMode(HSB);
}

void draw(){
  background(128, 40, 240);
  
  stroke(0);
  fill(160, 20, 240);
  rect(0, 0, 300, 300);
  
  noStroke();
  fill(80, 50, 240);
  rect(150, 150, 250, 250);
}
