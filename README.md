# koala-show

Generate a multicolor bitmap viewer (Koala) to quickly check if a rip worked. It generates a C64 binary showing a Koala picture with the given bitmap, videoram and colorram data optionally with a background color (which defaults to 0 (black)).

This is for use after ripping out multicolor bitmap pictures from c64 binaries and checking if the ripped data is correct. The script has two modes of operation:

```koala-show <bitmap-file> <vidram-file> <colram-file> [<background-color>]```

or

```koala-show <koala-file>```

Both will generate a binary with 64tass and run x64sc to run that binary to show the Koala picture.

## Dependencies

* Some Unix-ish system or msys2 for Windows
* A recent 64tass: https://sourceforge.net/projects/tass64/
* x64sc from VICE: https://sourceforge.net/projects/vice-emu/

