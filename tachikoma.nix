{
  config,
  lib,
  pkgs,
  ...
}:
{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_13;
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "cubic";
  };

  networking.hostName = "tachikoma";
  networking.wireless.enable = false;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
    ];

  };
  users.users.eax = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
    ];
  };

  fileSystems = {
    "/media" = {
      device = "/dev/disk/by-uuid/9dd50c72-23a0-42dd-9648-b41e938ad98c";
      options = [ "nofail" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    bemenu
    chromium
    curl
    dolphin-emu
    drawterm-wayland
    ed
    ffmpeg
    file
    firefox
    gcc
    git
    gnumake
    go
    gopls
    grim
    htop
    hunspell
    hunspellDicts.en_US
    imv
    jq
    libnotify
    llm
    mako
    man-pages
    man-pages-posix
    mpv
    nawk
    nil
    nixfmt-rfc-style
    nixpkgs-review
    passage
    pavucontrol
    pc
    pinentry-curses
    pipewire
    plan9port
    python3
    qemu
    qemu_kvm
    radare2
    rbw
    rc-9front
    senpai
    slurp
    sway
    telegram-desktop
    thunderbird
    tlsclient
    tmux
    transmission_3-gtk
    unzrip
    vlc
    wayland
    wdisplays
    wget
    wl-clipboard
    wlclock
    xdg-utils
    xfce.thunar
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [ obs-pipewire-audio-capture ];
    })
    signal-desktop
    prismlauncher
    intel-gpu-tools
  ];

  services.udev.packages = [ pkgs.dolphin-emu ];
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
  };
  services.avahi.enable = true;
  networking.firewall.enable = false;
  services.openssh.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
