class powerUp {
  float x;
  float y;
  
  int type;
  color c;
  boolean alive=false;
  
  powerUp(Block block){
    x=block.x+block.blockWidth/2;
    y=block.y+block.blockHeight;
    type=int(random(2));
    if(type==0){
      c=#33ccff;
    }
    else if(type==1){
      c=#cc66ff;
    }
    else if(type==2){
      c=#ff6600;
    }
    
  }
    
  
  
  void show(){
    if(alive){
    noStroke();
    fill(c);
    ellipse(x, y, 8, 8);
    }
  }
  
  void update(){
    x+=3;
  }
    
  
}