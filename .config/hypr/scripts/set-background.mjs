#!/usr/bin/env cached-nix-shell
/*
#!nix-shell -p swww swaybg nodejs
#!nix-shell -i node
*/

/**
 * Select a file randomly from the given directory and set it as the background
 * image.
 */
import { readdir } from "node:fs/promises";
import { existsSync } from "node:fs";
import { homedir } from "node:os";
import { exec, spawnSync, execFile } from "node:child_process";
import { promisify } from "node:util";
import { join } from "node:path";
import { env } from "node:process";
const execute = promisify(exec);
const options = {
    encoding: "utf8",
    shell: true,
    detached: true,
    stdio: "ignore",
};

/**
 * Return a randomly selected element from the list.
 * @template T Any data type.
 * @param {T[]} choices The list of choices.
 * @returns {T} The list element.
 */
function choice(choices) {
    const index = Math.floor(Math.random() * choices.length);
    return choices[index];
}

/**
 * Return the list of images found in the given directory.
 *
 * @param {string} directory The folder containing the background images.
 * @returns {Promise<string[]>} A list of full paths to each background image.
 */
async function getImages(directory) {
    const files = await readdir(directory, { withFileTypes: true });
    const filesToIgnore = /.git|readme.md/i;
    const images = files.filter(
        (file) => !file.isDirectory() && !file.name.match(filesToIgnore),
    );
    return images.map((image) => join(image.path, image.name));
}

/**
 * Chose a random image from the images in the given directory and set it as the
 * background. A solid color will be set if no image is provided is found or if
 * the directory does not exist.
 *
 * @param {string} directory The path to the folder with background images.
 */
async function setBackground(directory) {
    const images = await getImages(directory).catch(() => []);
    const randomImage = choice(images);
    if (!randomImage) {
        await execute("pkill swaybg").catch(() => {});
        spawnSync('setsid --fork swaybg --color "#355C7D"', options);
    } else {
        let swwwSocket = `${env.XDG_RUNTIME_DIR}/sww-${env.WAYLAND_DISPLAY}.socket`;
        if (!existsSync(swwwSocket)) {
            spawnSync("setsid --fork swww-daemon", options);
        }
        execFile("swww", ["img", randomImage], { ...options, shell: false });
    }
}

async function main() {
    const directory =
        process.argv[2]?.replace("~", homedir()) ||
        `${homedir()}/Pictures/Wallpaper/Gradient/`;
    await setBackground(directory);
}

await main();
