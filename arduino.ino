#include <DS3232RTC.h>
#include <time.h>

#define LANE_TIMES 55

time_t t;

// Lane Time Arrays
int lane_1[LANE_TIMES];
int lane_2[LANE_TIMES];
int lane_3[LANE_TIMES];
int lane_4[LANE_TIMES];
int lane_5[LANE_TIMES];
int lane_6[LANE_TIMES];
int lane_7[LANE_TIMES];
int lane_8[LANE_TIMES];
int lane_9[LANE_TIMES];
int lane_10[LANE_TIMES];
int lane_11[LANE_TIMES];
int lane_12[LANE_TIMES];
int lane_13[LANE_TIMES];
int lane_14[LANE_TIMES];
int lane_15[LANE_TIMES];
int lane_16[LANE_TIMES];

int currentTimeTick = 0;

bool start = true;

void setup() {
  Serial.begin(9600);
  setSyncProvider(RTC.get); // Syncs RTC up with time library
  for (unsigned char i = 0; i < 11; i++) { // Set pins 2-12 to OUTPUT
    pinMode(i+2, OUTPUT);
  }
  for (unsigned char i = 30; i < 35; i++) { // Set pins 30-34 to OUTPUT
    pinMode(i, OUTPUT);
  }
  //digitalWrite(4, HIGH);  // White LED
  setCurrentTimeTick();
}

void loop() {
  t = now();
  while (Serial.available()) {
    delay(100);
    fillArray();
    changeLights();
  }
  printTime();
  if ((minute(t) % 15 == 0 && second(t) == 0)) {
    Serial.print("Updating Time Tick at");
    printTime();
    setCurrentTimeTick();
    changeLights(); // Added this to here, if issues, move this back down two lines :(|)
  }
  Serial.println(currentTimeTick);
}

void loopFill(int arr[]) {
  for (unsigned char i = 0; i < LANE_TIMES; i++) {
    arr[i] = Serial.read();
  }
}

void fillArray() {
  Serial.flush();
  unsigned int received = Serial.read();
  if (received == 1) {
    loopFill(lane_1);
  }
  else if (received == 2) {
    loopFill(lane_2);
  }
  else if (received == 3) {
    loopFill(lane_3);
  }
  else if (received == 4) {
    loopFill(lane_4);
  }
  else if (received == 5) {
    loopFill(lane_5);
  }
  else if (received == 6) {
    loopFill(lane_6);
  }
  else if (received == 7) {
    loopFill(lane_7);
  }
  else if (received == 8) {
    loopFill(lane_8);
  }
  else if (received == 9) {
    loopFill(lane_9);
  }
  else if (received == 10) {
    loopFill(lane_10);
  }
  else if (received == 11) {
    loopFill(lane_11);
  }
  else if (received == 12) {
    loopFill(lane_12);
  }
  else if (received == 13) {
    loopFill(lane_13);
  }
  else if (received == 14) {
    loopFill(lane_14);
  }
  else if (received == 15) {
    loopFill(lane_15);
  }
  else if (received == 16) {
    loopFill(lane_16);
  }
}

void setCurrentTimeTick() {
  t = now();
  char hourTick = hour(t) - 5;
  unsigned char minTick = 0;
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

void changeLights() {
  if (lane_1[currentTimeTick] == 1) digitalWrite(2, HIGH);  // Lane 1
  else if (lane_1[currentTimeTick] == 0) digitalWrite(2, LOW);
  if (lane_2[currentTimeTick] == 1) digitalWrite(3, HIGH);  // Lane 2
  else if (lane_2[currentTimeTick] == 0) digitalWrite(3, LOW);
  if (lane_3[currentTimeTick] == 1) digitalWrite(4, HIGH);  // Lane 3
  else if (lane_3[currentTimeTick] == 0) digitalWrite(4, LOW);
  if (lane_4[currentTimeTick] == 1) digitalWrite(5, HIGH);  // Lane 4
  else if (lane_4[currentTimeTick] == 0) digitalWrite(5, LOW);
  if (lane_5[currentTimeTick] == 1) digitalWrite(6, HIGH);  // Lane 5
  else if (lane_5[currentTimeTick] == 0) digitalWrite(6, LOW);
  if (lane_6[currentTimeTick] == 1) digitalWrite(7, HIGH);  // Lane 6
  else if (lane_6[currentTimeTick] == 0) digitalWrite(7, LOW);
  if (lane_7[currentTimeTick] == 1) digitalWrite(8, HIGH);  // Lane 7
  else if (lane_7[currentTimeTick] == 0) digitalWrite(8, LOW);
  if (lane_8[currentTimeTick] == 1) digitalWrite(9, HIGH);  // Lane 8
  else if (lane_8[currentTimeTick] == 0) digitalWrite(9, LOW);
  if (lane_9[currentTimeTick] == 1) digitalWrite(10, HIGH);  // Lane 9
  else if (lane_9[currentTimeTick] == 0) digitalWrite(10, LOW);
  if (lane_10[currentTimeTick] == 1) digitalWrite(11, HIGH);  // Lane 10
  else if (lane_10[currentTimeTick] == 0) digitalWrite(11, LOW);
  if (lane_11[currentTimeTick] == 1) digitalWrite(12, HIGH);  // Lane 11
  else if (lane_11[currentTimeTick] == 0) digitalWrite(12, LOW);
  if (lane_12[currentTimeTick] == 1) digitalWrite(30, HIGH);  // Lane 12
  else if (lane_12[currentTimeTick] == 0) digitalWrite(30, LOW);
  if (lane_13[currentTimeTick] == 1) digitalWrite(31, HIGH);  // Lane 13
  else if (lane_13[currentTimeTick] == 0) digitalWrite(31, LOW);
  if (lane_14[currentTimeTick] == 1) digitalWrite(32, HIGH);  // Lane 14
  else if (lane_14[currentTimeTick] == 0) digitalWrite(32, LOW);
  if (lane_15[currentTimeTick] == 1) digitalWrite(33, HIGH);  // Lane 15
  else if (lane_15[currentTimeTick] == 0) digitalWrite(33, LOW);
  if (lane_16[currentTimeTick] == 1) digitalWrite(34, HIGH);  // Lane 16
  else if (lane_16[currentTimeTick] == 0) digitalWrite(34, LOW);
}

void printTime() {
  bool PM = NULL;
  if (hour(t) < 10) Serial.print('0'), Serial.print(hour(t)), PM = false;
  else if (hour(t) >= 10 && hour(t) < 13) Serial.print(hour(t));
  else Serial.print(hour(t) - 12), PM = true;
  Serial.print(':');
  if (minute(t) < 10) Serial.print('0');
  else Serial.print(minute(t));
  Serial.print(':');
  if (second(t) < 10) Serial.print('0');
  Serial.print(second(t));
  if (PM = false) Serial.println(" am");
  else Serial.println(" pm");
  delay(1000);
}
