# Boot Image Puller (POCO X3/NFC)

Flashable zip berbasis [AnyKernel3](https://github.com/osm0sis/AnyKernel3) untuk menarik (dump) partisi `boot` ke `/sdcard/boot-YYYYMMDD-HHMMSS.img`, biar bisa di-patch pakai Magisk/KernelSU lalu di-flash balik. Zip ini **tidak menulis/mengubah partisi apa pun**, jadi aman di-flash berulang kali dan hasilnya tidak pernah ketimpa (nama file pakai timestamp).

## Download & pakai

1. Download `AK3-BootPuller.zip` dari halaman [Releases](https://github.com/fannndi/Boot-Image-Puller/releases/latest).
2. Flash lewat TWRP / OrangeFox / root flasher (device check: `surya` / `karna`).
3. Hasilnya ada di `/sdcard/boot-<date>-<time>.img` (fallback: `/data/local/tmp`, `/cache`, `/tmp`).
4. Patch image tersebut di aplikasi Magisk/KernelSU, lalu flash image hasil patch-nya.

## Build sendiri

- Pengaturan ada di `anykernel.sh` (`BLOCK`, `BOOTNAME`, device check).
- Windows: jalankan `build-zip.ps1`.
- Linux: `zip -r AK3-BootPuller.zip META-INF anykernel.sh banner tools`
- Isi zip wajib berada di root (`META-INF/`, `anykernel.sh`, `tools/`, `banner`). Jangan flash zip source hasil `Code` -> `Download ZIP` karena GitHub membungkus isinya dalam satu folder dan recovery akan gagal ("Invalid zip file format").
- GitHub Actions otomatis build dan upload ke Release saat push tag `v*`, atau jalankan workflow "Build and release" secara manual.

## English

Flashable AnyKernel3-based zip that dumps the `boot` partition to
`/sdcard/boot-<date>-<time>.img` so it can be patched with Magisk/KernelSU.
It never writes to any partition, so it is safe to flash repeatedly.
Download the latest `AK3-BootPuller.zip` from
[Releases](https://github.com/fannndi/Boot-Image-Puller/releases/latest) and
flash it in TWRP / OrangeFox / any root flasher.

Based on AnyKernel3 by osm0sis (see `LICENSE`).
