const int OutPin=5;         // 'D3' port

void setup() 
{
    pinMode(OutPin,OUTPUT);
}
void loop()
{
  digitalWrite(OutPin,HIGH);
  delay(1);
  digitalWrite(OutPin,LOW);
  delay(1);
}