PImage dog_top,dog_20,dog_40,dog_60,dog_80,dog_100;

int stage = 0;
int qes_num = 0;
int score = 0;

int flg = 0;
int screen_no = 0; 
int clicked_b = 0;
int clicked_s = 0;

int flg_correct = 0;
int flg_notcorrect = 0;
int flg_next = 0;
int flg_end = 0;
int clicked_num = 0;
int count = 0;

int c;

Table a;
int[] no;
String[] eng,jpn;
int data_Row, data_Column;

int[] correct_num;
String[] ans1,ans2,ans3,ans4;

//丸ボタンの位置配列
float[] b_x = {180,180,180,180,180,180,180,180,180,180,490,490,490,490,490,490,490,490,490,490}; //丸ボタン(中心)のX座標
float[] b_y = {820,870,920,970,1020,1070,1120,1170,1220,1270,820,870,920,970,1020,1070,1120,1170,1220,1270}; //丸ボタン(中心)のY座標
float[] b_w = {25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25}; //丸ボタンの縦半径
float[] b_h = {25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25}; //丸ボタンの横半径
color[] b_c = {#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF,#FFFFFF}; 

void setup(){

  //pngファイル読み込み
  dog_top = loadImage("dog_top.png");
  dog_20 = loadImage("dog_20.png");
  dog_40 = loadImage("dog_40.png");
  dog_60 = loadImage("dog_60.png");
  dog_80 = loadImage("dog_80.png");
  dog_100 = loadImage("dog_100.png");
  
  
  //csvファイル読み込み
  a = loadTable("target1900.csv");
  data_Row = a.getRowCount();
  data_Column = a.getColumnCount();
  no = new int[data_Row];
  eng = new String[data_Row];
  jpn = new String[data_Row];
  for (int i = data_Row - 1; i >= 0; i--)
  {
    no[i] = a.getInt(i, 0); //問題番号
    eng[i] = a.getString(i, 1); //英語
    jpn[i] = a.getString(i, 2); //日本語
  }
  
  correct_num = new int[100]; //正解番号
  ans1 = new String[100]; //選択肢1
  ans2 = new String[100]; //選択肢2
  ans3 = new String[100]; //選択肢3
  ans4 = new String[100]; //選択肢4
  
  //画面設定
  size(900, 1500);
  background(#FFFFFF); 
  fill(#000000);
  PFont myFont = createFont("MSGothic", 32);
  textFont(myFont, 32);
  flg = 0;
  screen_no = 0;
}

void draw(){
  if (screen_no == 0){
    clearScreen(); 
    Window0(); 
    if(flg == 1){ 
      screen_no = screen_no + 1; 
      flg = 0; 
    }
  }
  else if (screen_no == 1){
    clearScreen();
    Window1();
    if(flg == 1){
      screen_no = screen_no + 1;
      flg = 0;
    }
  }
  else if (screen_no == 2){
    clearScreen();
    Window2();
    if(flg == 1){
      screen_no = 0;
      clicked_s = 0;
      flg = 0;
      clicked_b = 0;
      qes_num = 0;
      score = 0;
    }
  }
}

void clearScreen() {
  fill(#6090ef); 
  rect(0,0, width, height); 
  fill(#FFFFFF); 
}

//スタート画面
void Window0(){
  fill(#000000);
  rect(width / 2-200, 0, 400, 50);
  fill(#FFFFFF);
  rect(80, 700, 740, 80);
  rect(80, 780, 740, 530);
  rect(280, 1350, 340, 80);
  
  //テスト開始ボタンの状態
  if(clicked_s == 1){
    fill(#AAAAAA);
    rect(280, 1350, 340, 80);
    flg = 1;
  }
  
  textSize(32);
  text("大学受験JUKEN新書", 300, 35);
  textSize(100);
  text("英単語ターゲット", 60, 200);
  textSize(300);
  text("1900", 100, 450);
  textSize(32);
  text("TARGET1900 -6th Edition-", 250, 550);
  textSize(50);
  text("6訂版", 90, 652);
  textSize(25);
  text("お茶の水女子大学名誉教授　宮川幸久", 360, 634);
  text("ターゲット編集部 編", 584, 661);
  fill(#000000);
  textSize(32);
  text("テスト出題範囲", 335, 750);
  
  int x,y,z;
  
  for(int i = 0; i <= 99; i++){
    
    //正解番号の設定(1～4で乱数生成)
    int correct = (int)random(4)+1;
    correct_num[i] = correct;
    
    if(correct == 1){
      ans1[i] = jpn[clicked_b*100 + i];
      
      for(x = (int)random(100),y = (int)random(100),z = (int)random(100)
          ;i==x || x==y || y==z || i==y || x==z || i==z ;){
        x = (int)random(100);
        y = (int)random(100);
        z = (int)random(100);
      }
      
      //不正解の選択肢にはランダムで答えを挿入
      ans2[i] = jpn[clicked_b*100 + x];
      ans3[i] = jpn[clicked_b*100 + y];
      ans4[i] = jpn[clicked_b*100 + z];
      
    }
    if(correct == 2){
      ans2[i] = jpn[clicked_b*100 + i];
      
      for(x = (int)random(100),y = (int)random(100),z = (int)random(100)
          ;i==x || x==y || y==z || i==y || x==z || i==z ;){
        x = (int)random(100);
        y = (int)random(100);
        z = (int)random(100);
      }
      
      ans1[i] = jpn[clicked_b*100 + x];
      ans3[i] = jpn[clicked_b*100 + y];
      ans4[i] = jpn[clicked_b*100 + z];
      
    }
    if(correct == 3){
      ans3[i] = jpn[clicked_b*100 + i];
      
      for(x = (int)random(100),y = (int)random(100),z = (int)random(100)
          ;i==x || x==y || y==z || i==y || x==z || i==z ;){
        x = (int)random(100);
        y = (int)random(100);
        z = (int)random(100);
      }
      
      ans1[i] = jpn[clicked_b*100 + x];
      ans2[i] = jpn[clicked_b*100 + y];
      ans4[i] = jpn[clicked_b*100 + z];
      
    }
    if(correct == 4){
      ans4[i] = jpn[clicked_b*100 + i];
      
      for(x = (int)random(100),y = (int)random(100),z = (int)random(100)
          ;i==x || x==y || y==z || i==y || x==z || i==z ;){
        x = (int)random(100);
        y = (int)random(100);
        z = (int)random(100);
      }
      
      ans1[i] = jpn[clicked_b*100 + x];
      ans2[i] = jpn[clicked_b*100 + y];
      ans3[i] = jpn[clicked_b*100 + z];
    }
  }
  
  //丸ボタンの設置
  int count;
  for(count=0;count<20;count++){
    fill(#FFFFFF);
    ellipse(b_x[count],b_y[count],b_w[count],b_h[count]);
  }
  
  //丸ボタンの押し状態
  fill(#000000);
  ellipse(b_x[clicked_b],b_y[clicked_b],b_w[clicked_b],b_h[clicked_b]);
  
  text("　1  -  100", 224, 830);
  text("101  -  200", 220, 880);
  text("201  -  300", 220, 930);
  text("301  -  400", 220, 980);
  text("401  -  500", 220, 1030);
  text("501  -  600", 220, 1080);
  text("601  -  700", 220, 1130);
  text("701  -  800", 220, 1180);
  text("801  -  900", 220, 1230);
  text("901  -  1000", 220, 1280);
  text("1001  - 1100", 530, 830);
  text("1101  - 1200", 530, 880);
  text("1201  - 1300", 530, 930);
  text("1301  - 1400", 530, 980);
  text("1401  - 1500", 530, 1030);
  text("1501  - 1600", 530, 1080);
  text("1601  - 1700", 530, 1130);
  text("1701  - 1800", 530, 1180);
  text("1801  - 1900", 530, 1230);
  text("ランダム選択", 525, 1280);
  text("テスト開始", 370, 1402);
  
  stroke(#000000);
  strokeWeight(5);
  line(60,500,840,500);
  line(60,580,840,580);
}

void Window1(){
  
  fill(#FFFFFF); 
  rect(0,140, width, height);
  stroke(#FFFFFF);
  strokeWeight(15);
  line(100,70,width-100,70);
  stroke(#000000);
  line(100,70,107+7*qes_num,70);
  strokeWeight(120);
  line(120,920,width-120,920);
  line(120,1060,width-120,1060);
  line(120,1200,width-120,1200);
  line(120,1340,width-120,1340);
  stroke(#FFFFFF);
  strokeWeight(110);
  line(120,920,width-120,920);
  line(120,1060,width-120,1060);
  line(120,1200,width-120,1200);
  line(120,1340,width-120,1340);
  stroke(#000000);
  strokeWeight(5);
  
  ellipse(width/2,500,600,600);
  c++;
  fill(#6090ef);
  arc(width/2,500,600,600,-PI/2,-PI/2 + 2*PI*c/600);
  fill(#FFFFFF);
  ellipse(width/2,500,450,450);
 
  fill(#000000);
  text(qes_num, width-50, 80);
  
  textSize(60);
  textAlign(CENTER,CENTER);
  text(eng[clicked_b*100 + qes_num], width/2 , 490);
  textAlign( LEFT, BASELINE ); 
  textSize(30);
  text(ans1[qes_num], 140, 930);
  text(ans2[qes_num], 140, 1070);
  text(ans3[qes_num], 140, 1210);
  text(ans4[qes_num], 140, 1350);
  
  if(flg_correct == 1){
    fill(#6090ef);
    ellipse(width/2,500,600,600);
    fill(#FFFFFF);
    ellipse(width/2,500,450,450);
    
    stroke(#fa8072);
    strokeWeight(110);
    line(120,780+clicked_num*140,width-120,780+clicked_num*140);
    stroke(#f0e68c);
    line(120,780+correct_num[qes_num]*140,width-120,780+correct_num[qes_num]*140);
    stroke(#000000);
    strokeWeight(5);
    
    fill(#000000);
    textSize(60);
    textAlign(CENTER,CENTER);
    text(eng[clicked_b*100 + qes_num], width/2, 490);
    textAlign( LEFT, BASELINE ); 
    textSize(30);
    text(ans1[qes_num], 140, 930);
    text(ans2[qes_num], 140, 1070);
    text(ans3[qes_num], 140, 1210);
    text(ans4[qes_num], 140, 1350);
    text("NEXT➡", width-180, 830);
    textSize(60);
    text("○", width-155, 800+correct_num[qes_num]*140);
    textSize(32);
    fill(#FFFFFF);
    
    if(flg_next == 1){
      flg_correct = 0;
      flg_next = 0;
      score++;
      qes_num++;
      count = 0;
      c = 0;
    }
  }
  
  if(flg_notcorrect == 1 || c >= 600){
    
    fill(#FFFFFF);
    ellipse(width/2,500,600,600);
    fill(#FFFFFF);
    ellipse(width/2,500,450,450);
    
    stroke(#fa8072);
    strokeWeight(110);
    if(flg_notcorrect == 1){
      line(120,780+clicked_num*140,width-120,780+clicked_num*140);
    }
    stroke(#f0e68c);
    line(120,780+correct_num[qes_num]*140,width-120,780+correct_num[qes_num]*140);
    stroke(#000000);
    strokeWeight(5);
    
    fill(#000000);
    textSize(60);
    textAlign(CENTER,CENTER);
    text(eng[clicked_b*100 + qes_num], width/2, 490);
    textAlign( LEFT, BASELINE ); 
    textSize(30);
    text(ans1[qes_num], 140, 930);
    text(ans2[qes_num], 140, 1070);
    text(ans3[qes_num], 140, 1210);
    text(ans4[qes_num], 140, 1350);
    text("NEXT➡", width-180, 830);
    textSize(100);
    if(flg_notcorrect == 1){
      text("×", width-155, 813+clicked_num*140);
    }
    textSize(60);
    text("○", width-155, 800+correct_num[qes_num]*140);
    textSize(32);
    fill(#FFFFFF);
    
    if(flg_next == 1){
      flg_notcorrect = 0;
      flg_next = 0;
      qes_num++;
      count = 0;
      c = 0;
    }
  }
  if(qes_num == 100){
    flg++;
  }
}

void Window2(){
  fill(#FFFFFF); 
  rect(0,140, width, height);
  ellipse(width/2,500,600,600);
  
  fill(#FFFFFF); 
  textSize(80);
  text("total score", width/2-180, 95);
  
  c++;
  fill(#6090ef);
  if(10*c<=12*score){
    arc(width/2,500,600,600,-PI/2,-PI/2 + 2*PI*c/120);
    fill(#FFFFFF); 
    ellipse(width/2,500,450,450);
  }
  else{
    arc(width/2,500,600,600,-PI/2,-PI/2 + 2*PI*score/100);
    fill(#FFFFFF); 
    ellipse(width/2,500,450,450);
    fill(#0066FF); 
    textSize(200);
    if(score<=9){
      text(score, width/2-55, 568);
    }
    if(score<=99 && score>=10){
      text(score, width/2-110, 568);
    }
    if(score == 100){
      text(score, width/2-172, 568);
    }
    
    if(score <= 20){
      image(dog_20,70,500);
      fill(#000000); 
      textSize(40);
      text("うーん...", width/2-230, 950);
      textSize(30);
      text("基礎からしっかり学習しましょう", width/2-225, 1110);
      textSize(60);
      text("もっと頑張ろう", width/2-212, 1030);
      flg_end = 1;
    }
    else if(score <= 40){
      image(dog_40,70,580);
      fill(#000000); 
      textSize(40);
      text("さあ、", width/2-235, 950);
      textSize(30);
      text("半分以上を目指してファイト", width/2-205, 1110);
      textSize(60);
      text("まだまだこれから", width/2-237, 1030);
      flg_end = 1;
    }
    else if(score <= 60){
      image(dog_60,80,500);
      fill(#000000); 
      textSize(40);
      text("うむ。", width/2-230, 950);
      textSize(30);
      text("８割までの道は遠いぞ！", width/2-165, 1110);
      textSize(60);
      text("まずまずの成果", width/2-212, 1030);
      flg_end = 1;
    }
    else if(score <= 80){
      image(dog_80,470,550);
      fill(#000000); 
      textSize(40);
      text("よし！", width/2-230, 950);
      textSize(30);
      text("８割までの道はもう少し！", width/2-180, 1110);
      textSize(60);
      text("良く頑張ったね", width/2-210, 1030);
      flg_end = 1;
    }
    else if(score <= 100){
      image(dog_100,450,530);
      fill(#000000); 
      textSize(40);
      text("素晴らしい！", width/2-280, 950);
      textSize(30);
      text("常に１００％を目指していこう", width/2-225, 1110);
      textSize(60);
      text("君の努力の賜物だね", width/2-270, 1030);
      flg_end = 1;
    }
    
    if(flg_end == 1){
      fill(#6090ef); 
      rect(200,1170,500,130);
      fill(#FFFFFF); 
      textSize(40);
      text("ホームへ戻る", width/2-125, 1247);
    }
  }
}

void keyPressed(){
  if(screen_no == 1){
    if(keyCode == RIGHT){
      flg_next = 1;
    }
  }
}
void mousePressed(){
  //丸ボタンのクリック判定
  if(screen_no == 0){
    for(int i=0; i<b_x.length; i++){
      if(mouseX>b_x[i]-b_w[i] && mouseX<b_x[i]+b_w[i] && mouseY>b_y[i]-b_h[i] && mouseY<b_y[i]+b_h[i]){
        if(i == 19){
          clicked_b = (int)random(19);
        }
        else{
          clicked_b = i;
        }
      }
    }
    //テスト開始ボタンのクリック判定
    if(mouseX>280 && mouseX<620 && mouseY>1350 && mouseY<1430){
      clicked_s = 1;
    }
  }
  //選択肢のクリック判定
  if(screen_no == 1){
    for(int i=0; i<4; i++){
      if(mouseX>60 && mouseX<width-60 && mouseY>860 && mouseY<980){
        if(correct_num[qes_num] == 1 && count == 0){
          flg_correct = 1;
          flg_notcorrect = 0;
          clicked_num = 1;
          count = 1;
        }
        else if(count == 0){
          flg_correct = 0;
          flg_notcorrect = 1;
          clicked_num = 1;
          count = 1;
        }
      }
      if(mouseX>60 && mouseX<width-60 && mouseY>1000 && mouseY<1120){
        if(correct_num[qes_num] == 2 && count == 0){
          flg_correct = 1;
          flg_notcorrect = 0;
          clicked_num = 2;
          count = 1;
        }
        else if(count == 0){
          flg_correct = 0;
          flg_notcorrect = 1;
          clicked_num = 2;
          count = 1;
        }
      }
      if(mouseX>60 && mouseX<width-60 && mouseY>1140 && mouseY<1260){
        if(correct_num[qes_num] == 3 && count == 0){
          flg_correct = 1;
          flg_notcorrect = 0;
          clicked_num = 3;
          count = 1;
        }
        else if(count == 0){
          flg_correct = 0;
          flg_notcorrect = 1;
          clicked_num = 3;
          count = 1;
        }
      }
      if(mouseX>60 && mouseX<width-60 && mouseY>1280 && mouseY<1400){
        if(correct_num[qes_num] == 4 && count == 0){
          flg_correct = 1;
          flg_notcorrect = 0;
          clicked_num = 4;
          count = 1;
        }
        else if(count == 0){
          flg_correct = 0;
          flg_notcorrect = 1;
          clicked_num = 4;
          count = 1;
        }
      }
    }
    
    if(mouseX>width-200 && mouseX<width-70 && mouseY>790 && mouseY<840){
      if(flg_correct == 1 || flg_notcorrect == 1 || c>=600){
        flg_next = 1;
      }
    } 
  }
  if(screen_no == 2){
    if(mouseX>200 && mouseX<700 && mouseY>1170 && mouseY<1300){
        if(flg_end == 1){
          flg = 1;
        }
    } 
  }
}
