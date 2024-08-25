---
title: Hello, Python manim!
categories: 
 - Python
tags: 
 - Python manim
 - Python Graphics
date: 2022-07-20 21:23:43 +0800
last_modified_at: 2024-05-25 09:49:06 +0800
---

# Hello, manim!

本示例来自Manim community edition 官方文档[^1]。首先按照步骤安装Manim[^2]，之后按照示例编写代码[^3]：

```python
# script1.py
from manim import *

class CreateCircle(Scene):
    # Most of the time, the code for scripting an animation is entirely contained within the construct() method of a Scene class.
    # Inside construct(), you can create objects, display them on screen, and animate them.
    # Note: All animations must reside within the construct() method of a class derived from Scene.
    # Other code,such as auxiliary or mathematical functions, may reside outside the class.
    def construct(self):
        hello = Text('Hello, manim!', font='Arial', font_size=90)
        self.play(Write(hello))
        self.wait(2)
        self.play(FadeOut(hello))

        circle = Circle()  # create a circle
        circle.set_fill(PINK, opacity=0.5)  # set the color and transparency
        # self.play(Create(circle))  # show the circle on screen
        square = Square()  # create a square
        square.rotate(PI / 4)  # rotate a certain amount

        self.play(Create(square))  # animate the creation of the square
        self.play(Transform(square, circle))  # interpolate the square into the circle
        self.play(FadeOut(square))  # fade out animation
```

之后，在命令行中输入：

```
manim -pql script1.py CreateCircle
```

即可得到动画视频。其中，

- -p ：表示一旦渲染完成就播放视频动画；
- -ql：表示以 low quality 的质量渲染，这里是480p15fps；使用 -qh 可以生成1080p60fps的视频；
- script1.py 是python文件名
- CreateCircle 是上面创建的继承自Scene的子类。
- 如果我们想要输出scene的最后一帧画面可以使用 -s，并且可以和其他flags结合生成不同分辨率的图像，如：`-s -ql`, `-s -qh`

⚠注意：因为我使用的是腾讯云图床，没有找到合适的视频外链，因此是在终端中输入以下代码生成相应的gif文件：

```
manim script1.py --format=gif
```

生成的gif文件如下所示：

![CreateCircle_ManimCE_v0.16.0.post0.gif](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/CreateCircle_ManimCE_v0.16.0.post0.gif?raw=true)

<br>



# 在 construct 函数中创建多个 sections，并分别渲染

上面的代码最终只生成一个视频，想要将一个 scene 中的每个 section 都生成一个视频，需要在两个 sections 中间定义一个 cuts，如：

```python
# script2.py
from manim import *

class TrySections(Scene):
    def construct(self):
        # play the first animations...
        # you don't need a section in the very beginning as it gets created automatically
        self.next_section()

        # Hello, world!
        hello = Text('Hello, manim!', font='Arial', font_size=90)
        self.play(Write(hello))
        self.wait(2)
        self.play(FadeOut(hello))
        self.next_section()

        # Be aware that you need **at least one animation** in each section,
        # so here we have to use self.wait()
        self.add(Circle())
        self.wait()
        self.next_section()
```

之后，在命令行中输入：

```
manim --save_sections script2.py
```

就可以在目录 .\media\videos\script2\1080p60 下看到sections文件夹

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220721091335989.png?raw=true" style="zoom:50%;" />

该文件夹的内容如下：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220721091442634.png?raw=true" alt="image-20220721091442634" style="zoom: 50%;" />

两个视频文件是之前我们分隔开的两个sections分别对应的输出视频；.jison文件则记录了关于每个 section 输出视频的信息。

```json
[
    {
        "name": "unnamed",
        "type": "default.normal",
        "video": "TrySections_0000.mp4",
        "codec_name": "h264",
        "width": 1920,
        "height": 1080,
        "avg_frame_rate": "60/1",
        "duration": "4.000000",
        "nb_frames": "240"
    },
    {
        "name": "unnamed",
        "type": "default.normal",
        "video": "TrySections_0001.mp4",
        "codec_name": "h264",
        "width": 1920,
        "height": 1080,
        "avg_frame_rate": "60/1",
        "duration": "1.000000",
        "nb_frames": "60"
    }
]
```

这些信息可供第三方应用使用。

另外，我们也可以指定跳过 cuts，如：

```python
def construct(self):
    self.next_section(skip_animations=True)
    # play some animations that shall be skipped...
    self.next_section()
    # play some animations that won't get skipped...
```

<br>

# CLI中的command和flags

在深入学习之前，大致了解一下CLI(command-line interface)中的常用命令和flags是非常必要的。

## COMMANDS

```
$ manim --help
Manim Community v0.16.0.post0

Usage: manim [OPTIONS] COMMAND [ARGS]...

  Animation engine for explanatory math videos.

Options:
  --version  Show version and exit.
  --help     Show this message and exit.

Commands:
  cfg      Manages Manim configuration files.
  init     Create a new project or insert a new scene.
  new      (Deprecated) Create a new project or insert a new scene.
  plugins  Manages Manim plugins.
  render   Render SCENE(S) from the input FILE.

See 'manim <command>' to read about a specific subcommand.

Note: the subcommand 'manim render' is called if no other subcommand is
specified. Run 'manim render --help' if you would like to know what the '-ql' or
'-p' flags do, for example.

Made with <3 by Manim Community developers.
```

