#!/usr/bin/python3
from subprocess import call
from argparse import ArgumentParser
from re import search
from dataclasses import dataclass
from math import inf
from os import mkdir, path


@dataclass
class Song:
    title: str
    number: int
    minutes: int
    seconds: int
    end: float = inf

    @property
    def start(self) -> int:
        return self.seconds + self.minutes * 60

    @start.setter
    def start(self, value: int):
        self.seconds = value % 60
        self.minutes = value // 60


def parse_track_list(lines) -> list[Song]:
    songs: list[Song] = []
    for line in lines:
        if line.startswith("#") or len(line) == 0:
            continue

        # TrackNumber.[Minutes:Seconds] Title:
        # 01.[00:00] Example
        match = search(r"(\d+)\.\[(\d+):(\d+)\] (.+)$", line)
        if match:
            number, minutes, seconds, title = match.groups()
            song = Song(title, int(number), int(minutes), int(seconds))
            songs.append(song)
        else:
            raise Exception(f"No match for line: {line}")

    for next, song in enumerate(songs, 1):

        if next >= 0 and next < len(songs):
            song.end = songs[next].start
    return songs


def split(album: str, track_list: str, artist: str, dry_run: bool):
    """split a music track into specified sub-tracks by calling ffmpeg from the shell"""
    for file in [album, track_list]:
        if not path.isfile(file):
            raise Exception(f"File {file} is not a file.")

    with open(track_list) as track_list_file:
        lines = map(lambda line: line.rstrip(), track_list_file.readlines())

    songs = parse_track_list(lines)

    if not path.exists(artist):
        mkdir(artist)

    #  The ffmpeg call.
    song_command = "ffmpeg -i '{album}' -acodec libopus -ss {start} -to {end} '{artist}/{artist} - {number:02d} - {title}.opus'"
    last_command = "ffmpeg -i '{album}' -acodec libopus -ss {start} '{artist}/{artist} - {number:02d} - {title}.opus'"

    for song in songs:
        if song.end != inf:
            command = song_command.format(
                album=album,
                start=song.start,
                end=song.end,
                number=song.number,
                title=song.title,
                artist=artist,
            )
        else:
            command = last_command.format(
                album=album,
                start=song.start,
                number=song.number,
                title=song.title,
                artist=artist,
            )
        if dry_run:
            print(command)
        else:
            call(command, shell=True)


def parse_arguments():
    parser = ArgumentParser(description="Split albums into songs.")
    parser.add_argument("artist", help="The artist name")
    parser.add_argument("album", help="The path to the album (a music file).")
    parser.add_argument("track_list", help="The path to the track list (a text file).")
    parser.add_argument(
        "-d", "--dry-run", help="Show what would happen", action="store_true"
    )
    args = parser.parse_args()
    return args


def main():
    args = parse_arguments()
    args_dictonary = vars(args).copy()
    split(**args_dictonary)


if __name__ == "__main__":
    main()
