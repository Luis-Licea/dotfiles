#!/usr/bin/env node
import { execSync } from "node:child_process";
import { existsSync, writeFileSync, readFileSync } from "node:fs";
import { basename } from "node:path";
import { parseArgs } from "node:util";

const { noNotification } = parseArgs({ options: { noNotification: { type: 'boolean' } } }).values;
const myLayouts = ["us", "latam", "ru", "de"];
const timeTreshhold = 2_000;

/**
 * @param {string} command The command to execute.
 * @returns {string} The command output.
 */
function exec(command) {
    return execSync(command, { encoding: "utf8", shell: true });
}

// /**
//  * @returns {string} The current Hyprland keyboard layout, like us, latam, ru, etc.
//  */
// function getLayout() {
//     return JSON.parse(exec("hyprctl getoption input:kb_layout -j")).str
// }

/**
 * @param {string} layout The keyboard layout to switch to, such as us, latam, ru, etc.
 * @param {number} notificationId The notification ID used to replace a notification.
 * @returns {number} The notification ID, which can be used to replace the notification.
 */
function setLayout(layout, notificationId) {
    exec(`hyprctl keyword input:kb_layout ${layout}`);
    if (noNotification) {
        return 0;
    }
    const command = notificationId
        ? `notify-send --expire-time ${timeTreshhold} --print-id --replace-id ${notificationId} ${layout}`
        : `notify-send --expire-time ${timeTreshhold} --print-id ${layout}`;
    const id = parseInt(exec(command));
    return id;
}

/**
 * @param {Cache} cache The cache holds the state required to switch
 * between layouts. It does not provide any logic.
 */
function switchLayout(cache) {
    if (cache.layouts.length <= 1) {
        return;
    }
    const switchTime = new Date();
    cache.difference = switchTime - new Date(cache.lastSwitchTime);
    cache.lastSwitchTime = switchTime;
    let layout;
    if (cache.difference >= timeTreshhold) {
        const lastLayoutIndex = cache.lastLayoutIndex % cache.layouts.length;
        cache.lastLayoutIndex = 1;
        layout = cache.layouts.splice(lastLayoutIndex, 1).pop();
    } else {
        cache.lastLayoutIndex++;
        layout = cache.layouts.pop()
    }
    cache.layouts.unshift(layout);
    cache.notificationId = setLayout(layout, cache.notificationId)

}

class Cache {
    static path = `/tmp/${basename(import.meta.filename)}.cache.json`;
    constructor({ notificationId, difference, lastSwitchTime, lastLayoutIndex, layouts } = {
        notificationId: 0,
        difference: timeTreshhold,
        lastSwitchTime: new Date(Date.now() - timeTreshhold),
        lastLayoutIndex: 1,
        layouts: []
    }) {
        this.notificationId = notificationId;
        this.lastLayoutIndex = lastLayoutIndex;
        this.difference = difference;
        this.lastSwitchTime = lastSwitchTime;
        this.layouts = myLayouts.every(myLayout => layouts.includes(myLayout)) ? layouts : myLayouts;
    }

    static load() {
        return existsSync(Cache.path)
            ? new Cache(JSON.parse(readFileSync(Cache.path)))
            : new Cache();
    }

    save() {
        writeFileSync(Cache.path, JSON.stringify(this, null, 4));
    }
}

const cache = Cache.load();

switchLayout(cache)
cache.save()
