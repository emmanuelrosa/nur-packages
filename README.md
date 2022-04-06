# Emmanuel's nur-packages

NOTICE: This repository has been replaced by https://github.com/emmanuelrosa/erosanix. erosanix is a Nix flake which contains the majority of what used to be in this NUR.

This NUR now uses a shim to make the erosanix flake appear as a NUR, for those who haven't jumped on board with flakes yet.

There are some things which have been removed:

 - Overlays: The fonts exist as packages, instead.
 - Packages:
     - electrum-hardened 
     - `trace-font` is now named `trace`; Oops, sorry!
     - electrumx
 - Modules:
     - electrumx
     - fzf (I never got this working right)

Here's a taste of what's included (yes, there are some WINE-compatible Windows applications too):

```
{
  "lib": {
    "type": "unknown"
  },
  "nixosModules": {
    "btrbk": {
      "type": "nixos-module"
    },
    "electrs": {
      "type": "nixos-module"
    },
    "electrum-personal-server": {
      "type": "nixos-module"
    },
    "matrix-sendmail": {
      "type": "nixos-module"
    },
    "protonvpn": {
      "type": "nixos-module"
    }
  },
  "packages": {
    "aarch64-linux": {
      "battery-icons": {
        "description": "A font containing nothing but batteries.",
        "name": "battery-icons-2020-01-26",
        "type": "derivation"
      },
      "bitcoin-onion-nodes": {
        "description": "A list of over 1,000 Bitcoin Core nodes running as Tor v3 onion services.",
        "name": "bitcoin-onion-nodes-2.2.txt",
        "type": "derivation"
      },
      "century-gothic": {
        "description": "Century Gothic font.",
        "name": "century-gothic-2016-09-17",
        "type": "derivation"
      },
      "electrum-personal-server": {
        "description": "An lightweight, single-user implementation of the Electrum server protocol",
        "name": "electrum-personal-server-0.2.3",
        "type": "derivation"
      },
      "er-wallpaper": {
        "description": "A script for changing wallpaper and setting color schemes, for Linux",
        "name": "er-wallpaper-0.2.0.0",
        "type": "derivation"
      },
      "matrix-sendmail": {
        "description": "A simple sendmail implementation which uses a Matrix CLI client to send 'mail' to a Matrix room.",
        "name": "matrix-sendmail-71dd8311de698dba2156c972b2b79f0c8256ad9c",
        "type": "derivation"
      },
      "pdf2png": {
        "description": "A simple script to convert a PDF into multiple PNGs.",
        "name": "pdf2png-0.2.0.0",
        "type": "derivation"
      },
      "rofi-menu": {
        "description": "Various rofi menus (aka. modi)",
        "name": "rofi-menu-0.7.0",
        "type": "derivation"
      },
      "trace": {
        "description": "Trace font",
        "name": "trace-font-2020-03-25",
        "type": "derivation"
      },
      "wingdings": {
        "description": "Wingdings font.",
        "name": "wingdings-2015-11-10",
        "type": "derivation"
      }
    },
    "i686-linux": {
      "battery-icons": {
        "description": "A font containing nothing but batteries.",
        "name": "battery-icons-2020-01-26",
        "type": "derivation"
      },
      "bitcoin-onion-nodes": {
        "description": "A list of over 1,000 Bitcoin Core nodes running as Tor v3 onion services.",
        "name": "bitcoin-onion-nodes-2.2.txt",
        "type": "derivation"
      },
      "century-gothic": {
        "description": "Century Gothic font.",
        "name": "century-gothic-2016-09-17",
        "type": "derivation"
      },
      "electrum-personal-server": {
        "description": "An lightweight, single-user implementation of the Electrum server protocol",
        "name": "electrum-personal-server-0.2.3",
        "type": "derivation"
      },
      "er-wallpaper": {
        "description": "A script for changing wallpaper and setting color schemes, for Linux",
        "name": "er-wallpaper-0.2.0.0",
        "type": "derivation"
      },
      "matrix-sendmail": {
        "description": "A simple sendmail implementation which uses a Matrix CLI client to send 'mail' to a Matrix room.",
        "name": "matrix-sendmail-71dd8311de698dba2156c972b2b79f0c8256ad9c",
        "type": "derivation"
      },
      "mkwindowsapp-tools": {
        "description": "A set of tools for working with packages made with mkWindowsApp.",
        "name": "mkwindows-tools-1.0.0",
        "type": "derivation"
      },
      "muun-recovery-tool": {
        "description": "You can use this Recovery Tool to transfer all funds out of your Muun account to an address of your choosing",
        "name": "muun-recovery-tool-2.2.1",
        "type": "derivation"
      },
      "notepad-plus-plus": {
        "description": "A text editor and source code editor for use under Microsoft Windows. It supports around 80 programming languages with syntax highlighting and code folding. It allows working with multiple open files in a single window, thanks to its tabbed editing interface.",
        "name": "notepad++-8.3.3",
        "type": "derivation"
      },
      "pdf2png": {
        "description": "A simple script to convert a PDF into multiple PNGs.",
        "name": "pdf2png-0.2.0.0",
        "type": "derivation"
      },
      "rofi-menu": {
        "description": "Various rofi menus (aka. modi)",
        "name": "rofi-menu-0.7.0",
        "type": "derivation"
      },
      "trace": {
        "description": "Trace font",
        "name": "trace-font-2020-03-25",
        "type": "derivation"
      },
      "vim-desktop": {
        "description": "A desktop menu (and file associations) to run VIM, a greatly improved version of the good old UNIX editor Vi. Alacritty is used as the terminal.",
        "name": "vim-desktop-1.0.1",
        "type": "derivation"
      },
      "wingdings": {
        "description": "Wingdings font.",
        "name": "wingdings-2015-11-10",
        "type": "derivation"
      }
    },
    "x86_64-linux": {
      "amazon-kindle": {
        "description": "Buy once, read everywhere. Sign in with an Amazon account, and sync Kindle books across all your devices that have the Kindle app installed and across any Kindle device.",
        "name": "amazon-kindle-1.33.62002",
        "type": "derivation"
      },
      "battery-icons": {
        "description": "A font containing nothing but batteries.",
        "name": "battery-icons-2020-01-26",
        "type": "derivation"
      },
      "bitcoin-onion-nodes": {
        "description": "A list of over 1,000 Bitcoin Core nodes running as Tor v3 onion services.",
        "name": "bitcoin-onion-nodes-2.2.txt",
        "type": "derivation"
      },
      "century-gothic": {
        "description": "Century Gothic font.",
        "name": "century-gothic-2016-09-17",
        "type": "derivation"
      },
      "electrum-personal-server": {
        "description": "An lightweight, single-user implementation of the Electrum server protocol",
        "name": "electrum-personal-server-0.2.3",
        "type": "derivation"
      },
      "er-wallpaper": {
        "description": "A script for changing wallpaper and setting color schemes, for Linux",
        "name": "er-wallpaper-0.2.0.0",
        "type": "derivation"
      },
      "matrix-sendmail": {
        "description": "A simple sendmail implementation which uses a Matrix CLI client to send 'mail' to a Matrix room.",
        "name": "matrix-sendmail-71dd8311de698dba2156c972b2b79f0c8256ad9c",
        "type": "derivation"
      },
      "mkwindowsapp-tools": {
        "description": "A set of tools for working with packages made with mkWindowsApp.",
        "name": "mkwindows-tools-1.0.0",
        "type": "derivation"
      },
      "muun-recovery-tool": {
        "description": "You can use this Recovery Tool to transfer all funds out of your Muun account to an address of your choosing",
        "name": "muun-recovery-tool-2.2.1",
        "type": "derivation"
      },
      "notepad-plus-plus": {
        "description": "A text editor and source code editor for use under Microsoft Windows. It supports around 80 programming languages with syntax highlighting and code folding. It allows working with multiple open files in a single window, thanks to its tabbed editing interface.",
        "name": "notepad++-8.3.3",
        "type": "derivation"
      },
      "nvidia-offload": {
        "name": "nvidia-offload",
        "type": "derivation"
      },
      "openimajgrabber": {
        "description": "A collection of libraries and tools for multimedia (images, text, video, audio, etc.) content analysis and content generation. This package only builds the OpenIMAJGrabber for Linux.",
        "name": "openimajgrabber-1.3.10",
        "type": "derivation"
      },
      "pdf2png": {
        "description": "A simple script to convert a PDF into multiple PNGs.",
        "name": "pdf2png-0.2.0.0",
        "type": "derivation"
      },
      "rofi-menu": {
        "description": "Various rofi menus (aka. modi)",
        "name": "rofi-menu-0.7.0",
        "type": "derivation"
      },
      "sierrachart": {
        "description": "A professional desktop Trading and Charting platform for the financial markets, supporting connectivity to various exchanges and backend trading platform services.",
        "name": "sierrachart-default-2377",
        "type": "derivation"
      },
      "sparrow": {
        "description": "A modern desktop Bitcoin wallet application supporting most hardware wallets and built on common standards such as PSBT, with an emphasis on transparency and usability.",
        "name": "sparrow-1.6.3",
        "type": "derivation"
      },
      "tastyworks": {
        "description": "We built tastyworks to be one of the fastest, most reliable, and most secure trading platforms in the world. At tastyworks, you can invest your time as wisely as you do your money. With our See It, Click It, Trade It design, your trading becomes efficient, confident, and current.",
        "name": "tastyworks-1.19.3",
        "type": "derivation"
      },
      "trace": {
        "description": "Trace font",
        "name": "trace-font-2020-03-25",
        "type": "derivation"
      },
      "vim-desktop": {
        "description": "A desktop menu (and file associations) to run VIM, a greatly improved version of the good old UNIX editor Vi. Alacritty is used as the terminal.",
        "name": "vim-desktop-1.0.1",
        "type": "derivation"
      },
      "wingdings": {
        "description": "Wingdings font.",
        "name": "wingdings-2015-11-10",
        "type": "derivation"
      }
    }
  }
}
```
