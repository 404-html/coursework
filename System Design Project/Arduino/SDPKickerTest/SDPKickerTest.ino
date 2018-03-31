#include "SDPArduino.h"
#include <Wire.h>
int i = 0;

void setup(){
  SDPsetup();
  helloWorld();
}

void loop(){
  
motorBackward(2, 100); 
motorBackward(3, 100); 
motorBackward(4, 100); 
motorBackward(5, 100);                                        
delay(500);  
motorStop(2);
motorStop(3);
motorStop(4);
motorStop(5);                                      
delay(500); 
motorForward(2, 100); 
motorForward(3, 100); 
motorForward(4, 100); 
motorForward(5, 100);                                        
delay(500);  
motorStop(2);
motorStop(3);
motorStop(4);
motorStop(5);                                      
delay(500); 

motorBackward(3, 100); 
motorForward(4, 100);                                      
delay(500); 
motorStop(3);
motorStop(4);                                   
delay(500); 
motorBackward(4, 100); 
motorForward(3, 100);                                      
delay(500); 
motorStop(3);
motorStop(4);                                   
delay(500); 

motorBackward(2, 100); 
motorForward(5, 100);                                      
delay(500); 
motorStop(2);
motorStop(5);                                   
delay(500); 
motorBackward(5, 100); 
motorForward(2, 100);                                      
delay(500); 
motorStop(2);
motorStop(5);                                   
delay(500); 
  
Serial.println("Motor 0 Backwards 500%");
motorBackward(0, 100);                                       
delay(500);  
motorStop(0);                                   
delay(500);  
Serial.println("Motor 0 Forward 500%");
motorForward(0, 100);
delay(500); 
Serial.println("Motor 0 Stop");
motorStop(0);
delay(10000);
}
