/*
 * Project: Wireless Robotic Arm (Final Robust Version)
 * Fix: Case-Insensitive (Works with 'S' and 's')
 */

#include <Servo.h>

Servo servo01;  // Waist (Pin 5)
Servo servo02;  // Shoulder (Pin 6)
Servo servo03;  // Elbow (Pin 7)
Servo servo05;  // Wrist Pitch (Pin 9)
Servo servo06;  // Gripper (Pin 10)

String dataIn = "";
int angle;

void setup() {
  servo01.attach(5);
  servo02.attach(6);
  servo03.attach(7);
  servo05.attach(9);
  servo06.attach(10);
  
  Serial.begin(9600);
  Serial.setTimeout(5000); 
  
  Serial.println("SYSTEM READY.");
  Serial.println("Try typing: S1180 or s1180");
  
  // Force Start Positions
  servo01.write(90);
  servo02.write(150);
  delay(500);
}

void loop() {
  if (Serial.available() > 0) {
    dataIn = Serial.readString();
    dataIn.trim();         // Remove spaces/enter
    dataIn.toLowerCase();  // <--- THE FIX: Converts 'S' to 's' automatically!

    Serial.print("Received: ");
    Serial.println(dataIn);

    // --- WAIST (Pin 5) ---
    if (dataIn.startsWith("s1")) {
      String value = dataIn.substring(2);
      angle = value.toInt();
      
      Serial.print("Moving Waist to: ");
      Serial.println(angle);
      
      servo01.write(angle);
    }
    
    // --- SHOULDER (Pin 6) ---
    if (dataIn.startsWith("s2")) {
      String value = dataIn.substring(2);
      angle = value.toInt();
      servo02.write(angle);
    }
    
    // --- ELBOW (Pin 7) ---
    if (dataIn.startsWith("s3")) {
      String value = dataIn.substring(2);
      angle = value.toInt();
      servo03.write(angle);
    }

    // --- WRIST (Pin 9) ---
    if (dataIn.startsWith("s5")) {
      String value = dataIn.substring(2);
      angle = value.toInt();
      servo05.write(angle);
    }

     // --- GRIPPER (Pin 10) ---
    if (dataIn.startsWith("s6")) {
      String value = dataIn.substring(2);
      angle = value.toInt();
      servo06.write(angle);
    }
  }
}