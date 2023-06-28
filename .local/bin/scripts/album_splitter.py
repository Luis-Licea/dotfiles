#!/usr/bin/python3

################################################################################
# MIT License
#
# Copyright (c) 2023 Luis David Licea Torres
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
################################################################################

"""Split albumns into tracks."""
from argparse import ArgumentParser, RawDescriptionHelpFormatter
from dataclasses import dataclass
from math import inf
from pathlib import Path
from re import search, Match
from subprocess import call
from textwrap import dedent

patterns = [
    # 00:?00:00 Title
    r"((?P<hours>\d+):)?(?P<minutes>\d+):(?P<seconds>\d+) (?P<title>.+)$",
    # 01.[00:00] Title
    r"(?P<number>\d+)\.\[(?P<minutes>\d+):(?P<seconds>\d+)\] (?P<title>.+)$",
    # 01.[00:00(.000)?] Title
    r"(?P<number>\d+)\.\[(?P<minutes>\d+):(?P<seconds>\d+)\.?(?P<milliseconds>\d+)?\] (?P<title>.+)$",
    # 01. Title 00:00(.000)
    r"(?P<number>\d+)\. (?P<title>.+) (?P<minutes>\d+):(?P<seconds>\d+)\.?(?P<milliseconds>\d+)?$",
]


@dataclass
class Song:
    """Represent a song object with timestamps."""

    number: int
    hours: int
    minutes: int
    seconds: int
    milliseconds: int
    end: int
    title: str

    @property
    def start_stamp(self: "Song") -> str:
        """Return the starting time-stamp.

        Args:
            self ("Song"): The song object.

        Returns:
            str: The starting time-stamp in the format HH:MM:SS:sss.
        """
        return f"{self.hours:02d}:{self.minutes:02d}:{self.seconds:02d}.{self.milliseconds:03d}"

    @property
    def end_stamp(self: "Song") -> str:
        """Return the ending time-stamp.

        Args:
            self ("Song"): The song object.

        Returns:
            str: The ending time-stamp in the format HH:MM:SS:sss.
        """
        hours, minutes, seconds, milliseconds = Song.time_from_milliseconds(self.end)
        return f"{hours:02d}:{minutes:02d}:{seconds:02d}.{milliseconds:03d}"

    @property
    def start(self: "Song") -> int:
        """Return the starting time in milliseconds.

        Args:
            self ("Song"): The song object.

        Returns:
            float: The starting time in milliseconds.
        """
        return (
            self.milliseconds
            + self.seconds * 1_000
            + self.minutes * 60_000
            + self.hours * 3_600_000
        )

    @start.setter
    def start(self: "Song", milliseconds: int):
        """Set the number of seconds, minutes, and hours from given value.

        Args:
            self ("Song"): The song object.
            milliseconds (float): The song start in milliseconds.
        """
        hours, minutes, seconds, milliseconds = Song.time_from_milliseconds(milliseconds)
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.milliseconds = milliseconds

    @staticmethod
    def time_from_milliseconds(total_milliseconds: int) -> tuple[int, int, int, int]:
        """Return the total number of milliseconds as hours, minutes, seconds, and milliseconds.

        Args:
            total_milliseconds (int): The total number of milliseconds.

        Returns:
            tuple[int, int, int, int]: The hours, minutes, seconds, and milliseconds.
        """
        milliseconds = total_milliseconds % 1_0000
        seconds = total_milliseconds // 1_000
        minutes = total_milliseconds // 60_000
        hours = total_milliseconds // 3_600_000
        return hours, minutes, seconds, milliseconds

    @staticmethod
    def timestamp(hours: int, minutes: int, seconds: int, milliseconds: int) -> str:
        """Returns the time-stamp in the format HH:MM:SS:sss.

        Args:
            hours (int): The hours.
            minutes (int): The minutes.
            seconds (int): The seconds.
            milliseconds (int): The milliseconds.

        Returns:
            str: The time-stamp in the format HH:MM:SS:sss.
        """
        return f"{hours:02d}:{minutes:02d}:{seconds:02d}.{milliseconds:03d}"


