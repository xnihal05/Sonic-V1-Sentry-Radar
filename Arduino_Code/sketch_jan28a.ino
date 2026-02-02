#include <Servo.h>

const int trigPin = 10;
const int echoPin = 11;
long duration;
int distance;
Servo myServo;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  Serial.begin(9600);
  myServo.attach(12); // Pin 12 for Servo
}

void loop() {
  // Rotate from 15 to 165 degrees
  for(int i=15; i<=165; i++){  
    myServo.write(i);
    delay(30);
    distance = calculateDistance();
    
    // --- THE "LOCK ON" LOGIC ---
    if (distance < 15 && distance > 1) { // If object is closer than 15cm
      stopAndStare(i); // Call the special function
    }
    // ---------------------------
    
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
  
  // Rotate back from 165 to 15 degrees
  for(int i=165; i>15; i--){  
    myServo.write(i);
    delay(30);
    distance = calculateDistance();
    
    // --- THE "LOCK ON" LOGIC ---
    if (distance < 15 && distance > 1) {
      stopAndStare(i);
    }
    // ---------------------------
    
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
}

// Function to measure distance
int calculateDistance(){ 
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance= duration*0.034/2;
  return distance;
}

// Function to Freeze and Stare
void stopAndStare(int currentAngle) {
  // We want to stare for 4000 milliseconds (4 seconds)
  // But we must keep sending data so the Laptop knows to play Audio!
  
  unsigned long startTime = millis(); // Record the time we started staring
  
  while(millis() - startTime < 4000) { // Keep doing this for 4 seconds
    
    // 1. Keep Servo at the current angle (Don't move!)
    myServo.write(currentAngle);
    
    // 2. Measure distance again (Real-time tracking)
    distance = calculateDistance();
    
    // 3. Send data to Laptop (So J.A.R.V.I.S. keeps screaming)
    Serial.print(currentAngle);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
    
    delay(100); // Small delay to prevent crashing
  }
}
