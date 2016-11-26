# Overview

Simple bash script hack to roughly benchmark how quickly a file can be uploaded to Dropbox. It times how long Dropbox takes to upload a file with random data.

Testing download is a bit more complex because it needs at least two hosts (future work perhaps).

# Dependencies

The following need to be installed
- `dd`
- `dropbox` (obviously)

# Usage

Benchmark with default size in script, e.g. 10 MB

```bash
$ ./bench_dropbox_upload.sh
```

Benchmark with user specified size (in MB)

```bash
$ ./bench_dropbox_upload.sh 100
```

# Observations

With faster networks, e.g. 20MBit/s or more, a larger random file size helps determine the full potential upload speed (given Dropbox process overhead with syncing smaller files might skew the timing). E.g. on a 100 MBit/s home fibre network:

- 10 MB took 7.306 seconds = 1.368 MB/s
- 100 MB took 24.155 seconds = 4.139 MB/s

Neither of the uploads appeared to saturate the line speed, suggesting that upstream ISP links or Dropbox server capacity was the bottleneck.
