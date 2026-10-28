# Atrox 1280x1024 patch

The Atrox executable is changed so the game runs at 1280x1024. The screen size of resolution mode 1 goes from 800x600 to 1280x1024, and the interface coordinates, laid out for 800x600, move to the bottom center of the larger screen. There are two variants, fullscreen and windowed.


## Target

| Item | Value |
|---|---|
| Game | Atrox v1.10 build 1 |
| File | UPX-unpacked `atrox.exe` (2,965,504 bytes) |
| md5 | `b4c64c06c2afd830995ef497478718be` |

The retail `atrox.exe` (md5 `01d0c56a04f61ffa40d219eb0378154c`) is packed with UPX. Unpacking it with `upx -d` gives the file in the table above.

The image base is `0x400000`, and every change is inside the `.text` section (virtual address `0x401000`, file offset `0x1000`). So **file offset = virtual address - 0x400000**.


## Combinations

| Variant | Tables to apply |
|---|---|
| Fullscreen 1280x1024 | Table 1, Table 2 (Table 3 is optional) |
| Windowed 1280x1024 | Table 1 and every table of the [window mode patch](https://github.com/wnsrn3436/re-atrox-window-mode/blob/main/docs/window-mode.md) |

The bytes in Table 2 are identical to part of the window mode patch.


## Table 1. 1280x1024 resolution

| Virtual address | File offset | Original bytes | New bytes | Meaning |
|---|---|---|---|---|
| `0x004DC862` | `0xDC862` | `20 03 00 00` | `00 05 00 00` | Mode 1 width 800 → 1280 |
| `0x004DC86E` | `0xDC86E` | `58 02 00 00` | `00 04 00 00` | Mode 1 height 600 → 1024 |
| `0x004DC876` | `0xDC876` | `20 03 00 00` | `00 05 00 00` | Mode 1 calculation constant 800 → 1280 |
| `0x004DC87D` | `0xDC87D` | `E0 01 00 00` | `B0 03 00 00` | Mode 1 calculation constant 480 → 944 |
| `0x0041D11A` | `0x1D11A` | `01 00 00 00` | `F1 00 00 00` | Interface x 1 → 241 |
| `0x0041D211` | `0x1D211` | `AD 01 00 00` | `55 03 00 00` | Interface y 429 → 853 |
| `0x0041D26E` | `0x1D26E` | `41 02 00 00` | `31 03 00 00` | `[0x006A6548]` x 577 → 817 |
| `0x0041D278` | `0x1D278` | `D5 01 00 00` | `7D 03 00 00` | `[0x006A654C]` y 469 → 893 |
| `0x0041D2E3` | `0x1D2E3` | `D6 01 00 00` | `C6 02 00 00` | `[0x006A6538]` x 470 → 710 |
| `0x0041D2ED` | `0x1D2ED` | `E7 01 00 00` | `8F 03 00 00` | `[0x006A653C]` y 487 → 911 |
| `0x0042384F` | `0x2384F` | `08 02 00 00` | `F8 02 00 00` | `[0x006ABC68]` x 520 → 760 |
| `0x00423859` | `0x23859` | `0B 02 00 00` | `B3 03 00 00` | `[0x006ABC6C]` y 523 → 947 |
| `0x00423863` | `0x23863` | `F7 01 00 00` | `E7 02 00 00` | `[0x006ABC50]` x 503 → 743 |
| `0x0042386D` | `0x2386D` | `2F 02 00 00` | `D7 03 00 00` | `[0x006ABC54]` y 559 → 983 |
| `0x00423877` | `0x23877` | `06 02 00 00` | `F6 02 00 00` | `[0x006ABC48]` x 518 → 758 |
| `0x00423881` | `0x23881` | `2A 02 00 00` | `D2 03 00 00` | `[0x006ABC4C]` y 554 → 978 |
| `0x0042388B` | `0x2388B` | `2D 02 00 00` | `1D 03 00 00` | `[0x006ABC58]` x 557 → 797 |
| `0x00423895` | `0x23895` | `EA 01 00 00` | `92 03 00 00` | `[0x006ABC5C]` y 490 → 914 |
| `0x0042389F` | `0x2389F` | `1C 03 00 00` | `0C 04 00 00` | `[0x006ABC60]` x 796 → 1036 |
| `0x004238A9` | `0x238A9` | `FB 01 00 00` | `A3 03 00 00` | `[0x006ABC64]` y 507 → 931 |
| `0x0041D9EC` | `0x1D9EC` | `8B 40 24 99 2B C2 8B F0 D1 FE` | `E9 6A FF FF FF 90 90 90 90 90` | Jump to the code below |
| `0x0041D95B` | `0x1D95B` | 21 x `CC` | `8B 40 24 05 A8 01 00 00 99 2B C2 8B F0 D1 FE E9 87 00 00 00 90` | Add 212 to the screen center y |

The original and new bytes are the instructions' 4-byte immediate values (little endian). Only the first one or two bytes actually change.


## Table 2. Fixed resolution mode and starting position

| Virtual address | File offset | Original bytes | New bytes | Meaning |
|---|---|---|---|---|
| `0x00489521` | `0x89521` | `8B 40 28 50 E8 AD 80 F7 FF` | `EB C8 90 90 90 90 90 90 90` | Jump to the code below |
| `0x004894EB` | `0x894EB` | 13 x `CC` | `B8 01 00 00 00 50 E8 E1 80 F7 FF EB 32` | Pass resolution mode 1 |
| `0x004DC496` | `0xDC496` | `BF 01 00 00 00` | `BF 00 00 00 00` | Screen position at startup |


## Table 3. Scroll detour

| Virtual address | File offset | Original bytes | New bytes | Meaning |
|---|---|---|---|---|
| `0x0042D477` | `0x2D477` | `56 E8 FD 9D FD FF` | `EB 3C 90 90 90 90` | Redirect the first scroll call below |
| `0x0042D481` | `0x2D481` | `53` | `90` | Move `push ebx` below |
| `0x0042D484` | `0x2D484` | `E8 8B 4F FD FF` | `EB 3A 90 90 90` | Redirect the second scroll call below |
| `0x0042D4B5` | `0x2D4B5` | 11 x `90` | `90 90 90 56 E8 BC 9D FD FF EB BD` | First call |
| `0x0042D4C0` | `0x2D4C0` | 16 x `CC` | `90 90 90 53 E8 4B 4F FD FF EB BE 90 90 90 90 90` | Second call |

This is the scroll detour of the window mode patch with the `sar esi, 3` and `sar ebx, 3` slots blanked to `90 90 90`. The calls are only moved and jump straight back, so it behaves exactly like the original. The bytes were in the fullscreen executable, so they are listed here too.


## Setting resolution mode 1 to 1280x1024

`0x004DC840` is the function that takes a resolution mode and sets the screen size. Originally mode 0 is 640x480 and mode 1 is 800x600. Table 2 makes the game always pass mode 1, and the first four rows of Table 1 change the values of mode 1.

```
004DC85A  E8 26 BD F2 FF        call 0x00408585      ; returns the global object 0x00B1DE78
004DC85F  C7 40 20 00 05 00 00  mov  [eax+0x20], 1280 ; width (was 800)
004DC866  E8 1A BD F2 FF        call 0x00408585
004DC86B  C7 40 24 00 04 00 00  mov  [eax+0x24], 1024 ; height (was 600)
004DC872  8B 4E 74              mov  ecx, [esi+0x74]
004DC875  B8 00 05 00 00        mov  eax, 1280        ; was 800
004DC87A  2B C1                 sub  eax, ecx
004DC87C  B9 B0 03 00 00        mov  ecx, 944         ; was 480
004DC881  89 46 7C              mov  [esi+0x7C], eax
004DC884  8B 46 78              mov  eax, [esi+0x78]
004DC887  2B C8                 sub  ecx, eax
004DC889  89 8E 80 00 00 00     mov  [esi+0x80], ecx
```

What range `[esi+0x7C]` and `[esi+0x80]` describe, and why the value standing in for 480 is 944, are left for further investigation.


## Moving the interface coordinates

The positions of the bottom interface and related elements are constants in the code, laid out for an 800x600 screen. The patch adds 240 to every x and 424 to every y. 240 is (1280 - 800) / 2 and 424 is 1024 - 600, so the 800x600 interface sits at the bottom center of the 1280x1024 screen.

```
0041D20D  83 EC 10              sub  esp, 0x10
0041D210  B9 55 03 00 00        mov  ecx, 853         ; was 429
0041D215  8B EC                 mov  ebp, esp
0041D217  BA 20 03 00 00        mov  edx, 800
0041D21C  BB C8 00 00 00        mov  ebx, 200
...
0041D268  C7 05 48 65 6A 00 31 03 00 00  mov [0x006A6548], 817   ; was 577
0041D272  C7 05 4C 65 6A 00 7D 03 00 00  mov [0x006A654C], 893   ; was 469
...
00423849  C7 05 68 BC 6A 00 F8 02 00 00  mov [0x006ABC68], 760   ; was 520
00423853  C7 05 6C BC 6A 00 B3 03 00 00  mov [0x006ABC6C], 947   ; was 523
```

The `mov eax, 1` at `0x0041D119` is used as the x of a rectangle in the `0x0041D20D` block, which is the branch taken for mode 1. That is why the 1 became 241.

The code at `0x0041D9EC` takes half the screen size to place something at the center of the screen. It now jumps to the free space at `0x0041D95B` so that (height + 424) / 2 is used instead of half the height. With 1024 that gives 724, the center (300 + 424) of the 800x600 area moved down by 424.

```
; original
0041D9E7  E8 99 AB FE FF     call 0x00408585
0041D9EC  8B 40 24           mov  eax, [eax+0x24]  ; height
0041D9EF  99                 cdq
0041D9F0  2B C2              sub  eax, edx
0041D9F2  8B F0              mov  esi, eax
0041D9F4  D1 FE              sar  esi, 1            ; esi = height / 2
0041D9F6  E8 8A AB FE FF     call 0x00408585

; patched
0041D9EC  E9 6A FF FF FF     jmp  0x0041D95B
0041D95B  8B 40 24           mov  eax, [eax+0x24]
0041D95E  05 A8 01 00 00     add  eax, 424
0041D963  99                 cdq
0041D964  2B C2              sub  eax, edx
0041D966  8B F0              mov  esi, eax
0041D968  D1 FE              sar  esi, 1            ; esi = (height + 424) / 2
0041D96A  E9 87 00 00 00     jmp  0x0041D9F6
```

What gets placed at the center has not been checked yet.


## Patching by hand

1. Unpack the retail `atrox.exe` with `upx -d` and check that its md5 is `b4c64c06c2afd830995ef497478718be`.
2. Apply the tables of the chosen variant from the combination table above in a hex editor. At each file offset, check that the original bytes match and overwrite them with the new bytes.
3. If the screen breaks in the fullscreen variant, launch it with `docs/Atrox 1280 x 1024.bat`. It closes Windows Explorer, runs the game, and starts Explorer again when any key is pressed. The batch file runs `C:\Program Files\Joymax\Atrox\Atrox 1280 x 1024.exe`, so either save the patched executable under that name or edit the path in the batch file.

```bat
@echo off
taskkill /f /im explorer.exe
"C:\Program Files\Joymax\Atrox\Atrox 1280 x 1024.exe"
echo 아무키나 누르면 다시 탐색기를 시작합니다.
pause >nul
start explorer.exe
```

The batch file prints its message in Korean ("press any key to start Explorer again").
