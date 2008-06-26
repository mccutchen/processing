int WIDTH = 1500;
int HEIGHT = 1000;

int COLOR_DELTA = 3;
int COLOR_MIN = 0;
int COLOR_MAX = 255;

int STROKE_DELTA = 2;
int STROKE_MIN = 20;
int STROKE_MAX = 100;

int TARGET_DELTA = 25;

int currentHour = hour();

int numPainters = 3;
Painter[] painters = new Painter[numPainters];

void setup() {
    size(WIDTH, HEIGHT);
    background(color(255,255,255));    
    for (int i = 0; i < numPainters; i++) {
        painters[i] = new CurvePainter();
    }
}

void keyPressed() {
    if(key == ' ') {
        print("Saving...");
        save();
    }
}

void draw()  {
    for (int i = 0; i < numPainters; i++) {
        painters[i].update();
        painters[i].paint();
    }
    maybeSave();
}

void maybeSave() {
    int h = hour();
    if (h != currentHour) {
        currentHour = h;
        save();
    }
}
