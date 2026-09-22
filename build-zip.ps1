$ErrorActionPreference = 'Stop';

$root = $PSScriptRoot;
$dst = Join-Path $root 'AK3-BootPuller.zip';

Add-Type -AssemblyName System.IO.Compression;
Add-Type -AssemblyName System.IO.Compression.FileSystem;

function Get-ZipAttributes([long]$mode) {
  $u = [uint32]($mode -band 0xFFFFFFFFL);
  return [System.BitConverter]::ToInt32([System.BitConverter]::GetBytes($u), 0);
}

if (Test-Path -LiteralPath $dst) { Remove-Item -LiteralPath $dst -Force; }

$files = @(
  'META-INF/com/google/android/update-binary',
  'META-INF/com/google/android/updater-script',
  'anykernel.sh',
  'banner',
  'tools/ak3-core.sh',
  'tools/busybox'
);
$dirs = @('META-INF/', 'META-INF/com/', 'META-INF/com/google/', 'META-INF/com/google/android/', 'tools/');

$fs = [System.IO.File]::Open($dst, [System.IO.FileMode]::CreateNew);
try {
  $zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create);
  try {
    foreach ($d in $dirs) {
      $de = $zip.CreateEntry($d, [System.IO.Compression.CompressionLevel]::NoCompression);
      $de.ExternalAttributes = Get-ZipAttributes 0x41ED0000;
    }
    foreach ($f in $files) {
      $full = Join-Path $root ($f -replace '/', '\');
      if (!(Test-Path -LiteralPath $full)) { throw "Missing file: $full" }
      $entry = $zip.CreateEntry($f, [System.IO.Compression.CompressionLevel]::Optimal);
      if ($f -eq 'META-INF/com/google/android/update-binary' -or $f -like 'tools/*') {
        $entry.ExternalAttributes = Get-ZipAttributes 0x81ED0000;
      } else {
        $entry.ExternalAttributes = Get-ZipAttributes 0x81A40000;
      }
      $entry.LastWriteTime = [DateTimeOffset](Get-Item -LiteralPath $full).LastWriteTime;
      $in = [System.IO.File]::OpenRead($full);
      try {
        $out = $entry.Open();
        try { $in.CopyTo($out); } finally { $out.Dispose(); }
      } finally { $in.Dispose(); }
    }
  } finally { $zip.Dispose(); }
} finally { $fs.Dispose(); }

'Built: {0} ({1} bytes)' -f $dst, (Get-Item -LiteralPath $dst).Length;
