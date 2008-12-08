int cols = 5;
int rows = 5;

float[] circles = new float[cols * rows];

int fieldWidth;
int fieldHeight;

int offsetX;
int offsetY;

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
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            int x = i * fieldWidth + offsetX;
            int y = j * fieldHeight + offsetY;
            ellipse(x, y, fieldWidth, fieldHeight);
        }
    }
}
