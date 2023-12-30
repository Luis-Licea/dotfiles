#!/usr/bin/env nix-shell
#! nix-shell -i bash -p tinycc

cat << /*end*/ | tcc -run -
#include <stdio.h>
int main() {
  printf("Hello, world!");
  return 0;
}
/*end*/
