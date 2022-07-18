// <Mistake, oversight, and compilation error list>
#include <algorithm>
#include <cassert>
#include <iostream>
#include <vector>
using namespace std;

// <Problem statement>

// Time Required: <0h 0min>

// <Strategy summary>
template <typename... T> void p(T... args) {
  ((cout << " " << args), ...) << endl;
}
void test() {}
int main() {
  test();
  return 0;
}
