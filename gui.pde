import controlP5.*;
import processing.serial.*;

Serial port;

ControlP5 cp5;
CheckBox checkbox;
PFont font;

byte laneArr[] = new byte[56];
byte lane = 0;

int lane_1[] = new int[55];
int lane_2[] = new int[55];
int lane_3[] = new int[55];
int lane_4[] = new int[55];
int lane_5[] = new int[55];
int lane_6[] = new int[55];
int lane_7[] = new int[55];
int lane_8[] = new int[55];
int lane_9[] = new int[55];
int lane_10[] = new int[55];
int lane_11[] = new int[55];
int lane_12[] = new int[55];
int lane_13[] = new int[55];
int lane_14[] = new int[55];
int lane_15[] = new int[55];
int lane_16[] = new int[55];

String textVal = "Select Lane";

void setup() {
  size(1000, 500);
  surface.setTitle("Lap Lane Availability");
  
  printArray(Serial.list());
  
  port = new Serial(this, "COM4", 9600);  // "..." might change depending on PC
  font = createFont("calibri light", 14);
  createMainMenu();
    
}

// NOTE: Possibly add a "if weekday or weekend button to limit amount of possible lanes and times! :)

void draw() {
  background(100, 100, 100);
  fill(0, 0, 0);
  textFont(font);
  textSize(30);
  text("Today's Lane Availability", 375, 50);
  text(textVal, 460, 245);
  text("GREEN  - OPEN", 200, 445);
  text("RED   - CLOSED", 200, 475);
}

void createMainMenu() {
  cp5 = new ControlP5(this);
  for (int i = 0; i < 8; i++) {
  cp5.addButton("Lane" + char(49+i))
    .setFont(font)
    .setPosition(125 + (i*100), 75)
    .setColorActive(color(0, 155, 0))
    .setSize(50, 50);
  }
  cp5.addButton("Lane9")
    .setFont(font)
    .setPosition(125, 150)
    .setColorActive(color(0, 155, 0))
    .setSize(50, 50);
  for (int i = 0; i < 7; i++) {
    cp5.addButton("Lane1" + char(48+i))
    .setFont(font)
    .setPosition(225 + (i*100), 150)
    .setColorActive(color(0, 155, 0))
    .setSize(50, 50);
  }
  cp5.addButton("Submit")
    .setFont(font)
    .setPosition(450, 425)
    .setSize(100, 50);
  timeCheckBoxes();
}

void timeCheckBoxes() { 
  checkbox = cp5.addCheckBox("checkbox")
    .showLabels()
    .setPosition(50, 275)
    .setSize(20, 20)
    .setItemsPerRow(18)
    .setSpacingColumn(30)
    .setSpacingRow(30)
    .setColorBackground(color(150, 0, 0))
    .setFont(font)
    .addItem("05:30", 530) .addItem("05:45", 545) .addItem("06:00", 600) .addItem("06:15", 615) .addItem("06:30", 630)
    .addItem("06:45", 645) .addItem("07:00", 700) .addItem("07:15", 715) .addItem("07:30", 730) .addItem("07:45", 745)
    .addItem("08:00", 800) .addItem("08:15", 815) .addItem("08:30", 830) .addItem("08:45", 845) .addItem("09:00", 900)
    .addItem("09:15", 915) .addItem("09:30", 930) .addItem("09:45", 945) .addItem("10:00", 1000).addItem("10:15", 1015)
    .addItem("10:30", 1030).addItem("10:45", 1045).addItem("11:00", 1100).addItem("11:15", 1115).addItem("11:30", 1130)
    .addItem("11:45", 1145).addItem("12:00", 1200).addItem("12:15", 1215).addItem("12:30", 1230).addItem("12:45", 1245)
    .addItem("1:00", 1300) .addItem("1:15", 1315) .addItem("1:30", 1330) .addItem("1:45", 1345) .addItem("2:00", 1400)
    .addItem("2:15", 1415) .addItem("2:30", 1430) .addItem("2:45", 1445) .addItem("3:00", 1500) .addItem("3:15", 1515)
    .addItem("3:30", 1530) .addItem("3:45", 1545) .addItem("4:00", 1600) .addItem("4:15", 1645) .addItem("4:30", 1630)
    .addItem("4:45", 1645) .addItem("5:00", 1700) .addItem("5:15", 1715) .addItem("5:30", 1730) .addItem("5:45", 1745)
    .addItem("6:00", 1800) .addItem("6:15", 1815) .addItem("6:30", 1830) .addItem("6:45", 1845) .addItem("7:00", 1900);
    checkbox.setColorLabels(color(255, 255, 255));
    checkbox.setColorActive(color(0, 155, 0));
}

