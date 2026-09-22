### AnyKernel3 Boot Image Puller
## uses the AnyKernel3 backend by osm0sis @ xda-developers
## POCO X3/NFC (surya/karna) - dumps boot.img to /sdcard for Magisk/KernelSU patching

### AnyKernel setup
# global properties
properties() { '
kernel.string=Farewell Kernel | Boot Image Puller | POCO X3/NFC (surya/karna)
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=surya
device.name2=karna
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties

# boot shell variables
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# output file name (timestamped so re-pulling never overwrites the old dump)
BOOTNAME=boot-$(date +%Y%m%d-%H%M%S).img;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

### pull boot.img
ui_print " " "Pulling $BLOCK...";

# dump to the first writable location
for BOOTDIR in /sdcard /data/local/tmp /cache /tmp; do
  [ -d $BOOTDIR ] || continue;
  echo test > $BOOTDIR/.ak3-puller 2>/dev/null || continue;
  rm -f $BOOTDIR/.ak3-puller;
  BOOTOUT=$BOOTDIR/$BOOTNAME;
  ui_print " " "Dumping $BLOCK to $BOOTOUT...";
  if dd if=$BLOCK of=$BOOTOUT bs=1048576 && [ -s $BOOTOUT ]; then
    break;
  fi;
  rm -f $BOOTOUT;
  BOOTOUT=;
done;
[ "$BOOTOUT" ] || abort "Dumping image failed. Aborting...";

ui_print " " "Saved $(wc -c < $BOOTOUT) bytes to $BOOTOUT";
ui_print " " "Patch it with Magisk/KernelSU, then flash the patched image.";
### end pull
