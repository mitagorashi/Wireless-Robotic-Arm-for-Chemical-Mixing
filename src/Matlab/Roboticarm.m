% ---------------------------------------------------------
% PROJECT: Wireless Robotic Arm Control (MATLAB Mode)
% HARDWARE: Arduino Nano + 5 Servos
% PROTOCOL: Firmata / USB Serial
% ---------------------------------------------------------

clc; clear; close all;

fprintf('----------------------------------------\n');
fprintf('Initializing Arduino Connection...\n');
fprintf('----------------------------------------\n');

% --- SECTION 1: HARDWARE INITIALIZATION ---
% The 'try-catch' block ensures the port is available.
% 'Libraries', 'Servo' loads the specific servo control module.
try
    a = arduino(); 
    fprintf('SUCCESS: Connected to Arduino on %s\n', a.Port);
catch ME
    fprintf('ERROR: Connection Failed.\n');
    fprintf('Ensure "StandardFirmata" is uploaded to the board.\n');
    rethrow(ME);
end

% --- SECTION 2: ACTUATOR CONFIGURATION ---
fprintf('Attaching Servos to Digital Pins...\n');

% The servo() function defines the hardware limitations.
% Pulse widths (544-2400 micro-seconds) are calibrated for SG90 motors.
s1 = servo(a, 'D5', 'MinPulseDuration', 544e-6, 'MaxPulseDuration', 2400e-6); % Waist
s2 = servo(a, 'D6', 'MinPulseDuration', 544e-6, 'MaxPulseDuration', 2400e-6); % Shoulder
s3 = servo(a, 'D7', 'MinPulseDuration', 544e-6, 'MaxPulseDuration', 2400e-6); % Elbow
s5 = servo(a, 'D9', 'MinPulseDuration', 544e-6, 'MaxPulseDuration', 2400e-6); % Wrist
s6 = servo(a, 'D10', 'MinPulseDuration', 544e-6, 'MaxPulseDuration', 2400e-6); % Gripper

% --- SECTION 3: HOMING SEQUENCE ---
% MATLAB servo functions accept inputs from 0.0 to 1.0.
% We divide degrees by 180 to normalize the value.
fprintf('Executing Home Sequence...\n');

writePosition(s1, 90/180);   % Center Waist
writePosition(s2, 150/180);  % Reset Shoulder
writePosition(s3, 35/180);   % Retract Elbow
writePosition(s5, 85/180);   % Level Wrist
writePosition(s6, 80/180);   % Open Gripper

pause(1); % Allow mechanical settling time

% --- SECTION 4: REAL-TIME CONTROL LOOP ---
fprintf('----------------------------------------\n');
fprintf('MANUAL CONTROL MODE ACTIVE\n');
fprintf('Command Syntax: [MotorID] [Angle]\n');
fprintf('Example: "1 180" rotates Waist to 180 degrees.\n');
fprintf('Type "q" to exit.\n');
fprintf('----------------------------------------\n');

while true
    % Acquire user input string
    prompt = '>> Enter Command: ';
    str = input(prompt, 's');
    
    if strcmpi(str, 'q')
        break; % Exit loop
    end
    
    try
        % Parse string into integers
        data = sscanf(str, '%d %d');
        motorID = data(1);
        angle = data(2);
        
        % Safety Limiter: Clamp values between 0 and 180
        if angle < 0, angle = 0; end
        if angle > 180, angle = 180; end
        
        % Normalize for MATLAB function (0.0 - 1.0)
        normPos = angle / 180;
        
        % Router Switch: Send signal to correct motor object
        switch motorID
            case 1
                writePosition(s1, normPos);
                fprintf('Actuating Waist -> %d deg\n', angle);
            case 2
                writePosition(s2, normPos);
                fprintf('Actuating Shoulder -> %d deg\n', angle);
            case 3
                writePosition(s3, normPos);
                fprintf('Actuating Elbow -> %d deg\n', angle);
            case 5
                writePosition(s5, normPos);
                fprintf('Actuating Wrist -> %d deg\n', angle);
            case 6
                writePosition(s6, normPos);
                fprintf('Actuating Gripper -> %d deg\n', angle);
            otherwise
                fprintf('Error: Invalid Motor ID.\n');
        end
        
    catch
        fprintf('Error: Command not recognized.\n');
    end
end

clear a; % Destructor to release COM port