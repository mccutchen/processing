int WIDTH = 4000;
int HEIGHT = 2000;

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
