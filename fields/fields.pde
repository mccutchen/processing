int cols = 10;
int rows = 10;

float[] circles = new float[cols * rows];

int fieldWidth;
int fieldHeight;

int offsetX;
int offsetY;

float t = 0f;
float tdelta = 0.01;

void setup() {
    size(500, 500);
    background(255, 255, 255);
    fill(53, 53, 53);
    noStroke();
    
    fieldWidth = width / cols;
    fieldHeight = height / rows;
    offsetX = fieldWidth / 2;
    offsetY = fieldHeight / 2;
    
    for (int i = 0; i < circles.length; i++) {
        circles[i] = float(i);
    }
    print(circles);
}

void draw()  {
    t += tdelta;
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            int x = i * fieldWidth + offsetX;
            int y = j * fieldHeight + offsetY;
            float n = noise(x + t, y + t);
            float g = n * 255;
            fill(g, g, g);
            ellipse(x, y, fieldWidth, fieldHeight);
        }
    }
}
