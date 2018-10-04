// World class that holds all of the Pillars

class World{

  Person person;
  int num_pillars = 5;
  
  Pillar[] pillar = new Pillar[5];
  PVector[] pillar_config = new PVector[num_pillars];
  
  World(Person _person){
    person = _person;
    
    pillar_config[0] = new PVector(0, -180, -400);
    pillar_config[1] = new PVector(600, -180, -100);
    pillar_config[2] = new PVector(400, -180, 400);
    pillar_config[3] = new PVector(-400, -180, 400);
    pillar_config[4] = new PVector(-600, -180, -100);
  
    int i;
    for (i = 0; i < num_pillars; i++) {
      println("i: " + i);
      pillar[i] = new Pillar(i, person, pillar_config[i], 180);
    }

  }
    
  void update(){
    
    println();
  
  }
  
  void draw(){
    
    int i;
    for (i = 0; i < num_pillars; i++) {
      println("i: " + i);
      pillar[i].draw();
    }  
  }
}
