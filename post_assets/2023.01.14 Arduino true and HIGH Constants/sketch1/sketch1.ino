int a_int = 1;
int a_nint = -1;
double a_double = 2.2;
int a_high = HIGH;
bool a_bool = true;

void setup() {
  Serial.begin(9600);
}

void loop() {
  Serial.print("a_int is ");Serial.println(a_int);
  Serial.print("a_nint is ");Serial.println(a_nint);
  Serial.print("a_double is ");Serial.println(a_double);
  Serial.print("a_high is ");Serial.println(a_high);
  Serial.print("a_bool is ");Serial.println(a_bool);
  Serial.print("\n");

  Serial.print("a_int==a_bool?");Serial.println(a_int==a_bool);
  Serial.print("a_nint==a_bool?");Serial.println(a_nint==a_bool);
  Serial.print("a_double==a_bool?");Serial.println(a_double==a_bool);
  Serial.print("a_high==a_bool?");Serial.println(a_high==a_bool);
  Serial.print("a_high==a_int?");Serial.println(a_high==a_int);
  Serial.print("\n");
  
  Serial.println((a_int==a_bool)+(a_nint==a_bool)+
  (a_double==a_bool)+(a_high==a_bool)+(a_high==a_int));
  Serial.print("\n");

  if (a_int) {Serial.print("(1)If_int;");}
  if (a_nint) {Serial.print("(2)If_nint;");}
  if (a_double) {Serial.print("(3)If_double;");}
  if (a_high) {Serial.print("(4)If_high;");}
  if (a_bool) {Serial.print("(5)If_bool;");}

  while (true) {};
}
