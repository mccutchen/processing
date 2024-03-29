int WIDTH = 1400;
int HEIGHT = 700;

int COLOR_DELTA = 4;
int COLOR_MIN = 0;
int COLOR_MAX = 255;

int STROKE_DELTA = 3;
int STROKE_MIN = 10;
int STROKE_MAX = 75;

int TARGET_DELTA = 15;

int currentHour = hour();

int numPainters = 1;
Painter[] painters = new Painter[numPainters];

void setup() {
    size(WIDTH, HEIGHT);
    background(color(255,255,255));
    smooth();
    
    for (int i = 0; i < numPainters; i++) {
        painters[i] = new CurvePainter(new ColorStream());
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