- 之前在CLI中输入的命令，如：`manim -pql script1.py CreateCircle`，一直是使用的默认值，等同于 `manim render -pql script1.py CreateCircle`。在不指定任何 command 的情况下，manim 默认使用render；
- 除了 render 之外，manim 还有其他命令，如：`cfg`，`init`，`plugins` 和 `new` (deprecated)。

## COMMAND-render

```
$ manim render --help
Manim Community v0.16.0.post0

Usage: manim render [OPTIONS] FILE [SCENE_NAMES]...

  Render SCENE(S) from the input FILE.

  FILE is the file path of the script or a config file.

  SCENES is an optional list of scenes in the file.

Global options:
  -c, --config_file TEXT         Specify the configuration file to use for
                                 render settings.
  --custom_folders               Use the folders defined in the [custom_folders]
                                 section of the config file to define the output
                                 folder structure.
  --disable_caching              Disable the use of the cache (still generates
                                 cache files).
  --flush_cache                  Remove cached partial movie files.
  --tex_template TEXT            Specify a custom TeX template file.
  -v, --verbosity [DEBUG|INFO|WARNING|ERROR|CRITICAL]
                                 Verbosity of CLI output. Changes ffmpeg log
                                 level unless 5+.
  --notify_outdated_version / --silent
                                 Display warnings for outdated installation.
  --enable_gui                   Enable GUI interaction.
  --gui_location TEXT            Starting location for the GUI.
  --fullscreen                   Expand the window to its maximum possible size.
  --enable_wireframe             Enable wireframe debugging mode in opengl.
  --force_window                 Force window to open when using the opengl
                                 renderer, intended for debugging as it may
                                 impact performance
  --dry_run                      Renders animations without outputting image or
                                 video files and disables the window

Output options:
  -o, --output_file TEXT         Specify the filename(s) of the rendered
                                 scene(s).
  -0, --zero_pad INTEGER RANGE   Zero padding for PNG file names.  [0<=x<=9]
  --write_to_movie               Write the video rendered with opengl to a file.
  --media_dir PATH               Path to store rendered videos and latex.
  --log_dir PATH                 Path to store render logs.
  --log_to_file                  Log terminal output to file.

Render Options:
  -n, --from_animation_number TEXT
                                 Start rendering from n_0 until n_1. If n_1 is
                                 left unspecified, renders all scenes after n_0.
  -a, --write_all                Render all scenes in the input file.
  --format [png|gif|mp4|webm|mov]
  -s, --save_last_frame
  -q, --quality [l|m|h|p|k]      Render quality at the follow resolution
                                 framerates, respectively: 854x480 15FPS,
                                 1280x720 30FPS, 1920x1080 60FPS, 2560x1440
                                 60FPS, 3840x2160 60FPS
  -r, --resolution TEXT          Resolution in (W,H) for when 16:9 aspect ratio
                                 isn't possible.
  --fps, --frame_rate FLOAT      Render at this frame rate.
  --renderer [cairo|opengl]      Select a renderer for your Scene.
  --use_opengl_renderer          Render scenes using OpenGL (Deprecated).
  -g, --save_pngs                Save each frame as png (Deprecated).
  -i, --save_as_gif              Save as a gif (Deprecated).
  --save_sections                Save section videos in addition to movie file.
  -s, --save_last_frame          Save last frame as png (Deprecated).
  -t, --transparent              Render scenes with alpha channel.
  --use_projection_fill_shaders  Use shaders for OpenGLVMobject fill which are
                                 compatible with transformation matrices.
  --use_projection_stroke_shaders
                                 Use shaders for OpenGLVMobject stroke which are
                                 compatible with transformation matrices.

Ease of access options:
  --progress_bar [display|leave|none]
                                 Display progress bars and/or keep them
                                 displayed.
  -p, --preview                  Preview the Scene's animation. OpenGL does a
                                 live preview in a popup window. Cairo opens the
                                 rendered video file in the system default media
                                 player.
  -f, --show_in_file_browser     Show the output file in the file browser.
  --jupyter                      Using jupyter notebook magic.

Other options:
  --help                         Show this message and exit.

Made with <3 by Manim Community developers.
```

## COMMAND-cfg

```
$ manim cfg --help
Manim Community v0.16.0.post0

Usage: manim cfg [OPTIONS] COMMAND [ARGS]...

  Manages Manim configuration files.

Options:
  --help  Show this message and exit.

Commands:
  export
  show
  write

Made with <3 by Manim Community developers.
```

## COMMAND-plugins

```
$ manim plugins --help
Manim Community v0.16.0.post0

Usage: manim plugins [OPTIONS]

  Manages Manim plugins.

Options:
  -l, --list  List available plugins.
  --help      Show this message and exit.

Made with <3 by Manim Community developers.
```
<br>

# ManimConfig 类

[https://docs.manim.community/en/stable/guides/configuration.html#the-manimconfig-class](https://docs.manim.community/en/stable/guides/configuration.html#the-manimconfig-class).

<br>

# References

[^1]: [Manim Community v0.18.1](https://docs.manim.community/en/stable/index.html).
[^2]: [Windows - Manim Community v0.18.1](https://docs.manim.community/en/stable/installation/windows.html).
[^3]: [Quickstart - Manim Community v0.18.1](https://docs.manim.community/en/stable/tutorials/quickstart.html).
