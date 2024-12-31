#!/usr/bin/env cached-nix-shell
/*
#! nix-shell -i bun -p bun -p zathura -p fzf
*/

import { Database } from "bun:sqlite";
import { spawnSync } from "node:child_process";
import { join } from "node:path";

const library = `${process.env.HOME}/Documents/Calibre Library`;
const db = new Database(`${library}/metadata.db`);
const query = db.query(`select books.title, books.path || '/' || data.name || '.' || lower(data.format) as path from books inner join data where books.id = data.book`);
const books = query.all();
const pathByTitle = Object.fromEntries(books.map(book => [book.title, book.path]));
const titles = books.map(book => book.title).join("\n")
// const selectedTitle = spawnSync("fzf", { stdio: ['pipe', 'pipe', 'inherit'], input: titles, encoding: "utf8" }).stdout.slice(0, -1);
const selectedTitle = spawnSync("rofi", ["-dmenu", "-i", "-p", "title:", "-theme-str", 'window {width: 50%;}'], { stdio: ['pipe', 'pipe', 'inherit'], input: titles, encoding: "utf8" }).stdout.slice(0, -1);
const bookPath = pathByTitle[selectedTitle];
if (bookPath) {
    spawnSync("zathura", [join(library, bookPath)])
}
