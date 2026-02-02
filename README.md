# 🚁 SONIC V1: Ultrasonic Sentry System

**Status:** V1 Prototype Completed  
**Type:** Autonomous Object Tracking & Surveillance  
**Tech Stack:** Arduino (C++), Processing (Java), Ultrasonic Echolocation

## 📖 Project Overview
The **SONIC V1** is a real-time radar system inspired by biological echolocation (bats) and military tracking interfaces (Iron Man J.A.R.V.I.S.). Unlike passive radars, this unit features **"Active Sentry Mode"**: it autonomously scans the environment, detects intruders within a 15cm perimeter, locks onto the target, and triggers an audio-visual alarm.

## ⚙️ Features
- **Real-Time Mapping:** Visualizes distance and angle on a 180-degree grid.
- **Sentry Logic:** Auto-locking mechanism freezes the servo when a target is detected.
- **Audio Feedback:** Plays a "Warning" alert via the host computer when perimeter is breached.
- **Visual Interface:** Custom "Iron Man" style GUI built in Processing.

## 🛠️ Hardware Requirements
1. **Microcontroller:** Arduino UNO (UNo R3 CH340G ATmega328p Developtment Board with USB Type-B Cable - Compatible with Arduino- KIT-QC0012)
2. **Sensor:** HC-SR04 Ultrasonic Sensor (MOD-QC0012)
3. **Actuator:** SG90 Micro Servo Motor ( Tower Pro SG90 Servo Motor - 9 gms Mini/Micro Servo Motor - MTR - Qc0303)
4. **Base:** Custom Printed Sci-Fi Chassis (custom designed by using prompts as well)
5. **Mini Breadboard:** 170 pounts mini breadboard Solderless Breadboard - TLS - QC0542
6. **Male to Male Jumper Wires**

## 🚀 How to Run
   
1. **Hardware:** Connect the Arduino to USB (COM Port).
2. **Arduino:** Upload the `sketch_jan28a.ino` file to the board.
3. **Processing:** Open `Radar_Display.pde`.
   - Ensure the `alarm.mp3` file is in the `data` folder.
   - Change the COM Port in the code to match your Arduino.
4. **Launch:** Press Play in Processing to initialize the Sentry.

---
*Created by Dimension Drifters Team*
*-Nihal Singh,Yashmeen Paul,Saksham Thakur-*
