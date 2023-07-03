void setup()
{
  pinMode(9,OUTPUT);
  TCCR1A = 0;
  TCCR1B = 0;
  TCCR1A |= (1<<WGM11) | (1<<COM1A1) | (1<<COM1B1);
  TCCR1B |= (1<<CS10) | (1<<WGM12) | (1<<WGM13);
  ICR1 = 64;
  OCR1A = 32;
}
void loop(){

}