void Submit() {
  if (textVal != "Select Lane") {
    println(lane);
    laneArr[0] = lane;
    for(int i = 0; i < 55; i++) {
      laneArr[i+1] = byte(checkbox.getState(i));
      println(byte(checkbox.getState(i)));
    }
    checkArr(laneArr);
    port.write(laneArr);
    println("Done");
    checkbox.deactivateAll();
    lane = 0;
    textVal = "Select Lane";
  }
}

void checkArr(byte arr[]) {
  if (arr[0] == 1) {
    fillArray(lane_1);
  }
  else if (arr[0] == 2) {
    fillArray(lane_2);
  }  
  else if (arr[0] == 3) {
    fillArray(lane_3);
  }  
  else if (arr[0] == 4) {
    fillArray(lane_4);
  } 
  else if (arr[0] == 5) {
    fillArray(lane_5);
  } 
  else if (arr[0] == 6) {
    fillArray(lane_6);
  } 
  else if (arr[0] == 7) {
    fillArray(lane_7);
  } 
  else if (arr[0] == 8) {
    fillArray(lane_8);
  } 
  else if (arr[0] == 9) {
    fillArray(lane_9);
  } 
  else if (arr[0] == 10) {
    fillArray(lane_10);
  } 
  else if (arr[0] == 11) {
    fillArray(lane_11);
  } 
  else if (arr[0] == 12) {
    fillArray(lane_12);
  } 
  else if (arr[0] == 13) {
    fillArray(lane_13);
  } 
  else if (arr[0] == 14) {
    fillArray(lane_14);
  } 
  else if (arr[0] == 15) {
    fillArray(lane_15);
  } 
  else if (arr[0] == 16) {
    fillArray(lane_16);
  } 
}

void fillArray(int arr[]) {
  for (int i = 0; i < 55; i++) {
    arr[i] = laneArr[i+1];
  }
}

void activateBoxes(int arr[]) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] != 0) {
      checkbox.activate(i);
    }
  }
}

void Lane1() {
  checkbox.deactivateAll();
  lane = 1;
  textVal = "Lane 1";
  activateBoxes(lane_1);
}

void Lane2() {
  checkbox.deactivateAll();
  lane = 2;
  textVal = "Lane 2";
  activateBoxes(lane_2);
}

void Lane3() {
  checkbox.deactivateAll();
  lane = 3;
  textVal = "Lane 3";
  activateBoxes(lane_3);
}

void Lane4() {
  checkbox.deactivateAll();
  lane = 4;
  textVal = "Lane 4";
  activateBoxes(lane_4);
}

void Lane5() {
  checkbox.deactivateAll();
  lane = 5;
  textVal = "Lane 5";
  activateBoxes(lane_5);
}

void Lane6() {
  checkbox.deactivateAll();
  lane = 6;
  textVal = "Lane 6";
  activateBoxes(lane_6);
}

void Lane7() {
  checkbox.deactivateAll();
  lane = 7;
  textVal = "Lane 7";
  activateBoxes(lane_7);
}

void Lane8() {
  checkbox.deactivateAll();
  lane = 8;
  textVal = "Lane 8";
  activateBoxes(lane_8);
}

void Lane9() {
  checkbox.deactivateAll();
  lane = 9;
  textVal = "Lane 9";
  activateBoxes(lane_9);
}

void Lane10() {
  checkbox.deactivateAll();
  lane = 10;
  textVal = "Lane 10";
  activateBoxes(lane_10);
}

void Lane11() {
  checkbox.deactivateAll();
  lane = 11;
  textVal = "Lane 11";
  activateBoxes(lane_11);
}

void Lane12() {
  checkbox.deactivateAll();
  lane = 12;
  textVal = "Lane 12";
  activateBoxes(lane_12);
}

void Lane13() {
  checkbox.deactivateAll();
  lane = 13;
  textVal = "Lane 13";
  activateBoxes(lane_13);
}

void Lane14() {
  checkbox.deactivateAll();
  lane = 14;
  textVal = "Lane 14";
  activateBoxes(lane_14);
}

void Lane15() {
  checkbox.deactivateAll();
  lane = 15;
  textVal = "Lane 15";
  activateBoxes(lane_15);
}

void Lane16() {
  checkbox.deactivateAll();
  lane = 16;
  textVal = "Lane 16";
  activateBoxes(lane_16);
}
