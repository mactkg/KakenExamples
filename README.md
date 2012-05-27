# 課題研究のためのサンプル集
## したいこと
- minimの扱い方
 - 録音する
 - 再生する
 - 値をいじる
 - フーリエ変換する
- 簡単なグラフの作り方
- 簡単なクラスや関数の作り方

など

# musclelib(temp)
## Useage
``` .java
// make instance
Muscle mus;

void setup(){
  mus = Musble(this);
}

void draw(){
  if(mus.isCalibrated){
    mus.calibrate(mus.getRawData()[0]);
  } else {
    //mus.getValue return a value of a sensor(int) between 0 and 1024
    print("mus:" + mus.getValue());    
    //mus.getRawData return an array having values of a sensor recently 20 times
    int data[] = mus.getRawData()[i];
    for(int i = 0; i < 20; i++){
      print("mus[" + i + "]:" + data[i])
    }
}
```

## attached sound by
- LIFTING OF THE CLOSURE(HI-KU)
 - http://andworkspace.net/kuramu/
