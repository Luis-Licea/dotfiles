#include <cassert>
#include <iostream>
#include <vector>
using namespace std;
template <typename... T> void p(T... args) {
  ((cout << " " << args), ...) << endl;
}
void test() {}
int main() {
  test();
  return 0;
}
