#!/usr/bin/env cached-nix-shell
/*
#!nix-shell --pure -p wireplumber nodejs -i node
*/

/**
 * Scan the output of wpctl and switch the audio source to first sink that is
 * inactive. This works great if there are two sinks since one of them will be
 * inactive.
 */

import { execSync } from "node:child_process";
const status = execSync("wpctl status", { encoding: "utf8" });
const sinkIndex = status.indexOf("Sinks:");
const sourceIndex = status.indexOf("Sources:", sinkIndex);
const sinks = status
    .slice(sinkIndex, sourceIndex)
    .split("\n")
    .slice(1, -1)
    .map((line) => line.slice(4))
    .filter(Boolean);

for (const sink of sinks) {
    const match = sink.match(/(\*)? +(\d+)\. (.*)/);
    const [_, active = null, sinkNumber, name] = match;

    if (!active) {
        execSync(`wpctl set-default ${sinkNumber}`, { encoding: "utf8" });
    }
}
