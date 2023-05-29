# DotUI-X

_DotUI-X is a fork of [DotUI](https://github.com/Xpndable/DotUI), where the X stands for eXperimental._

While stability remains a focus, releases will be rolling and bugs can be expected when new features are added.  
Consider this a development branch, while the main DotUI repository is the stable one.  
The integration of DotUI-X features into the upstream DotUI repository shall be at the sole discretion of the DotUI maintainers.

**For Users**: Please check the [wiki](wiki) for installation instructions. Don't worry, it's simple !

**For Developers**: Refer to [BUILD.md](BUILD.md) for build instructions.

---

# DotUI

_DotUI is a port of the popular [MiniUI](https://github.com/shauninman/MiniUI) custom launcher and integrated in-game menu, compatible with the [Miyoo Mini Plus](https://www.aliexpress.com/item/1005005215387485.html) handheld emulator_

<img src="github/main.png" width=320 /> <img src="github/menu.png" width=320 />

# Important Notice

All support for this port on the Mini Plus will be provided on this project by Xpndable. Please raise issues here, or discuss them on the [Retro Gaming Handhelds discord server](https://discord.gg/retro-game-handhelds-529983248114122762).

# Project Information

This project now has a release candidate, and barring any major bugs or issues found, will be graduated to v1.0 some time after publishing. The download files can be found [here](#)

The following are the list of features that will be worked on to take advantage of the WiFi chip in the Miyoo Mini Plus (in no particular order):
* WiFi configuration tool and OTA updates
* File Transfer tool
* Cloud Saves
* Retroachievements
* RTC Sync
* NetPlay

## Contributing

If you'd like to contribute to the project:
* For bugs, simply raise a pull request and it will be assessed on it's own merits.
* For features, first build and release a .pak as either a Tool or Emu add-on in your own project on GitHub. If you'd then like to have this included in the project as an official extra, raise a pull request that links your code into the `third-party` folder, and include a modified `make` script. This will ensure an ever-green approach to including your work in the DotUI repository.
* If your feature requires modification to the core components such as `keymon`, `batmon`, `main`, `common`, `mmenu` or `msettings`, feel free to discuss with me your ideas in the [Retro Gaming Handhelds discord server](https://discord.gg/retro-game-handhelds-529983248114122762), and we can co-ordinate our combined efforts.

---

# MiniUI

_MiniUI is a custom launcher and integrated in-game menu for the [Miyoo Mini](https://lemiyoo.cn/product/143.html) handheld emulator_

MiniUI is simple, some might say to a fault. That's okay. I think it's one of those things where, if you like it, even just a little bit, you'll love it. (For the uninitiated, MiniUI is a direct descendent of [MinUI](https://github.com/shauninman/MinUI) which itself is a distillation of the stock launcher and menu of the [Trimui Model S](http://www.trimui.com).)

MiniUI is defined by no. No boxart. No video previews. No background menu music. No custom themes. No runners-up. MiniUI wants to disappear and speed you on your way. MiniUI is unapologetically opinionated software. Sorry not sorry. 

Check the [Releases](#) for the latest and if you want more info about features and setup before downloading, the readme included in every release is also available [here](#) (without formatting).

MiniUI maybe be simple but it's also extensible. See the [Extras readme](#) for info on adding additional paks or creating your own.

## Key features

- Simple launcher, simple SD card
- No launcher settings or configuration
- Automatically hides extension and region/version cruft in display names
- Consistent in-emulator menu with quick access to save states, disc changing, and emulator options
- Automatically sleeps after 30 seconds or press POWER to sleep (and later, wake)
- Automatically powers off while asleep after two minutes or hold POWER for one second
- Automatically resumes right where you left off if powered off while in-game
- Resume from manually created, last used save state by pressing X in the launcher instead of A
- Streamlined emulator frontend (picoarch + libretro cores)

## Stock systems

- Game Boy
- Game Boy Color
- Game Boy Advance
- Nintendo Entertainment System
- Super Nintendo Entertainment System
- Sega Genesis
- Sony PlayStation

## Extras

- Sega Game Gear
- Sega Master System
- Pokémon mini
- TurboGrafx-16

## Extra Extras

The community has created a bunch of additional paks, some tools and utilities, others paks based on cores created for Onion. I do not support these paks, nor have I done any sort of quality checks on them. They may lack the polish, features, and performance of my official stock and extras paks.

- [tiduscrying](https://github.com/tiduscrying/MiniUI-Extra-Extras)
- [westoncampbell](https://github.com/westoncampbell/MiyooMini/releases/tag/MiniUI-OnionPAKs)
- [eggs](https://www.dropbox.com/sh/hqcsr1h1d7f8nr3/AABtSOygIX_e4mio3rkLetWTa?preview=MiniUI_Tools.zip)
