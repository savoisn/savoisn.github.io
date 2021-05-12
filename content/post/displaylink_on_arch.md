+++
date = "2017-05-02T18:37:43+02:00"
subtitle = ""
tags = ["arch", "linux", "DisplayLink"]
title = "Displaylink on Arch Linux"

+++

# Using Displaylink on Arch Linux.

If, like me, your company has chosen DisplayLink to connect to your big fat 29" monitor, or to connect to TV in meeting room, and you use linux you are probably not very (at all) pleased with that choice !

In my team, 95% of the devs are using Ubuntu as there linux distrib and the Displaylink driver is not really working.

I've switch to Arch Linux this week end ! (1st May is off in France !), installed all my tools and was happy this morning comming to work and show my nice new linux install and realized I've forgot that awesome piece of technology that is DisplayLink !

So I looked into Arch docs, and (to my amazement) found some docs on DisplayLink (Thanks guys you rock!), here you go: 

https://wiki.archlinux.org/index.php/DisplayLink

Being new to Arch, the doc was assuming some arch basics I was missing... So for those like me, here is what I did:

first install the package "base devel", it will install GCC and other things to compile and build things.
```
sudo pacman -S --needed base-devel
```

second thing to prepare, install linux kernel headers for *your* kernel (require to build module according to your kernel)
```
uname -r
```
will display your kernel version, for me it is 4.9, use `pacman -Ss linux headers` to find the package
```
sudo pacman -S core/linux49-headers
```

preparation is nearly done, need to install one last dependency, evdi.
In fact evdi is a dependency of this displaylink AUR.

download the evdi AUR from https://aur.archlinux.org/packages/evdi/
([evdi.tar.gz](https://aur.archlinux.org/cgit/aur.git/snapshot/evdi.tar.gz))

untar it
```
tar zvf evdi.tar.gz
```

build and install it
```
cd evdi
makepkg -si
```

Same thing with the displaylink AUR
download the displayLink package from https://aur.archlinux.org/packages/displaylink/ AUR project
([displaylink.tar.gz](https://aur.archlinux.org/cgit/aur.git/snapshot/displaylink.tar.gz))

untar it
```
tar zvf displaylink.tar.gz
```

build and install it (makepkg is a tool to build AUR package)
```
cd displaylink
makepkg -si
```

udl is the kernel module that manage displaylink V1 driver, which the current driver use as a base.
activate *udl* kernel module and start displaylink service,
```
sudo modprobe udl
sudo systemctl start diplaylink.service
```

plug your usb displaylink (powered...) cable into your computer (into an usb plug for example, that can be handy)
wait a few seconds (less than 30 seconds...)
and check your providers : 
```
xrandr --listproviders
```

you should see 2 providers 
```
Providers: number : 2
Provider 0: id: 0x45 cap: 0xb, Source Output, Sink Output, Sink Offload crtcs: 4 outputs: 2 associated providers: 1 name:Intel 
Provider 1: id: 0x14d cap: 0x2, Sink Output crtcs: 1 outputs: 1 associated providers: 1 name:modesetting
```

associate the new provider (modesetting) output to the Intel provide input... (awesome !!! don't ask me why... can't yet grasp the whole concept)
```
xrandr --setprovideroutputsource 1 0
```

look what's your xrandr current output look like
```
xrandr --current
```

you should see 2 differents possible screens:
```
Screen 0: minimum 8 x 8, current 2560 x 1440, maximum 32767 x 32767
eDP1 connected primary 1920x1080+0+0 (normal left inverted right x axis y axis) 340mm x 190mm
   1920x1080     60.02*+
   1400x1050     59.98
   1600x900      60.00
   1280x1024     60.02
   1280x960      60.00
   1368x768      60.00
   1280x720      60.00
   1024x768      60.00
   1024x576      60.00
   960x540       60.00
   800x600       60.32    56.25
   864x486       60.00
   640x480       59.94
   720x405       60.00
   640x360       60.00
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
DVI-I-1-1 connected 2560x1440+0+0 (normal left inverted right x axis y axis) 597mm x 336mm
   2560x1440     59.95 +
   2048x1152     60.00
   1920x1200     59.88
   1920x1080     60.00    50.00    59.94    30.00    25.00    24.00    29.97    23.98
   1600x1200     60.00
   1680x1050     59.95
   1280x1024     75.02    60.02
   1200x960      59.99
   1152x864      75.00
   1280x720      60.00    50.00    59.94
   1024x768      75.03    60.00
   800x600       75.00    60.32    56.25
   720x576       50.00
   848x480       60.00
   720x480       60.00    59.94
   640x480       75.00    60.00    59.94
   720x400       70.08
  1280x1024 (0x106) 108.000MHz +HSync +VSync
        h: width  1280 start 1328 end 1440 total 1688 skew    0 clock  63.98KHz
        v: height 1024 start 1025 end 1028 total 1066           clock  60.02Hz
  1024x768 (0x10a) 65.000MHz -HSync -VSync
        h: width  1024 start 1048 end 1184 total 1344 skew    0 clock  48.36KHz
        v: height  768 start  771 end  777 total  806           clock  60.00Hz
  800x600 (0x10d) 40.000MHz +HSync +VSync
        h: width   800 start  840 end  968 total 1056 skew    0 clock  37.88KHz
        v: height  600 start  601 end  605 total  628           clock  60.32Hz
  800x600 (0x10e) 36.000MHz +HSync +VSync
        h: width   800 start  824 end  896 total 1024 skew    0 clock  35.16KHz
        v: height  600 start  601 end  603 total  625           clock  56.25Hz
  640x480 (0x110) 25.175MHz -HSync -VSync
        h: width   640 start  656 end  752 total  800 skew    0 clock  31.47KHz
        v: height  480 start  490 end  492 total  525           clock  59.94Hz
```

here we see eDP1 is my laptop screen (don't shut it down... would be a bit stressfull right?)
and the DVI-I-1-1 which is my displaylink connected screen.
the * sign indicate the active display


let's activate our displaylink screen !
mirror your display (my favorite to present things to an audiance):
```
xrandr --output eDP1 --auto --primary --output DVI-I-1-1 --auto --same-as eDP1
```

shutting down that display
```
xrandr --output eDP1 --auto --output DVI-I-1-1 --off
```

extended your display to the right of your current display:
```
xrandr --newmode "3840x2160_30.00"  338.75  3840 4080 4488 5136  2160 2163 2168 2200 -hsync +vsync
xrandr --addmode  DP1 "3840x2160_30.00"
xrandr --output eDP1 --auto --primary --output DP1 --mode 3840x2160_30.00 --right-of eDP1 --rate 30
```

you can customize the position replacing the `--right-of` with either of :
```
--left-of
--above
--below
```

For myself I've created a few zsh function that handles this for me :)

Hope it helps !

Once I get the disqus plugin to work in Hugo, hopefully you will be able to give me some feedback.
