import processing.video.*;
import processing.sound.*;
import java.util.*;


Capture cam;

int width = 960;
int height = 540;

AudioDevice device;
SoundFile file;

void setup() {


  size(960, 540);
  //size(1920,1200);

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
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[18]);
    //cam = new Capture(this, cameras[0]);
    cam.start();     
  }
  
  //Sound Code
  device = new AudioDevice(this, 48000, 32);
  file = new SoundFile(this, "bird1.mp3");
  file.play(1.0, 1.0);
}


void draw() {
  if (cam.available() == true) {
    cam.read();
    //trying something else

  }
  
  image(cam, 0, 0);
  filter(INVERT);

  //loads Pixels into the pixels[] array
  loadPixels();
  
  //get(x, y) == pixels[y*width+x]
  //Get the color of the pixel in the center
  color tempColor = pixels[height/2*width/2+width/2];
  float brightnessValue = brightness(tempColor);
  
  println(brightnessValue);
  
  float newVal = map(brightnessValue, 0, 255, 0.5, 2);
  file.rate(newVal);

  println(newVal);
}