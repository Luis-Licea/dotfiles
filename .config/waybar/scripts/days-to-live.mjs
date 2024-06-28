#!/usr/bin/env cached-nix-shell
/*
#!nix-shell --pure -p nodejs -i node
*/
const date1 = new Date();
const date2 = new Date("01/01/2070");

const timeDifference = date2.getTime() - date1.getTime();
const dayDifference = Math.round(timeDifference / (1000 * 3600 * 24));
console.log(dayDifference)
