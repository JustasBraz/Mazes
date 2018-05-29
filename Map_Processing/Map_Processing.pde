PImage map;
ArrayList<PVector> coordinates= new ArrayList<PVector>();

PrintWriter output;
boolean clicked=false;
float step=1;
String name = "NewIteration";
int depth1=100+30;
int depth2=120+30;
void setup(){
   // Create a new file in the sketch directory
  output = createWriter(name+".txt"); 
 map = loadImage("PX_MAP_DE.png");
size(671,544);

image(map,0,0);

}
void draw(){

saveFrame(frameCount+".png");
//fill(255);
//text(mouseX+" "+mouseY,mouseX, mouseY);
//println(mouseX, mouseY);
show();
if (clicked){
  fill(255,0,0);
  strokeWeight(5);
point(mouseX,mouseY);


coordinates.add(new PVector(mouseX, mouseY,int(map(noise(step),0,1,depth1,depth2))));
step+=0.1;
print(mouseX+" "+mouseY+" added");
}
clicked = false;
}

void show(){
for(PVector e: coordinates){
  fill(255,0,0);
  strokeWeight(7);
  point(e.x, e.y);
 // fill(0,0,0);
//  text(e.x+"\n"+e.y, e.x,e.y);
}

}

void keyPressed() {
 
  if (key == 'q' || key == 'Q') {
    depth1=60;
    depth2=120;
    stroke(0,0,255);
  }
  if (key == 'e' || key == 'E') {
    depth1=0;
    depth2=50;
    stroke(255,0,0);
  }
  
  if (key == 'w' || key == 'W') {
    depth1=45;
    depth2=70;
    stroke(200,50,100);
  }
  if (key == ' ') {
  for(PVector e: coordinates){
  output.println(e.x+" "+e.y+" "+e.z+" ");
  }
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}
}

void mousePressed(){

   if (clicked == false) {
    clicked = true;
  } else {
    clicked = false;
  }
}