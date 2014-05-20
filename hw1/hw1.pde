FileImporter importer;

void setup() {
  importer = new FileImporter();
}

void draw() {
  text(importer.test(), 10, 10);
}
