#!/usr/bin/env node
import { execSync } from "node:child_process";
import { existsSync, writeFileSync, readFileSync } from "node:fs";
import { basename } from "node:path";

/**
 * @param {string} command The command to execute.
 * @returns {string} The command output.
 */
function exec(command) {
    return execSync(command, { encoding: "utf8", shell: true });
}

/**
 * @returns {string} The current Hyprland keyboard layout, like us, latam, ru, etc.
 */
function getLayout() {
    return JSON.parse(exec("hyprctl getoption input:kb_layout -j")).str
}

/**
 * @param {string} layout The keyboard layout to switch to, such as us, latam, ru, etc.
 * @param {?number} notificationId The notification ID used to replace a notification.
 * @returns {number} The notification ID, which can be used to replace the notification.
 */
function setLayout(layout, notificationId) {
    const command = notificationId
        ? `notify-send --expire-time 1500 --print-id --replace-id ${notificationId} ${layout}`
        : `notify-send --expire-time 1500 --print-id ${layout}`;
    const id = parseInt(exec(command));
    exec(`hyprctl keyword input:kb_layout ${layout}`);
    return id;
}

/**
 * @param {{layout: string, date: Date}} now The current keyboard layout, and the date when it was set.
 * @param {{layout: string, date: Date}} last The last keyboard layout, and the date when it was set.
 * @param {string[]} layouts The available keyboard layouts.
 */
function switchLayout(now, last, layouts) {
    if (layouts.length <= 1) {
        return;
    }
    if (now.date - last.date > 1_500 && last.layout !== now.layout) {
        return setLayout(last.layout, last.id)
    }
    const next = (layouts.findIndex(layout => layout === now.layout) + 1) % layouts.length;
    return setLayout(layouts[next], last.id)

}

const cacheFile = `/tmp/${basename(import.meta.filename)}.cache.json`;
const now = { layout: getLayout(), date: new Date() };
const layouts = [
    "us",
    "latam",
    "ru",
]
const last = existsSync(cacheFile)
    ? JSON.parse(readFileSync(cacheFile), (key, value) => (key === "date" ? new Date(value) : value))
    : now;

now.id = switchLayout(now, last, layouts);

writeFileSync(cacheFile, JSON.stringify(now));
