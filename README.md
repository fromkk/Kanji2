# Kanji

Kanji is create image tool for macOS, it is able to write only one character.

---

## Install

```bash
git clone git@github.com:fromkk/Kanji2.git
cd ./Kanji2
xcodebuild build
cp -f build/Release/Kanji2 /usr/local/bin/kanji
```

## Usage

```bash
kanji --character <character> --width <width> --height <height> --font <font> --output <output> --background <background> --color <color>
character  | set character for create image
width      | set image width
height     | set image height
font       | set font name
background | rgb background color
color      | rgb text color
output     | set image output path
```

