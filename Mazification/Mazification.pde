import processing.dxf.*;

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;  
import processing.sound.*;
SoundFile in;
SoundFile out;
PeasyCam cam;

boolean record;

PImage image1;
PImage image2;
int threshold=45;
int step=0;
IntList points1 = new IntList();
//IntList points2 = new IntList();
ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<newLine> lines = new ArrayList<newLine>();
ArrayList waves = new ArrayList();
wavyLine [] wavyLines;
float rotation =90;
boolean orbit = false;
float zoom=0;
boolean controlZoom=false;

int weight=1;
int initX=-700;
int initX_=initX+200;
int step_=0;
int l=0;

float sine=0;
float cosine=0;
float incr=0;
String name="Incept2Processing";
void setup() {
  size(800, 800, P3D);
  // frameRate(10);
  cam = new PeasyCam(this, 190);

  image1 = loadImage("headalpha2.jpg");
  //  image2 = loadImage("headalpha2.jpg");
  in = new SoundFile(this, "in.mp3");
  // in.play();
  out = new SoundFile(this, "out.mp3");
  //  out.play();
  int dimension = image1.width * image1.height;
  int i =0;

  getTXT();
  //getPicture(image1);

  println("points array size "+points.size());


  //input amount of nodes
  //dumbConnect(3,4);
  //smartConnect(16);
  connectedGraph();


  println("points array size "+points.size());
  println("line array size "+lines.size());
  println("entering Draw");
}
//-16777216
//-1//white`    
void draw() {
  background(255);
  //frameRate(10);
  if (record) {
    beginRaw(DXF, name+".dxf");
  }

  orbiting(orbit);

  pushMatrix();
  // translate(0,0, -800);
  // rotate(3*P);

  for (newLine v : lines) {
    // if (v.end.z>10) {
    v.show(1, color(0));
    // }
  }


  popMatrix();

  // saveFrame("test###.png");
  if (keyPressed) {
    if (key == 'b' || key == 'B') {
      step-=100;
    }
  }
  if (record) {
    endRaw();
    record = false;
    exit();
  }
}
void getTXT() {

  String[] lines = loadStrings(name+".txt");
  println("there are " + lines.length + " lines");

  println(lines[5]);
  for (int i = 0; i < lines.length; i++) {
    String newLine=lines[i];
    int count=0;

    String x, y, z;
    x="";  
    y="";  
    z="";
    for (int j=0; j<newLine.length(); j++) {

      if (newLine.charAt(j)==' ') {
        count++;
      }
      switch(count) {
      case 0:
        x+=newLine.charAt(j);
        break;
      case 1:
        y+=newLine.charAt(j);
        break;
      case 2:
        z+=newLine.charAt(j);
        break;
      }
    }

    //if(random(1)<0.){
    points.add(new PVector(Float.parseFloat(x), Float.parseFloat(y), Float.parseFloat(z)));
    //}
    // println(lines[i]);
  }
}
void getPicture(PImage img) {
  img.loadPixels();
  for (int x = 1; x < image1.width-1; x += 1) { 
    for (int y = 1; y< image1.height-1; y+=1) {
      //points.append(int(map(image1.pixels[i],-16777216,-1,200,0))); 

      // if (random(1)<0.5) {
      points.add(new PVector(x, y, int(map(image1.pixels[x+y*image1.width], -16777216, -1, 0, 80))));
      //points.add(new PVector(int(random(0,300)),int(random(0,300)), int(random(0,300))));
      // }
    }
  }
  img.updatePixels();
}

void connectedGraph() {

  ArrayList<PVector> reached = new ArrayList<PVector>();
  ArrayList<PVector> unreached = new ArrayList<PVector>();

  for (PVector v : points) {
    unreached.add(v);
  }

  reached.add(unreached.get(0));
  unreached.remove(0);

  while (unreached.size() > 0) {
    println("left: "+unreached.size()+", lines array: "+lines.size());
    float record = 999999999;
    int rIndex = 0;
    int uIndex = 0;
    for (int i = 0; i < reached.size(); i++) {
      for (int j = 0; j < unreached.size(); j++) {
        PVector v1 = reached.get(i);
        PVector v2 = unreached.get(j);

        float d = dist(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
        if (d < record) {
          record = d;
          rIndex = i;
          uIndex = j;
        }
      }
    }

    PVector p1 = reached.get(rIndex);
    PVector p2 = unreached.get(uIndex);
    lines.add(new newLine(p1, p2));

    reached.add(p2);
    unreached.remove(uIndex);
  }
}

void smartConnect(int nodes) { 
  println("entering smartConnect");
  ArrayList<PVector> toRemove = new ArrayList<PVector>();
  for (PVector a : points) {
    PVector [] temp= new PVector [nodes];
    temp =findTop(points, a, nodes);
    for (int i=0; i<nodes; i++) {
      lines.add(new newLine(a, temp[i]));
    }
    //to avoid errors and use of iterator
    toRemove.add(a);
    for (int i=0; i<nodes; i++) {
      toRemove.add(temp[i]);
    }
  }
  points.removeAll(toRemove);

  println(points.size());
}

void dumbConnect(float distA, float distB) {
  for (PVector a : points) {
    for (PVector b : points) {
      float dist=dist(a.x, a.y, a.z, b.x, b.y, b.z);
      if (dist>distA&&dist<(distA+distB)) {
        println(dist);
        lines.add(new newLine(a, b));
      }
    }
    println("Lines size: "+lines.size());
  }
}



PVector[]findTop(ArrayList<PVector> array, PVector node, int amount) {

  PVector [] tempArray= new PVector [amount];

  MyQuickSort sorter = new MyQuickSort();

  sorter.sort(array, node);

  for (int j=0; j<amount; j++) {
    tempArray[j]=array.get(j);
  }





  return tempArray;
}



void messy(int x, int y, int i) {

  int temp= int(random(3, 150));
  for (i=0; i<temp; i++) {
    line(x, y, points1.get(i)-1, x, y, points1.get(i)-i);
  }
}

void distortion(int x, int y, int i) {
  sine=sin(incr);//*100
  cosine=cos(incr*10);
  point(x, y+cosine*5, i);
  incr+=1;
  ;
}

void orbiting(boolean orbitino) {

  if (orbitino) {
    float orbitRadius= 190;//mouseX/2+100;
    float ypos= 0;//mouseY/3;
    float xpos= cos(radians(rotation))*orbitRadius;
    float zpos= sin(radians(rotation))*orbitRadius;

    camera(xpos, ypos, zpos, 0, 0, 0, 0, 1, 0);
    //cameraZoom();
    rotation+=0.5;
  }
}
void cameraZoom() {
  if (zoom>=0&&zoom<150&&!controlZoom) {
    zoom+=1;
    if (zoom>148) {
      controlZoom=true;
    }
  } else if (zoom>1&&controlZoom) {
    zoom-=1;
  }
  println(zoom);
}

void keyPressed() {
  if (key == 'o' || key == 'O') {
    orbit=true;
  }
  if (key == CODED) {
    if (keyCode == UP) {
      threshold+=1;
      println(threshold);
    } else if (keyCode == DOWN) {
      threshold-=1;
      println(threshold);
    } else if (keyCode == LEFT) {
      weight-=1;
      println(weight);
    } else if (keyCode == RIGHT) {
      weight+=1;
      println(weight);
    }
  } else if (key == 't') {
    record = true;
  } else {
    //threshold adjustments
  }
}