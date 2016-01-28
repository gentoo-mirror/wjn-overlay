wjn-overlay
==============

wjn's user overlay for Gentoo GNU/Linux.  
(JA version of README is [README.ja.md](README.ja.md) )

There is Wiki documents at <https://bitbucket.org/wjn/wjn-overlay/wiki/>  
It contains more guidances and information

- This file is updated on 2016-01-28

## contents

There is the complete package list in [PACKAGE-LIST.md](PACKAGE-LIST.md).
but in short, below is some examples

### DE

- [mate](https://github.com/mate-desktop)  
	(Development version)

- [cinnamon](http://cinnamon.linuxmint.com/)  
  (USE="-networkmanager -pulseaudio")

### text

- [nikola](http://getnikola.com/)  
    (7.6.4 and newer. A static website generator based on python)

- [cutemarked](http://cloose.github.io/CuteMarkEd/)  
    (Fixes deps and category in gentoo repo. a Qt5-based markdown text editor)

- [mined](http://towo.net/mined/)  
    (a terminal-based Text Editor with extensive Unicode and CJK support)

- asciidoc-gtksourceview

- markdown-gtksourceview
    (can also *preview in Gedit or Pluma* by webkit-gtk)

### graphic

- AzPainter
- AzDrawing

### media

- [Audacious](http://audacious-media-player.org/)  
    (development version)

- [gdk-pixbuf-psd](http://cgit.sukimashita.com/gdk-pixbuf-psd.git/)  
    (gdk-pixbuf loader for PSD files)

- [gdk-pixbuf-xcf (io-xcf)](https://gitorious.org/xcf-pixbuf-loader)  
    (gdk-pixbuf loader for XCF files)
    
- [libvdpau-va-gl](https://github.com/i-rinat/libvdpau-va-gl)  
    (VDPAU OpenGL/VAAPI backend library)

### X themes

- [neu-icon-theme](http://www.silvestre.com.ar/)  
    (a GNOME icon theme)

- [gion-icon-theme](http://www.silvestre.com.ar/)  
    (a GNOME icon theme)

- [faience-icon-theme](http://tiheum.deviantart.com/art/Faience-icon-theme-255099649)  
    (a GNOME icon theme)

### accesibility

- onboard

- xvkbd

### softwares for multilingualization (mainly JA)

- [Mozc](https://code.google.com/p/mozc/)  
    (Japanese input server patched for input method for [uim](https://code.google.com/p/uim/))
 
- [Mozc UT Dictionary](http://www.geocities.jp/ep3797/mozc_01.html)  
    (Japanese converting server with additional dictionary "UT", patched for Fcitx an uim)  
    <small>The each dictionary's license of "hatena" and "nicodic" is unknown. Specifically "nicodic" feature is not recommended to use. My ebuild's default is "-nicodic"</small>

- [Mozc NEologd UT Dictionary](http://www.geocities.jp/ep3797/mozc_01.html)  
    (Japanese converting server with additional dictionary generated from [mecab-ipadic-NEologd](https://github.com/neologd/mecab-ipadic-neologd), patched for Fcitx an uim)  

- [fcitx-qt5](http://fcitx-im.org/)  
    (Development ver.)

- [uim](http://code.google.com/p/uim/)  
    (Development ver.)

and many JA fonts

## License

GPL v2

## Disclaimer

This repository has completely **NO WARRANTY**.
DO NOT USE this if you don't know what means to use "overlay" (additional repository)

----
wjn
