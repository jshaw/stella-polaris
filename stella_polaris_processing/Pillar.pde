// Pillar class that holds all of the pillars & info

class Pillar{

  PVector pillarPosition = new PVector();
  int pillarHeight;
  PGraphics fbo;
  int index;
  
  int tubeRes = 32;
  int imgWidth = 8;
  int imgHeight = 120;
  //int imgWidth = 12;
  //int imgHeight = 180;

  float globalDist = 0;

  float average_distance = 0;
  
  
  // Pillar(int _i, Person _person, PVector _pillarPosition, int _pillarHeight){ 
  Pillar(int _i, ArrayList _people, PVector _pillarPosition, int _pillarHeight){ 
    index = _i;
    people = _people;
    pillarPosition = _pillarPosition;
    pillarHeight = _pillarHeight;
    
    textSize(28);
    
    fbo = createGraphics(imgWidth, imgHeight);
    
  }
    
  // void update(PVector _pillarPosition){
  //   pillarPosition = _pillarPosition;
  // }

  void update(ArrayList _people){
    people = _people;

    int peopleSize = people.size();

    globalDist = 0;

    for (int p = 0; p < peopleSize; p++) {
      Person person = people.get(p);

      globalDist += pillarPosition.dist(person.personPosition);

      float dist = pillarPosition.dist(person.personPosition);

      // here, the index is used as the pillar index
      // so each Person has a array to store the distance to 
      // one of the 5 pillars
      person.personPillarDist[index] = dist;

      average_distance = globalDist / peopleSize;

      // float person_position_z = calculateDistance(rssi);
      // person_position_z *= 100;


      // if(deviceUID == person.deviceUID){
        
      //   person.personPosition.z = person_position_z;
      //   PVector _personPosition = person.personPosition;

      //   person.updateParams(_personPosition, rssi, mfd, active, deviceUID);
      //   person.updateLastSeen(lastSeen);
      // } else {
      //   people.add(new Person(personPosition, 400, clearSeen, rssi, mfd, active, deviceUID, lastSeen);
      // }
    }
  }
  

  float r;
  float f_color;
  
  void draw(){
    


    int peopleSize = people.size();

    for (int p = 0; p < peopleSize; p++) {
      Person person = people.get(p);

      // globalDist += pillarPosition.dist(person.personPosition);

      // float dist = pillarPosition.dist(person.personPosition);

      // person.personPillarDist[p] = dist;

      // average_distance = globalDist / peopleSize;

      pushMatrix();
        fill(0);
        translate(50, -250, 50);
        // println(person.personPosition.x);
        // println(person.personPosition.z);
        // float dist = pillarPosition.dist(person.personPosition);
        
        pushMatrix();
          noFill();
          translate(-50, 0, -50);
          translate(pillarPosition.x, pillarPosition.y, pillarPosition.z);
          rotateX(PI/2);
          // drawProximityCircle(dist, imgWidth * 3, 550);

          // here, the index is used as the pillar index
          // so each Person has a array to store the distance to 
          // one of the 5 pillars
          drawProximityCircle(person.personPillarDist[index], imgWidth * 3, 550);
        popMatrix();
        
        text("Distance to Person: \n" + pillarPosition.dist(person.personPosition), pillarPosition.x, pillarPosition.y, pillarPosition.z);
      popMatrix();

      
    }

    // pushMatrix();
    //   fill(0);
    //   translate(50, -250, 50);
    //   // println(person.personPosition.x);
    //   // println(person.personPosition.z);
    //   // float dist = pillarPosition.dist(person.personPosition);
      
    //   pushMatrix();
    //     noFill();
    //     translate(-50, 0, -50);
    //     translate(pillarPosition.x, pillarPosition.y, pillarPosition.z);
    //     rotateX(PI/2);
    //     // drawProximityCircle(dist, imgWidth * 3, 550);
    //     drawProximityCircle(average_distance, imgWidth * 3, 550);
    //   popMatrix();
      
    //   text("Distance to Person: \n" + pillarPosition.dist(person.personPosition), pillarPosition.x, pillarPosition.y, pillarPosition.z);
    // popMatrix();
    
    
    pushMatrix();
      translate(pillarPosition.x, pillarPosition.y, pillarPosition.z);
      rotateX(PI/2);
      fill(220, 20);
      //box(100, pillarHeight, 20);
      //drawCylinder();
      noStroke();
      drawCylinder(tubeRes, imgWidth * 3, imgHeight * 3);
      stroke(0);
      strokeWeight(1);
    popMatrix();
    fill(255);
    
    int y = 20 + (index * 30);

    fbo.beginDraw();
      fbo.colorMode(RGB);

      fbo.background(0, 0, 0, 255);
      pushMatrix();
        // f_color = map((int)dist, 180, 1500, 0, 255);
        f_color = map((int)average_distance, 180, 1500, 0, 255);
        fbo.background(255, (int)f_color, 0, 255);
      popMatrix();
    fbo.endDraw();

    cam.beginHUD();
      image(fbo, 20 + index * (imgWidth * 3 ) , 20, imgWidth * 2, imgHeight * 2);
    cam.endHUD();
  
  }
  
  void drawProximityCircle(float _dist, float sides, float h){
    float angle = 360.0 / (float)sides;
    float halfHeight = h / 2;
    
    r = _dist - 140;
    // draw proximity between person and pillar  
    beginShape();
    for (int i = 0; i <= sides; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
  
  }
   
  void drawCylinder( int sides, float r, float h) {
    float angle = 360.0 / (float)sides;
    float halfHeight = h / 2;

  
    // draw top + bottom of the tube
    drawEnds(halfHeight, angle, sides, r, h);
  
    // draw sides
    beginShape(TRIANGLE_STRIP);
  
    // Texture the cylinder
    // Use img for debugging image mapping w/ a static image 
    // texture(img);
    texture(fbo);
  
    for (int i = 0; i < sides + 1; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      // already commented out
      //float u = fbo.width / tubeRes * i;
      // END: already commented out
      
      // Use for texture mapping the shape
      // Uncomment out when it's ready to go to be worked on like that
      //float u = (float)fbo.width / (float)tubeRes * (float)i;
      //vertex( x, y, halfHeight, u, 0);
      //vertex( x, y, -halfHeight, u, fbo.height);
      
      vertex( x, y, halfHeight);
      vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
  }
  
  void drawEnds(float halfHeight, float angle, int sides, float r, float h) {
    // draw top of the tube  
    beginShape();
    for (int i = 0; i <= sides; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
  
    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
  }


}
