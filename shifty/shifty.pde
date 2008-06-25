int WIDTH = 800;
int HEIGHT = 400;
int DELTA = 3;

color base = color(rand(0,255), rand(0,255), rand(0,255));
color current = fudge(base);

void setup() {
    size(WIDTH, HEIGHT);
    background(fudge(base));
    for (int i = 0; i < WIDTH; i++) {
        stroke(current);
        line(i, 0, i, HEIGHT);
        current = fudge(current);
    }
}

void draw()  {
    loadPixels();
    color c = fudge(pixels[0]);
    stroke(c);
    line(0,0,0,HEIGHT);
    for (int i = 0; i < WIDTH - 1; i++) {
        stroke(pixels[i]);
        line(i+1,0,i+1,HEIGHT);
    }
}

color fudge(color c) {    
    return color(
        wrap((c >> 16 & 0xFF) + rand(0-DELTA, DELTA)),
        wrap((c >> 8 & 0xFF) + rand(0-DELTA, DELTA)),
        wrap((c >> 0 & 0xFF) + rand(0-DELTA, DELTA))
    );
}

int wrap(float n) {
    return int((n >= 0 && n <= 255) ? n : (n < 0) ? 255 + n : n - 255);
}

int rand(int lo, int hi) {
    return int(random(lo,hi));
}
