# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  lib,
  pkgs,
  version,
  nixpkgs,
  nixpkgs-unstable,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  networking.hostName = "nixos"; # Define your hostname.
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };
  networking.extraHosts = ''
    123.60.141.172 pony-relay.zelostech.com.cn
  '';

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "zh_CN.UTF-8/UTF-8" ];
  };
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.fprintd.enable = true;
  services.thermald.enable = true;

  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_DRIVER_OPMODE_ON_AC = "passive";
    CPU_DRIVER_OPMODE_ON_BAT = "passive";

    CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
    CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

    CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dual = {
    isNormalUser = true;
    description = "dual";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # default packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    ripgrep
    lsd
    fd
    gcc
    glibc
    getent
    python3
    fontconfig

    busybox

    nvd
    nix-search-cli
    nix-output-monitor

    nautilus

    docker-credential-helpers
  ];

  # v2raya
  services.v2raya.enable = true;

  # Setup default shell
  users.defaultUserShell = pkgs.nushell;
  environment.shells = with pkgs; [ nushell ];

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      daemon.settings = {
        log-driver = "journald";
        storage-driver = "overlay2";
      };
    };
  };

  # optimize nix store
  boot.loader.systemd-boot.configurationLimit = 10;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 5 --keep-since 3d";
    flake = "/etc/nixos";
  };

  system.stateVersion = version;
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  environment.etc."nix/inputs/nixpkgs-unstable".source = "${nixpkgs-unstable}";
  nix = {
    package = pkgs.nixStable;
    registry.nixpkgs.flake = nixpkgs;
    registry.nixpkgs-unstable.flake = nixpkgs-unstable;
    channel.enable = false;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      nix-path = lib.mkForce [
        "nixpkgs=/etc/nix/inputs/nixpkgs"
        "nixpkgs-unstable=/etc/nix/inputs/nixpkgs-unstable"
      ];
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://hyprland.cachix.org"
      ];
      trusted-substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  # auto mount
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.openvpn.servers = {
    zelos = {
      autoStart = false;
      config = ''config /home/dual/.config/openvpn/zelos.ovpn'';
    };
  };

  services.fwupd.enable = true;

  programs.ssh.startAgent = true;
  programs.ssh.extraConfig = ''
    ForwardAgent yes
  '';

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };

  services.gnome.gnome-keyring.enable = true;
}
