# Boot Image Puller (POCO X3/NFC)

Flashable zip berbasis [AnyKernel3](https://github.com/osm0sis/AnyKernel3) untuk menarik (dump) partisi `boot` ke `/sdcard/boot-YYYYMMDD-HHMMSS.img`, biar bisa di-patch pakai Magisk/KernelSU lalu di-flash balik. Zip ini **tidak menulis/mengubah partisi apa pun**, jadi aman di-flash berulang kali dan hasilnya nggak pernah ketimpa (nama file pakai timestamp).

## Cara pakai

1. Download **`AK3-BootPuller.zip`** dari repo ini (klik filenya, lalu *Download raw file*).
   - Alternatif: klik `Code` → `Download ZIP`, ekstrak, lalu flash file `AK3-BootPuller.zip` yang ada di dalamnya.
   - **Jangan flash langsung** zip hasil `Code` → `Download ZIP`, karena GitHub membungkus isinya dalam satu folder sehingga recovery tidak menemukan `META-INF/` dan gagal ("Invalid zip file format").
2. Flash lewat TWRP / OrangeFox / root flasher (device check: `surya` / `karna`).
3. Hasilnya ada di `/sdcard/boot-<date>-<time>.img` (fallback: `/data/local/tmp`, `/cache`, `/tmp`).
4. Patch image tersebut di aplikasi Magisk/KernelSU, lalu flash image hasil patch-nya.

## Edit / build sendiri

- Pengaturan ada di `anykernel.sh` (`BLOCK`, `BOOTNAME`, device check).
- Setelah diedit, jalankan `build-zip.ps1` (Windows) — atau zip manual dengan isi
  berada di root zip: `META-INF/`, `anykernel.sh`, `tools/`, `banner`.
- Jangan lupa commit ulang `AK3-BootPuller.zip` supaya file di repo selalu sinkron.

## English

Flashable AnyKernel3-based zip that dumps the `boot` partition to
`/sdcard/boot-<date>-<time>.img` so it can be patched with Magisk/KernelSU.
It never writes to any partition, so it is safe to flash repeatedly.
Download and flash `AK3-BootPuller.zip` from this repo. Do not flash the
auto-generated `Code` -> `Download ZIP` archive directly, since GitHub wraps
the files in a folder and recovery cannot find `META-INF/` inside it.

Based on AnyKernel3 by osm0sis (see `LICENSE`).
