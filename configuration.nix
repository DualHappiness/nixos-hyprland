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

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      ibus.engines = with pkgs.ibus-engines; [
        libpinyin
        rime
      ];
      fcitx5 = {
        addons = with pkgs; [
          rime-data
          fcitx5-gtk
          fcitx5-rime
          fcitx5-chinese-addons
          fcitx5-material-color
          fcitx5-pinyin-zhwiki
          fcitx5-pinyin-moegirl
        ];
      };
    };
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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dual = {
    isNormalUser = true;
    description = "dual";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    password = " ";
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
    nix-search-cli

    nixd
    nixfmt-rfc-style

    busybox
  ];

  # v2raya
  services.v2raya.enable = true;

  # Setup default shell
  users.defaultUserShell = pkgs.nushell;
  environment.shells = with pkgs; [ nushell ];

  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # optimize nix store
  boot.loader.systemd-boot.configurationLimit = 10;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;

  nix.package = pkgs.nixStable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = version;
  nix.registry.nixpkgs.flake = nixpkgs;
  nix.registry.nixpkgs-unstable.flake = nixpkgs-unstable;
  nix.channel.enable = false;
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  environment.etc."nix/inputs/nixpkgs-unstable".source = "${nixpkgs-unstable}";
  nix.settings.nix-path = lib.mkForce [
    "nixpkgs=/etc/nix/inputs/nixpkgs"
    "nixpkgs-unstable=/etc/nix/inputs/nixpkgs-unstable"
  ];

  nix.settings = {
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
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
