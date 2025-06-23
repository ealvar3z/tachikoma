{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

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
      "scard"
    ];
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
    gh
    gnumake
    go
    gopls
    grim
    htop
    hunspell
    hunspellDicts.en_US
    imv
    jq
    keyd
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
  services.avahi.enable = true;
  services.openssh.enable = true;
  services.keyd = {
    enable = true;
    keyboards = {
      defaults = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
            esc = "capslock";
          };
        };
      };
    };
  };
  programs.gnupg.agent = {
    enable = true;
  };
  networking.firewall.enable = false;

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
