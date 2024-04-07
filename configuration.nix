# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Enable kdeconnect
  programs.kdeconnect.enable = true; 

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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
  users.users.roderick = {
    isNormalUser = true;
    description = "Roderick";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  ## Packages
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # The rest of your configuration here
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    vim
    neofetch
    kate
    brave
    curl
    isoimagewriter
    pkgs.appimage-run
    pkgs.kdePackages.plasma-browser-integration
    pkgs.gnome.gnome-disk-utility
    pkgs.kdePackages.plasma-desktop
    htop
    fontconfig
    freetype
    pkgs.kdePackages.kdeconnect-kde
    pkgs.kdePackages.partitionmanager
    alejandra
    pkgs.kdePackages.kaccounts-integration
    pkgs.kdePackages.kaccounts-providers
    pkgs.kdePackages.korganizer
    pkgs.kdePackages.kio-gdrive
    pkgs.kdePackages.plasma-browser-integration
    pkgs.kdePackages.akonadi-contacts
    pkgs.kdePackages.kcontacts
    pkgs.kdePackages.kdepim-addons
    pkgs.kdePackages.kdepim-runtime
    pkgs.kdePackages.libkdepim
    pkgs.kdePackages.calendarsupport
    pkgs.kdePackages.kcalutils
    pkgs.kdePackages.eventviews
    pkgs.kdePackages.kcalendarcore
    pkgs.kdePackages.akonadi-calendar
    ];
   
    # Firefox Settings
    programs.firefox = {
      enable = true; # Install Firefox
      policies = {
        DisableTelemetry = true;      # Disable Telemetry for Firefox
        DisableFirefoxStudies = true; # Disable Studies (https://support.mozilla.org/en-US/kb/shield)
        EnableTrackingProtection = {  # Disable Tracking
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        # Preinstall needed extensions
        ExtensionSettings = {
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # AdBlock for YouTube
          "jid1-q4sG8pYhq8KGHs@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/adblock-for-youtube/latest.xpi";
            installation_mode = "force_installed";
          };
          # YouTube Search Fixer
          "MinYT@example.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-suite-search-fixer/latest.xpi";
            installation_mode = "force_installed";
          };
          # YouTube Sponsor Blocker
          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };

   # Fonts
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      nerdfonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
              monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
              serif = [ "Noto Serif" "Source Han Serif" ];
              sansSerif = [ "Noto Sans" "Source Han Sans" ];
      };
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
      
  # List services that you want to enable:
  programs.evolution.enable = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;  
  programs.chromium.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  # Add any missing dynamic libraries for unpackaged programs
  # here, NOT in environment.systemPackages
  ];

  ## Backups & Upgrades
  # Backup system config
  system.copySystemConfiguration = true;

  # System Upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  ## Garbage Collection
  # Automatic Garbage Collection
  nix.gc = {
                automatic = true;
                dates = "daily";
                options = "--delete-older-than 3d";
          };

 
 }
