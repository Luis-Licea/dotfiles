#!/usr/bin/env nix-shell
//! ```cargo
//! [dependencies]
//! serde_json = "1.0"
//! serde = { version = "1.0.104", features = ["derive"] }
//! ```
/*
#! nix-shell -i rust-script -p rustc -p rust-script -p cargo
*/
use std::io::{BufReader, BufRead};
use std::os::unix::net::UnixStream;
use std::env::var;
use std::process::Command;
use serde::Deserialize;
use serde_json::Result;
use serde::de;

#[derive(Debug, Deserialize)]
struct ActiveWindow {
    #[serde(rename(deserialize = "fullscreen"))]
    is_fullscreen: bool,
    #[serde(rename(deserialize = "fullscreenMode"))]
    fullscreen_mode: u8,
}

#[derive(Debug, Deserialize)]
struct ActiveWorkspace {
    #[serde(rename(deserialize = "hasfullscreen"))]
    is_fullscreen: bool,
}

/**
 * Query the active window or workspace and return the state as a JSON string.
 */
fn hyprctl(command: &str) -> String {
    return String::from_utf8(Command::new("hyprctl").args(["-j", command]).output().unwrap().stdout).unwrap();
}

/**
 * Query the active window or workspace and return the state as an object.
 */
fn parse<T>(command: &str) -> Result<T>
where T: for<'a> de::Deserialize<'a>
{
    let json_string: String = hyprctl(command);
    return serde_json::from_str::<T>(&json_string);
}

/**
 * The full-screen mode will be turned off when a window is closed. Restore full-screen mode if
 * necessary.
 */
fn main() -> std::io::Result<()> {
    // Connect to the Hyprland socket and listen for full-screen and close-window events.
    let socket_path = format!("{}/hypr/{}/.socket2.sock", var("XDG_RUNTIME_DIR").unwrap(), var("HYPRLAND_INSTANCE_SIGNATURE").unwrap());
    let socket = UnixStream::connect(socket_path)?;
    let mut stream = BufReader::new(socket);

    // Store whether the current window is full-screen.
    let mut active_window: ActiveWindow = parse("activewindow")?;
    // let active_workspace = info("activeworkspace")?; // ERROR

    // Process each line read from the Hyprland socket.
    loop {
        let mut line = String::new();
        stream.read_line(&mut line)?;
        let action = line.split(">").next();
        match action {
            Some("fullscreen") | Some("workspace") => {
                // Store whether the current window is full-screen.
                active_window = parse("activewindow")?;
            },
            Some("closewindow") =>  {
                let active_workspace: ActiveWorkspace = parse("activeworkspace")?;
                // Restore full-screen if necessary after closing a window.
                if active_window.is_fullscreen && !active_workspace.is_fullscreen {
                    let _ = Command::new("hyprctl").args(["dispatch", "fullscreen", &active_window.fullscreen_mode.to_string()]).output();
                }
            },
            // Ignore other Hyprland events.
            Some(_) => {},
            // Ignore lines that are not events. These types of lines should never happen.
            None => println!("Could not handle action: {}", line),
        }
    }
}

