import processing.video.*;
import processing.sound.*;
import java.util.*;



// Code from https://processing.org/tutorials/sound/

Capture cam;

int width = 640;  
int height = 360;

// SoundFile is processing
// AudioFile is minim
SoundFile[] redList;
SoundFile[] blueList;
SoundFile[] greenList;
SoundFile redAmbient;
SoundFile blueAmbient;
SoundFile greenAmbient;

int avgList[];

void setup() {
  frameRate(30);
  size(640, 360);
  background(255);

  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      print(i + ": ");
      println(cameras[i]);
    }
    cam = new Capture(this, cameras[3]);
    cam.start();     
  }
  
  avgList = new int[1000];
  
  redList = new SoundFile[16];
  redList[0] = new SoundFile(this, "Red/Red01.aif");
  redList[1] = new SoundFile(this, "Red/Red02.aif");
  redList[2] = new SoundFile(this, "Red/Red03.aif");
  redList[3] = new SoundFile(this, "Red/Red04.aif");
  redList[4] = new SoundFile(this, "Red/Red05.aif");
  redList[5] = new SoundFile(this, "Red/Red06.aif");
  redList[6] = new SoundFile(this, "Red/Red07.aif");
  redList[7] = new SoundFile(this, "Red/Red08.aif");
  redList[8] = new SoundFile(this, "Red/Red09.aif");
  redList[9] = new SoundFile(this, "Red/Red10.aif");
  redList[10] = new SoundFile(this, "Red/Red11.aif");
  redList[11] = new SoundFile(this, "Red/Red12.aif");
  redList[12] = new SoundFile(this, "Red/Red13.aif");
  redList[13] = new SoundFile(this, "Red/Red14.aif");
  redList[14] = new SoundFile(this, "Red/Red15.aif");
  redList[15] = new SoundFile(this, "Red/Red16.aif");

  greenList = new SoundFile[16];
  greenList[0] = new SoundFile(this, "Green/Green01.aif");
  greenList[1] = new SoundFile(this, "Green/Green02.aif");
  greenList[2] = new SoundFile(this, "Green/Green03.aif");
  greenList[3] = new SoundFile(this, "Green/Green04.aif");
  greenList[4] = new SoundFile(this, "Green/Green05.aif");
  greenList[5] = new SoundFile(this, "Green/Green06.aif");
  greenList[6] = new SoundFile(this, "Green/Green07.aif");
  greenList[7] = new SoundFile(this, "Green/Green08.aif");
  greenList[8] = new SoundFile(this, "Green/Green09.aif");
  greenList[9] = new SoundFile(this, "Green/Green10.aif");
  greenList[10] = new SoundFile(this, "Green/Green11.aif");
  greenList[11] = new SoundFile(this, "Green/Green12.aif");
  greenList[12] = new SoundFile(this, "Green/Green13.aif");
  greenList[13] = new SoundFile(this, "Green/Green14.aif");
  greenList[14] = new SoundFile(this, "Green/Green15.aif");
  greenList[15] = new SoundFile(this, "Green/Green16.aif");

  blueList = new SoundFile[16];
  blueList[0] = new SoundFile(this, "Blue/Blue01.aif");
  blueList[1] = new SoundFile(this, "Blue/Blue02.aif");
  blueList[2] = new SoundFile(this, "Blue/Blue03.aif");
  blueList[3] = new SoundFile(this, "Blue/Blue04.aif");
  blueList[4] = new SoundFile(this, "Blue/Blue05.aif");
  blueList[5] = new SoundFile(this, "Blue/Blue06.aif");
  blueList[6] = new SoundFile(this, "Blue/Blue07.aif");
  blueList[7] = new SoundFile(this, "Blue/Blue08.aif");
  blueList[8] = new SoundFile(this, "Blue/Blue09.aif");
  blueList[9] = new SoundFile(this, "Blue/Blue10.aif");
  blueList[10] = new SoundFile(this, "Blue/Blue11.aif");
  blueList[11] = new SoundFile(this, "Blue/Blue12.aif");
  blueList[12] = new SoundFile(this, "Blue/Blue13.aif");
  blueList[13] = new SoundFile(this, "Blue/Blue14.aif");
  blueList[14] = new SoundFile(this, "Blue/Blue15.aif");
  blueList[15] = new SoundFile(this, "Blue/Blue16.aif"); 
  
  redAmbient = new SoundFile(this, "RedAmbience.aif");
  blueAmbient = new SoundFile(this, "BlueAmbience.aif");
  greenAmbient = new SoundFile(this, "GreenAmbience.aif");
  
  //redAmbient.loop();
  //blueAmbient.loop();
  //greenAmbient.loop();
}

