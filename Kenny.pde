//na początku importuję bibliotekę odpowiedzialną za odtwarzanie muzyki

import ddf.minim.*; 
AudioPlayer player;
Minim minim;

//ustalam z czego będę korzystała w programie

PImage kenny, woda, GO, kolo, skull; 
PFont font;
int promien_wroga;
int promien_pilki;
int wynik;
boolean w_grze;
Kulki [] wrogowie; // robię arraylist kulkowy (z klasy Kulki)
Kulki zielona_kulka;
 
//ustalam co bedzie sie dzialo na wstepie
 
void setup()
{
  noStroke();
  ellipseMode(RADIUS); // tryb rysowania elipsy wg promienia(radius), a nie (corner)
  size(800, 582);
  kenny = loadImage("kenny.png"); // laduje obrazki
  woda = loadImage("woda.png");
  GO = loadImage("GO.jpg");
  kolo = loadImage("kolo.png");
  skull = loadImage("skull.png");
  imageMode(CENTER); //ustawienie obrazka na środku
  font = loadFont("DFWaWaTC-W5-48.vlw"); // wczytuje font
  textFont(font, 32);
  wynik = 0; 
  w_grze = true; 
  zielona_kulka = generuj_kulki();
  wrogowie = new Kulki[100]; // będzie max 100 wrogich kulek
  wrogowie[0] = generuj_kulki(); 
  frameRate(60);
  noCursor(); // chce zeby nie bylo widac kursora
  minim =new Minim(this); // dodaje muzyke w tle
 player = minim.loadFile("mjuzik.mp3", 2048);
 player.loop();
}
 
// rozpisuje petle dzialania draw
 
void draw()
{
  if (w_grze) {
    background(woda);
    textSize(30);
    fill(255,255,255);
    text("Wynik " + wynik, 30, 50); // wypisuje wynik
    promien_pilki = (int) map(mouseX, 0, width, 20, 35); // promien pilki, na ktorej wyswietlany jest Kenny zwieksza sie wraz z wielkoscia X (od lewej do prawej)
    fill(0);
    ellipse(mouseX, mouseY, promien_pilki, promien_pilki);
    promien_wroga = (int) map(mouseX, 0, width, 40, 20); // promien wrogow zmniejsza sie wraz ze wzrostem X kulki pod Kennym
    
    fill(50, 150, 250); // rysuje i updateuje zielona kulke
    ellipse(zielona_kulka.x, zielona_kulka.y, promien_wroga, promien_wroga);
    zielona_kulka.update();
    image(kolo,zielona_kulka.x, zielona_kulka.y);
    
    fill(0, 0, 255); // rysuje i updateuje wrogie kulki
    for (int i = 0; i < wynik + 1; i++) { // po kazdym jednym punkcie o jednego wroga wiecej
      wrogowie[i].update();
      ellipse(wrogowie[i].x, wrogowie[i].y, promien_wroga, promien_wroga); //rysuje elipse jako kolejnego wroga
      image(skull,wrogowie[i].x, wrogowie[i].y);

      /* sprawdzam teraz kolizje poprzez sprawdzenie czy odległość między polozeniem kursora
      a polozeniem centrum wrogow jest mniejsze od od 0.9 sumy promieni obu kulek - jeśli jest mniejsza
      wtedy wypadamy z gry*/

      if (dist(mouseX, mouseY, wrogowie[i].x, wrogowie[i].y) < (promien_pilki + promien_wroga) * 0.8)
      {
        w_grze = false;
      }
    }
     
    /* jeśli dystans kennego (kursora) od centrum zielonej kulki jest mniejszy od sumy promieni 
    kulek - wynik zwieksza sie o 1, generowane sa nowi wrogowie i nowa zielona kulka*/
    
    if (dist(mouseX, mouseY, zielona_kulka.x, zielona_kulka.y) < promien_pilki + promien_wroga)
    {
      wynik++;
      wrogowie[wynik] = generuj_kulki();
      zielona_kulka = generuj_kulki();
    }
  }
  
  // teraz pisze co sie stanie, jesli wypadniemy z gry
  
  else
  {
    fill(0);
    background(GO);
    textSize(30);
    text("GAME OVER", 500, 100);
    text("Wynik: " + wynik, 525, 150);
    keyPressed();
  }
  
  image (kenny,mouseX,mouseY); // nakladam brazek glowy kennego na kulke
  
}

// teraz opis funkcji generowania kulek oparty na klasie Kulki
 
Kulki generuj_kulki()
{
  int x, y, vx, vy;
   
  do
  {
    x = (int) random(width);
    y = (int) random(height);
  } while (dist(mouseX, mouseY, x, y) < promien_pilki + promien_wroga + 150); // upewniam się, że nowa kulka jest daleko od kennego
  vx = (int) random(4);
  vy = (int) random(4);
  return new Kulki(x, y, vx, vy);
  
}
  
 
void mousePressed()
{
  player.close();
  setup();
}

void mouseMoved(){
  for(int b=0; b<5;b++) {
  image(kenny,mouseX,mouseY);
  }
}

void keyReleased() {
  if(key == ' ') {
  player.close();
  setup();
  }}

