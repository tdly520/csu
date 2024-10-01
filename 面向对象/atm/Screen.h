#ifndef SCREEN_H
#define SCREEN_H
#include <string>
using namespace std;
class Screen
{
public:
 void displayMessage(string) const; 
 void displayMessageLine(string) const; 
 void displayAmount(double) const; 
}; 
#endif 