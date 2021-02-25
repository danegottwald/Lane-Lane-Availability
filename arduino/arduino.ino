
#include <DS3232RTC.h>
#include <time.h>

#define LANE_TIMES 54
#define LANE_COUNT 16

time_t t;

// Lane Time Arrays
byte lanes[LANE_COUNT][LANE_TIMES];

// Global Variables
int currentTimeTick;
bool night = false;

// Setup RTC and Serial connection
void setup() {
  Serial.begin(9600);
  // Syncs RTC up with time library
  setSyncProvider(RTC.get);
   // Set pins 2-17 to OUTPUT pins
  for (int i = 0; i < 16; i++) {
    pinMode(i + 2, OUTPUT);
    //digitalWrite(i + 2, HIGH);
  }
  // Sets RTC time
  setCurrentTimeTick();
}

void loop() {
  t = now();
  while (Serial.available() > 0) {
    delay(100);
    loopFill();
    if (currentTimeTick >= 0 && currentTimeTick < 54) {
      changeLights();
    }
  }
  //printTime();
  if (minute(t) % 15 == 0 && second(t) == 0) {
    Serial.print("Updating Time Tick at ");
    printTime();
    setCurrentTimeTick();
    if (currentTimeTick >= 0 && currentTimeTick < 54) {
      night = false;
      changeLights();
    }
    else if (night != true) {
      night = true;
      lightsOut();
    }
  }
}

void loopFill() {
  Serial.flush();
  byte received = Serial.read();
  for (int i = 0; i < LANE_TIMES; i++) {
    lanes[received][i] = Serial.read();
  }
}

void setCurrentTimeTick() {
  t = now();
  int hourTick = hour(t) - 5;
  byte minTick = 0;
  if (minute(t) < 15) {
    hourTick = (hourTick - 1) * 4;
    minTick = 2;
  }
  else if (minute(t) >= 30) {
    hourTick = hourTick * 4;
    minTick = (minute(t) - 30) / 15;
  }
  else if (minute(t) >= 15 && minute(t) < 30) {
    hourTick = (hourTick - 1) * 4;
    minTick = 3;
  }
  currentTimeTick = hourTick + minTick;
}

// Change the output of each of the pins at the current time
void changeLights() {
  for (int i = 0; i < LANE_COUNT; i++) {
    if (lanes[i][currentTimeTick] == 1) {
	  digitalWrite(i + 2, HIGH);
	}
	else if (lanes[i][currentTimeTick] == 1) {
	  digitalWrite(i + 2, LOW);
	}
  }
}

// Sets all pins, 2-17, to LOW (OFF)
void lightsOut() {
  for (int i = 0; i < LANE_COUNT; i++) {
    digitalWrite(i + 2, LOW);
  }
}

// Displays the current time of the RTC to the console
void printTime() {
  bool PM = NULL;
  // Print Hour
  if (hour(t) < 10) { 
    Serial.print('0');
    Serial.print(hour(t));
    PM = false;
  }
  else if (hour(t) >= 10 && hour(t) < 13) { 
    Serial.print(hour(t));
	PM = false;
  }
  else {
	Serial.print('0');
	Serial.print(hour(t) - 12);
	PM = true;
  }
  Serial.print(':');
  // Print Minute
  if (minute(t) < 10) {
	Serial.print('0');
	Serial.print(minute(t));
  }
  else {
	Serial.print(minute(t));
  }
  Serial.print(':');
  // Print Second
  if (second(t) < 10) {
	Serial.print('0');
  }
  Serial.print(second(t));
  if (PM == false) {
	Serial.println(" am");
  }
  else {
	Serial.println(" pm");
  }
  delay(1000);
}