def parse_track_list(text: str) -> list[Song]:
    no_whitespaces = map(str.strip, text.splitlines())
    no_empty_lines = filter(str, no_whitespaces)
    no_comments = filter(lambda line: not line.startswith("#"), no_empty_lines)
    lines = list(no_comments)

    def get_song(match: Match[str]):
        attributes: dict = match.groupdict()
        song_attributes = {
            "number": int(attributes.get("number", 0)),
            "seconds": int(attributes.get("seconds", 0)),
            "milliseconds": int(attributes.get("milliseconds", 0) or 0),
            "minutes": int(attributes.get("minutes", 0)),
            "hours": int(attributes.get("hours", 0)),
            "title": str(attributes["title"].replace("/", "|")),
            "end": inf,
        }
        return Song(**song_attributes)

    def find_matches(pattern, lines) -> list[Song]:
        matches = list(map(lambda line: search(pattern, line), lines))
        if None in matches:
            return []

        matches = [match for match in matches if match is not None]

        songs = list(map(get_song, matches))
        for next_index, song in enumerate(songs, 1):
            if 0 <= next_index < len(songs):
                song.end = songs[next_index].start
        return songs

    song_lists = list(map(lambda pattern: find_matches(pattern, lines), patterns))

    if songs := next(filter(list, song_lists), None):
        return songs

    raise ValueError("Tracklist could not be parsed.")


def split(album: Path, track_list: Path, artist: Path, dry_run: bool):
    """split a music track into specified sub-tracks by calling ffmpeg from the shell"""
    for file in [album, track_list]:
        if not file.is_file():
            raise ValueError(f"File {file} is not a file.")

    songs = parse_track_list(track_list.read_text())

    if not artist.exists():
        artist.mkdir()

    def get_command(song):
        song_location = f"{artist}/{artist} - {song.number:02d} - {song.title}.opus"
        if song.end != inf:
            # Song command.
            return [
                "ffmpeg",
                "-i",
                album,
                "-acodec",
                "libopus",
                "-ss",
                f"{song.start}ms",
                "-to",
                f"{song.end}ms",
                song_location,
            ]
        else:
            # Last song.
            return [
                "ffmpeg",
                "-i",
                album,
                "-acodec",
                "libopus",
                "-ss",
                f"{song.start}ms",
                song_location,
            ]

    commands = list(map(get_command, songs))
    if dry_run:
        for song in songs:
            print(song)
        for command in commands:
            print(command)
    else:
        for command in commands:
            call(command)


def parse_arguments():
    patterns_txt = "\n\t".join(patterns)
    epilog = f"""
    examples:
        Split the mp3 file into tracks and placed them into a folder.
        $ album_splitter.py "Artist Name" "../some/mp3" "some/tracklist.txt"

        Show what would happen if the command were run.
        $ album_splitter.py Artist album.mp3 tracklist.txt --dry-run

        Supported patterns:
        {patterns_txt}
    """
    parser = ArgumentParser(
        description="Split albums into songs.",
        formatter_class=RawDescriptionHelpFormatter,
        epilog=dedent(epilog),
    )
    parser.add_argument("artist", type=Path, help="The artist name.")
    parser.add_argument("album", type=Path, help="The path to the album (a music file).")
    parser.add_argument("track_list", type=Path, help="The path to the track list (a text file).")
    parser.add_argument(
        "-d",
        "--dry-run",
        action="store_true",
        help="Show what would happen",
    )
    args = parser.parse_args()
    print(args)
    return args


def main():
    """Split the album into tracks."""
    args = parse_arguments()
    args_dictonary = vars(args)
    split(**args_dictonary)


def test_tracklist_regex():
    """Test whether the tracklists are read correctly."""
    test1 = """

    01.[00:00] Test name

    02.[01:00.456] Another example?
    03.[02:30.10] More examples!

    04.[03:18] And another one.
    # A comment.
    """

    songs = parse_track_list(test1)

    test2 = """
    1. 3, 2, 1 Let's Start 0:00
    2. This is an example 0:55.300
    3. Line 1:43
    4. Title 2:47
    5. Cool 3:55
    """
    songs = parse_track_list(test2)
    for song in songs:
        print(song)



if __name__ == "__main__":
    main()
    # test_tracklist_regex()
