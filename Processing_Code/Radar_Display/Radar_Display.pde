import processing.serial.*; 
import processing.sound.*; 

Serial myPort; 
SoundFile myAlarm; 

String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;
PFont orcFont;

void setup() {
 size (1366, 768); 
 smooth();
 
 // Kept your COM7 port setting
 try {
   myPort = new Serial(this, "COM7", 9600); 
   myPort.bufferUntil('.'); 
 } catch (Exception e) {
   println("ERROR: Could not connect to Arduino! Check your COM port number.");
 }
 
 orcFont = createFont("Arial Bold", 20);
 textFont(orcFont);
 
 try {
   myAlarm = new SoundFile(this, "alarm.mp3");
 } catch (Exception e) {
   println("WARNING: Could not find alarm.mp3! Make sure you created the 'data' folder.");
 }
}

void draw() {
  fill(0, 50); 
  noStroke();
  rect(0, 0, width, height-height*0.065); 
  
  drawRadarGrid(); 
  drawSweepLine();
  drawObject();
  drawInterfaceText();
  
  checkAlarm();
}

void checkAlarm() {
  if (iDistance < 15 && iDistance > 1) {
    if (myAlarm != null && !myAlarm.isPlaying()) {
      myAlarm.play();
    }
  } 
}

void serialEvent (Serial myPort) { 
  try {
    data = myPort.readStringUntil('.');
    data = data.substring(0,data.length()-1);
    
    index1 = data.indexOf(","); 
    angle= data.substring(0, index1); 
    distance= data.substring(index1+1, data.length()); 
    
    iAngle = int(angle);
    iDistance = int(distance);
  } catch(RuntimeException e) {
    e.printStackTrace();
  }
}

// --- VISUAL FUNCTIONS ---

void drawRadarGrid() {
  pushMatrix();
  translate(width/2,height-height*0.074); 
  noFill();
  strokeWeight(2);
  
  stroke(0, 255, 255, 50); 
  
  arc(0,0,(width-width*0.0625),(width-width*0.0625),PI,TWO_PI);
  arc(0,0,(width-width*0.27),(width-width*0.27),PI,TWO_PI);
  arc(0,0,(width-width*0.479),(width-width*0.479),PI,TWO_PI);
  arc(0,0,(width-width*0.687),(width-width*0.687),PI,TWO_PI);
  
  stroke(0, 255, 255, 30); 
  line(-width/2,0,width/2,0);
  line(0,0,-width/2*cos(radians(30)),-width/2*sin(radians(30)));
  line(0,0,-width/2*cos(radians(60)),-width/2*sin(radians(60)));
  line(0,0,-width/2*cos(radians(90)),-width/2*sin(radians(90)));
  line(0,0,-width/2*cos(radians(120)),-width/2*sin(radians(120)));
  line(0,0,-width/2*cos(radians(150)),-width/2*sin(radians(150)));
  line(-width/2*cos(radians(30)),0,width/2,0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width/2,height-height*0.074); 
  strokeWeight(15); 
  stroke(255, 10, 10); 
  
  pixsDistance = iDistance*((height-height*0.1666)*0.025); 
  
  if(iDistance<40){
    line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),(width-width*0.505)*cos(radians(iAngle)),-(width-width*0.505)*sin(radians(iAngle)));
    noStroke();
    fill(255, 0, 0, 150);
    ellipse(pixsDistance*cos(radians(iAngle)), -pixsDistance*sin(radians(iAngle)), 20, 20);
  }
  popMatrix();
}

void drawSweepLine() {
  pushMatrix();
  strokeWeight(5);
  stroke(0, 255, 255); 
  translate(width/2,height-height*0.074); 
  line(0,0,(height-height*0.12)*cos(radians(iAngle)),-(height-height*0.12)*sin(radians(iAngle))); 
  popMatrix();
}

// --- CLEANED UP INTERFACE (NO ANGLES) ---
void drawInterfaceText() { 
  pushMatrix();
  
  if(iDistance>40) {
    noObject = "SCANNING...";
    fill(0, 255, 255); 
  }
  else {
    noObject = "TARGET DETECTED";
    fill(255, 0, 0); 
  }
  
  noStroke();
  fill(0, 10, 20); 
  rect(0, height-height*0.0648, width, height);
  
  textSize(25);
  fill(0, 255, 255); 
  text("10cm",width-width*0.3854,height-height*0.0833);
  text("20cm",width-width*0.281,height-height*0.0833);
  text("30cm",width-width*0.177,height-height*0.0833);
  text("40cm",width-width*0.0729,height-height*0.0833);
  
  textSize(30);
  if(iDistance < 40) { fill(255, 50, 50); } 
  else { fill(0, 255, 255); } 
  
  text("STATUS: " + noObject, width-width*0.875, height-height*0.0277);
  text("ANGLE: " + iAngle +" °", width-width*0.48, height-height*0.0277);
  text("DIST: ", width-width*0.26, height-height*0.0277);
  
  if(iDistance<40) {
    text(iDistance +" cm", width-width*0.20, height-height*0.0277);
  } else {
    text("---", width-width*0.20, height-height*0.0277);
  }
  
  popMatrix(); 
}
