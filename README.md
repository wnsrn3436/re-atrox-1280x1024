# Atrox 1280 x 1024

A byte patch for the executable of Atrox (Joymax) that makes the game run at 1280x1024. It changes the screen size of resolution mode 1 from 800x600 to 1280x1024 and moves the interface, laid out for 800x600, to the bottom center of the larger screen. There is a fullscreen variant and a windowed variant that also includes the [Atrox Window Mode](https://github.com/wnsrn3436/re-atrox-window-mode) patch. The changed bytes and their assembly are described in [docs/resolution-patch.md](docs/resolution-patch.md).

**Compatible version**: Atrox v1.10 build 1 (UPX-unpacked `atrox.exe`, md5 `b4c64c06c2afd830995ef497478718be`)

<p>
  <img src="docs/screenshots/screenshot-1.jpg" width="480" alt="Atrox running at 1280x1024">
</p>


## How to use

The patch is applied by hand from the tables in the docs.

1. The retail `atrox.exe` is packed with UPX, so unpack it first with `upx -d`.
2. Pick the fullscreen or windowed variant from the combination table in [docs/resolution-patch.md](docs/resolution-patch.md). In a hex editor, go to each file offset in those tables, check the original bytes, and overwrite them with the new bytes.
3. Run the patched executable from the Atrox folder.

If the screen breaks in the fullscreen variant, launch it with `docs/Atrox 1280 x 1024.bat`. It runs the game with Windows Explorer closed, and after the game exits, pressing any key starts Explorer again. The batch file runs `C:\Program Files\Joymax\Atrox\Atrox 1280 x 1024.exe`, so either save the patched executable under that name or edit the path in the batch file.

Scroll settings for the windowed variant are the same as for the window mode patch. Set mouse scroll and keyboard scroll in the game options to the third notch.


## How it works

**The size of mode 1 is changed.** The resolution function uses 640x480 for mode 0 and 800x600 for mode 1. The game now always passes 1 instead of the mode saved in the options, and the width and height immediates on the mode 1 side are changed to 1280 and 1024.

```
004DC85F  C7 40 20 00 05 00 00  mov  [eax+0x20], 1280 ; width (was 800)
004DC866  E8 1A BD F2 FF        call 0x00408585
004DC86B  C7 40 24 00 04 00 00  mov  [eax+0x24], 1024 ; height (was 600)
```

**The interface coordinates are moved.** The positions of the bottom interface and related elements are constants in the code, based on 800x600. Adding 240 ((1280 - 800) / 2) to every x and 424 (1024 - 600) to every y attaches the 800x600 interface to the bottom center of the larger screen. One spot that takes half of the screen height has no immediate to change, so it jumps to free space, adds 424 to the height, halves it there, and jumps back.


## Files

| Path | Contents |
|---|---|
| `docs/resolution-patch.md` | Target file, variant combinations, tables of changed bytes, assembly notes |
| `docs/Atrox 1280 x 1024.bat` | Batch file that closes Explorer and runs the game when the screen breaks |
| `docs/screenshots/` | Screenshots |


## Credits

`Atrox 1280 x 1024.bat` was written by 감자동 (zero_death).


## License

zlib. See [LICENSE](LICENSE). Bundled libraries made by other people keep their own licenses.
