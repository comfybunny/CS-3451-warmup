int width = 700;
float centerPoint = width/2.0;
float section = width/6;
int iterations = 17;
float vValues [][], points[][];
int currV;
// assuming layout of program is a square
void setup(){
 size(width, width);
 
}

void draw(){
  stroke(1);
  
  background(255,255,255);
  
  line(centerPoint, 0, centerPoint, width);
  line(0, centerPoint , width, centerPoint);
  line(section, 0, section, width);
  line(0, 2*section , width, 2*section);
  line(2*section, 0, 2*section, width);
  line(0, section , width, section);
  line(0, 5*section , width, 5*section);
  line(4*section, 0, 4*section, width);
  line(0, 4*section , width, 4*section);
  line(5*section, 0, 5*section, width);
  noStroke();
  fill(0,0,255);
  ellipse(centerPoint, centerPoint, 3.0, 3.0);
  
  float mousePosX = (mouseX-centerPoint)/section;
  float mousePosY = -1*(mouseY-centerPoint)/section;
  
  vValues = new float[iterations][2];
  vValues[0][0] = 1;
  vValues[0][1] = 0;
  vValues[1][0] = mousePosX;
  vValues[1][1] = mousePosY;
  // (a+bi) * (c+di) = (ac-bd)+(bc+ad)i
  // (a+bi) old value
  // (c+di) is v (mousePosX, mousePosY)
  // vValues[i-1][0] is the x position of the previous V value ~ a
  // vValues[i-1][1] is the y position of the previous V value ~ b
  for(int i=2; i<iterations; i++){
      vValues[i][0] = vValues[i-1][0]*mousePosX - vValues[i-1][1]*mousePosY;
      vValues[i][1] = vValues[i-1][1]*mousePosX + vValues[i-1][0]*mousePosY;
  }
  
  points = new float[(int)pow(2,iterations)-1][2];
  points[0][0] = 0;  // first point's x value
  points[0][1] = 0;  // first point's y value
  points[1][0] = 1;
  points[1][1] = 0;
  points[2][0] = -1;
  points[2][1] = 0;
  
  currV = 1;
  for(int i=3; i<(int)pow(2,iterations)-1; i=i+2){
    if(i>=pow(2,currV+2)-2){
      currV+=1;
    }
    int xParent = (i-1)/2;    // x value of parent of i
    points[i][0] = points[xParent][0]+vValues[currV][0];
    points[i][1] = points[xParent][1]+vValues[currV][1];
    points[i+1][0] = points[xParent][0]-vValues[currV][0];
    points[i+1][1] = points[xParent][1]-vValues[currV][1];

  }
  
  for(int i = 0; i<(int)pow(2,iterations)-1; i++){
    if(i%13==0){
      fill(255,0,0);
    }
    else if(i%13==1){
      fill(0,255,0);
    }
    else if(i%13==2){
      fill(0,0,255);
    }
    else if(i%13==3){
      fill(255,255,0);
    }
    else if(i%13==4){
      fill(0,255,255);
    }
    else if(i%13==5){
      fill(255,0,255);
    }
    else if(i%13==6){
      fill(150,150,0);
    }
    else if(i%13==7){
      fill(0,150,0);
    }
    else if(i%13==8){
      fill(0,150,200);
    }
    else if(i%13==9){
      fill(0,15,0);
    }
    else if(i%13==10){
      fill(255,150,255);
    }
    ellipse(points[i][0]*section+centerPoint, (-1*points[i][1]*section)+centerPoint, 3.0, 3.0);
  }
  
  text(mousePosX + "," + mousePosY,0,10);
  //for(int i = 0; i < 10; i++)  {
  //  text(vValues[i][0] + "," + vValues[i][1],0,30+i*10);
  //}
}
