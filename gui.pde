import controlP5.*;
import processing.serial.*;

Serial port;

ControlP5 cp5;
CheckBox checkbox;
PFont font;

byte laneArr[] = new byte[56];
byte lane = 0;

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
    checkbox.deactivateAll();
}

void Submit() {
  if (textVal != "Select Lane") {
    println(lane);
    laneArr[0] = lane;
    for(int i = 0; i < 55; i++) {
      laneArr[i+1] = byte(checkbox.getState(i));
      println(byte(checkbox.getState(i)));
    }
    port.write(laneArr);
    println("Done");
    checkbox.deactivateAll();
    lane = 0;
    textVal = "Select Lane";
  }
}

void Lane1() {
  lane = 1;
  textVal = "Lane 1";
}

void Lane2() {
  lane = 2;
  textVal = "Lane 2";
}

void Lane3() {
  lane = 3;
  textVal = "Lane 3";
}

void Lane4() {
  lane = 4;
  textVal = "Lane 4";
}

void Lane5() {
  lane = 5;
  textVal = "Lane 5";
}

void Lane6() {
  lane = 6;
  textVal = "Lane 6";
}

void Lane7() {
  lane = 7;
  textVal = "Lane 7";
}

void Lane8() {
  lane = 8;
  textVal = "Lane 8";
}

void Lane9() {
  lane = 9;
  textVal = "Lane 9";
}

void Lane10() {
  lane = 10;
  textVal = "Lane 10";
}

void Lane11() {
  lane = 11;
  textVal = "Lane 11";
}

void Lane12() {
  lane = 12;
  textVal = "Lane 12";
}

void Lane13() {
  lane = 13;
  textVal = "Lane 13";
}

void Lane14() {
  lane = 14;
  textVal = "Lane 14";
}

void Lane15() {
  lane = 15;
  textVal = "Lane 15";
}

void Lane16() {
  lane = 16;
  textVal = "Lane 16";
}
