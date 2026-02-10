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
  myServo.attach(12); 
}

void loop() {
  // --- SWEEP RIGHT (FAST) ---
  // Changed i++ to i+=2 (Moves 2 steps at a time = Faster)
  for(int i=15; i<=165; i+=2){  
    myServo.write(i);
    
    // Changed delay(30) to delay(10) (Less waiting = Faster)
    delay(10); 
    
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
  
  // --- SWEEP LEFT (FAST) ---
  for(int i=165; i>15; i-=2){  
    myServo.write(i);
    
    // Changed delay(30) to delay(10)
    delay(10); 
    
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
  
  // ADDED TIMEOUT: 10000 microseconds (10ms)
  // This prevents the code from freezing for 1 second if it misses a target
  duration = pulseIn(echoPin, HIGH, 10000); 
  
  if(duration == 0) return 100; // If no reading, assume far away (100cm)
  
  distance = duration*0.034/2;
  return distance;
}

// Function to Freeze and Stare
void stopAndStare(int currentAngle) {
  unsigned long startTime = millis(); 
  
  while(millis() - startTime < 4000) { 
    myServo.write(currentAngle);
    distance = calculateDistance();
    
    Serial.print(currentAngle);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
    
    delay(100); 
  }
}
