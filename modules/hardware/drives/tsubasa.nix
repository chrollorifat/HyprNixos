{...}: {
  fileSystems."/mnt/Tsubasa-Hanekawa" = {
    device = "/dev/disk/by-uuid/40E226A7E226A160";
    fsType = "ntfs-3g";
    options = [
      "X-mount.mkdir"
      "uid=1000"
      "gid=100"
      "noatime"
      "rw"
      "user"
      "exec"
      "umask=000"
      "nofail"
      # "async"
      "windows_names"
      "x-gvfs-show"
      "x-systemd.mount-timeout=7"
    ];
  };
}