float curValue = 0;
int counter = 0;
int nextBeat =0;
int curInterval = 0;
void draw() {
  //if (counter==0) {
  //  redList[0].play();
  //} else if(counter==50) {
  //  redList[8].play();
  //} else if(counter==100) {
  //  blueList[0].play();
  //}

  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  loadPixels();

  PImage newImg = cam.get(50, 50, 10, 500);
  color averageColor = extractColorFromImage(newImg);
  // brightnessValue is 0~100. 0 is dark, 100 is bright
  float brightnessValue = brightness(averageColor);
  //println("brightnessValue: ", brightnessValue);

  //print(averageColor);
  //curValue = curValue + random(-1, 1);
  
  float yoffset = map(brightnessValue, 0, 100, 0, 1);
  
  avgList[counter%1000] =  int(brightnessValue);

  
  //if (curInterval%2 == nextBeat) {
  //  // Red
  //  float redIndex = red(averageColor)%16;
  //  println(redIndex);
  //  redList[int(redIndex)].play();
  //}
  
  
  if (nextBeat ==0) {
    // Red
    float redIndex = red(averageColor)%16;
    //println(redIndex);

    float greenIndex = green(averageColor)%16;
    //println(greenIndex);
    
    float blueIndex = blue(averageColor)%16;
    //println(blueIndex);
    
    int totalColor = int(red(averageColor)) + int(green(averageColor)) + int(blue(averageColor));
    
    float redProb = red(averageColor) / totalColor;
    redProb = redProb * 100;
    int myRand = int(random(100));
    if (myRand < int(redProb)) {
      redList[int(redIndex)].play();
    }

    float greenProb = green(averageColor) / totalColor;
    greenProb = greenProb * 100;
    myRand = int(random(100));
    if (myRand < int(greenProb)) {
      greenList[int(greenIndex)].play();
    }

    float blueProb = blue(averageColor) / totalColor;
    blueProb = blueProb * 100;
    myRand = int(random(100));
    if (myRand < int(blueProb)) {
      blueList[int(blueIndex)].play();
    }

    
    //redAmbient.amp(map(red(averageColor), 0, 255, 0, 1));
    //blueAmbient.amp(map(blue(averageColor), 0, 255, 0, 1));
    //greenAmbient.amp(map(green(averageColor), 0, 255, 0, 1));
    int sum =0;
    for (int i=0; i<100; i++) {
      sum = sum+avgList[i];
    }
    sum = int(sum/100);
    float newBrightness = map(int(-sum), -255, 0, 3, 15);
    nextBeat = int(newBrightness);
    curInterval = nextBeat;
    //println("nextbeat: ", nextBeat);
  }
  
  counter++;
  nextBeat--;

  //Use mouseX mapped from -0.5 to 0.5 as a detune argument
  //float detune1 = map(red(averageColor), 0, width, -0.5, 0.5);
  //float detune2 = map(blue(averageColor), 0, width, -0.5, 0.5);
  //float detune3 = map(green(averageColor), 0, width, -0.5, 0.5);
}

color extractColorFromImage(PImage img) {
  img.loadPixels();
  int r = 0, g = 0, b = 0;
  for (int i=0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    r += c>>16&0xFF;
    g += c>>8&0xFF;
    b += c&0xFF;
  }
  r /= img.pixels.length;
  g /= img.pixels.length;
  b /= img.pixels.length;
 
  return color(r, g, b);
}