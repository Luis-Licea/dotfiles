import json
import os
import threading
from subprocess import PIPE, Popen

from ranger.ext.img_display import ImageDisplayer, register_image_displayer


@register_image_displayer("ueberzugpp")
class UeberzugImageDisplayer(ImageDisplayer):
    """Implementation of ImageDisplayer using ueberzug.
    Ueberzug can display images in a Xorg session.
    Does not work over ssh.
    """

    IMAGE_ID = "preview"
    is_initialized = False

    def __init__(self):
        self.process = None

    def initialize(self):
        """start ueberzug"""
        if self.is_initialized and self.process.poll() is None and not self.process.stdin.closed:
            return

        # We cannot close the process because that stops the preview.
        # pylint: disable=consider-using-with
        with open(os.devnull, "wb") as devnull:
            self.process = Popen(
                ["ueberzugpp", "layer", "--silent", "--no-cache"],
                cwd=self.working_dir,
                stderr=devnull,
                stdin=PIPE,
                universal_newlines=True,
            )
        self.is_initialized = True

    def _execute(self, **kwargs):
        self.initialize()
        self.process.stdin.write(json.dumps(kwargs) + "\n")
        self.process.stdin.flush()

    def draw(self, path, start_x, start_y, width, height):
        self._execute(
            action="add",
            identifier=self.IMAGE_ID,
            x=start_x,
            y=start_y,
            max_width=width,
            max_height=height,
            path=path,
        )

    def clear(self, start_x, start_y, width, height):
        if self.process and not self.process.stdin.closed:
            self._execute(action="remove", identifier=self.IMAGE_ID)

    def quit(self):
        if self.is_initialized and self.process.poll() is None:
            timer_kill = threading.Timer(1, self.process.kill, [])
            try:
                self.process.terminate()
                timer_kill.start()
                self.process.communicate()
            finally:
                timer_kill.cancel()
