# Aonic

Play Lone Wolf and other games books from Project Aon on desktop/mobile device with this app built with Flutter.

| :warning: Attention
| :----------------------------------------------------
| **This is a WIP and is not finished or playable YET**

![A demo of Lonewolf FLutter running as a Linux desktop app.](https://raw.githubusercontent.com/sketchbuch/lonewolf-flutter/main/documentation/images/preview.gif "Lonewolf Flutter")

## About

This app is eventually going to allow you to play gamebooks from [Project AON](https://www.projectaon.org/) on desktops and on Android/iOS mobile devices.

Currently the game book xml from Project Aon is parseable and displayable, but not playable. Things like a working combat system and a combat chart are still needed.

Also the books/images cannot yet be downloaded. A system has been started (and the xml can be donloaded), but it is not persisted and no images are collected.

This is my first "real" Flutter app so there maybe many things to improve or change and the code will be refactored a lot.

Currently you need to be a developer to run the books. Once a working version of the book 1 is usable this will change. Currently I have been able to parse and display book 1-3 without any changes in code needed.

### Goals

- Have all Project Aon game books playable within the app, not just Lone Wolf.
- Require as few changes as possible to get each book to work - the system is generic and I don't want to have to write custom code for each book.
- Be able to download book XML & assets, and have the books persisted on your device/desktop

### Why I'm Making This App

- The [Kai Chronicles](https://github.com/tonib/kaichronicles) app no longer exists
- I wanted to learn more about flutter and got bored with tutorials
- Alternative apps only support a few books, require payment to unlock full features, or have adverts. I do not want to have adverts in this app.

## How to start

1. Install the required packages

  > flutter pub get

2. Run the following command to create translation files:

  > flutter pub run slang

3. Add a folder called samples. It should contain the file "sample.xml" which should be the xml for a book downloaded from project aon. This is just while developing the MVP. A working solution for getting XML from the Project Aon website exists but is switched off. An example book XML file:

  > view-source:<https://www.projectaon.org/data/trunk/en/xml/01fftd.xml>

4. Run the application via VSCode. I have only tried a linux desktop app and an andorid emulator. Emulator may not be fully functional - most testing is happening at the moment with the linux app.

## Additional Documentation

- [Glossary](documentation/Glossary.md)
- [NewBooks](documentation/NewBooks.md)
- [Notes](documentation/Notes.md)

## Reporting Issues

Please use the MVP milestone and any relevant labels when reporting [issues](https://github.com/sketchbuch/lonewolf-flutter/issues).
