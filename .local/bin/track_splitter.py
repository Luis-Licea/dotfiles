#!/usr/bin/python3
from argparse import ArgumentParser, RawDescriptionHelpFormatter
from dataclasses import dataclass
from math import inf
from os import mkdir, path
from re import search
from subprocess import call
from textwrap import dedent


@dataclass
class Song:
    title: str
    number: int
    seconds: int
    minutes: int
    hours: int = 0
    end: float = inf

    @property
    def start(self: "Song") -> int:
        """Return the starting time in seconds.
            self (Song): The song object.

        Returns:
            The starting time in seconds.
        """
        return self.seconds + self.minutes * 60 + self.hours * 3_600

    @start.setter
    def start(self, value: int):
        """Set the number of seconds, minutes, and hours from given value.
        self (Song): The song object.
        value (int): The song start in seconds.
        """
        self.seconds = value % 60
        self.minutes = value // 60
        self.minutes = value // 3_600


def parse_track_list(lines) -> list[Song]:
    songs: list[Song] = []

    patterns = [
        # 00:?00:00 Title
        r"((?P<hours>\d+):)?(?P<minutes>\d+):(?P<seconds>\d+) (?P<title>.+)$",
        # TrackNumber.[Minutes:Seconds] Title:
        # 01.[00:00] Example
        r"(?P<number>\d+)\.\[(?P<minutes>\d+):(?P<seconds>\d+)\] (?P<title>.+)$",
    ]

    pattern = patterns.pop()

    for line in lines:
        if line.startswith("#") or len(line) == 0:
            continue

        while not (match := search(pattern, line)):
            print(f"Pattern '{pattern}' did not work for line: {line}")
            try:
                pattern = patterns.pop()
            except IndexError:
                raise Exception(f"No match for line: {line}")

        print(match.groupdict())
        song_attributes: dict = match.groupdict()

        for attribute in ["number", "seconds", "minutes", "hours"]:
            if song_attributes.get(attribute):
                song_attributes[attribute] = int(song_attributes[attribute])
            elif attribute == "hours":
                song_attributes[attribute] = 0
            elif attribute == "number":
                song_attributes[attribute] = len(songs)

        for attribute in ["title"]:
            song_attributes[attribute] = song_attributes[attribute].replace("/", "|")

        song = Song(**song_attributes)
        songs.append(song)

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

    for song in songs:
        if song.end != inf:
            # Song command.
            command = [
                "ffmpeg",
                "-i",
                album,
                "-acodec",
                "libopus",
                "-ss",
                f"{song.start}",
                "-to",
                f"{song.end}",
                f"{artist}/{artist} - {song.number:02d} - {song.title}.opus",
            ]
        else:
            # Last song.
            command = [
                "ffmpeg",
                "-i",
                album,
                "-acodec",
                "libopus",
                "-ss",
                f"{song.start}",
                f"{artist}/{artist} - {song.number:02d} - {song.title}.opus",
            ]
        if dry_run:
            print(command)
        else:
            call(command)


def parse_arguments():
    epilog = """
    examples:
        Split the mp3 file into tracks and placed them into a folder.
        $ track_splitter.py "Artist Name" "../some/mp3" "some/tracklist.txt"

        Show what would happen if the command were run.
        $ track_splitter.py Artist album.mp3 tracklist.txt --dry-run
    """
    parser = ArgumentParser(
        description="Split albums into songs.",
        formatter_class=RawDescriptionHelpFormatter,
        epilog=dedent(epilog),
    )
    parser.add_argument("artist", help="The artist name.")
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
