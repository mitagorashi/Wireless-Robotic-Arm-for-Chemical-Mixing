# Wireless Robotic Arm for Chemical Mixing (5-DOF)

> **A simulation-validated, Arduino-based robotic system designed for hazardous laboratory automation.**

## 📌 Project Overview
[cite_start]This project addresses laboratory safety risks by providing a low-cost, 5-Degrees-of-Freedom (DOF) robotic arm for chemical mixing[cite: 10, 53]. [cite_start]By utilizing a wireless interface, operators can handle hazardous or toxic substances from a safe distance, reducing exposure by up to 85%[cite: 55, 78].

## 🚀 Technical Features
* [cite_start]**5-DOF Architecture**: Optimized kinematic chain featuring Waist, Shoulder, Elbow, Wrist Pitch, and Gripper joints [cite: 104, 106-110].
* [cite_start]**Wireless Control**: HC-05 Bluetooth integration for remote operation via Android devices[cite: 11, 84].
* [cite_start]**Motion Smoothing**: Custom C++ implementation using incremental delay loops to prevent liquid splashing and mechanical "jerk" [cite: 158-160, 352].
* [cite_start]**Input Sanitization**: Robust parsing logic with whitespace trimming and case-insensitivity for reliable command execution [cite: 183-186].
* [cite_start]**Digital Twin Validation**: Fully simulated in Proteus ISIS to verify logic and electrical integrity before physical builds[cite: 14, 117].

## 🛠️ System Components
* [cite_start]**Microcontroller**: Arduino Nano (ATmega328P)[cite: 81, 112].
* [cite_start]**Actuators**: 5x SG90 Micro Servos[cite: 113].
* [cite_start]**Communication**: HC-05 Bluetooth Module (Serial Port Profile)[cite: 84, 114].
* [cite_start]**GUI**: Custom Android App developed via MIT App Inventor[cite: 13, 166].
* [cite_start]**Alternative Control**: PC-Centric interface utilizing MATLAB and the Firmata protocol[cite: 189, 194].

## 📊 Simulation Performance
[cite_start]The system was validated through a live data link between the smartphone app and the Proteus simulation engine[cite: 337].
* [cite_start]**Latency**: Recorded at less than 20ms for real-time responsiveness[cite: 141].
* [cite_start]**Home Positioning**: Automatic calibration to safety coordinates (90°, 150°, 35°, 85°, 80°) upon boot [cite: 322-327].

## 📂 Repository Structure
* `/src`: Arduino (.ino) and MATLAB (.m) source code.
* `/simulation`: Proteus Design Suite files and compiled .hex firmware.
* `/docs`: Full technical project report and pin mapping tables.

---
*Developed as part of an Electrical Engineering research project focusing on industrial automation and robotics.*