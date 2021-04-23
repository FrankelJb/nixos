{ config, pkgs, ...}:

{
  nixpkgs.config.allowUnfree = true;
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  
  home.packages = with pkgs; [
    ant-dracula-theme # GTK theme
    bat
    ffmpeg
    ffmpegthumbnailer
    fd
    fish
    fzf
    geeqie
    keepassxc
    kitty
    lxappearance
    mate.caja
    mpv
    ncdu  # CLI disk usage analyzer
    neovim
    ripgrep
    p7zip
    starship
    theme-obsidian2 # GTK theme
    telnet
    unrar
    veracrypt
    vlc
    wget
    xfce.thunar
    xfce.tumbler

    # nvim, and its runtime dependencies
    # (callPackage ./nvim {})
    # (pkgs.callPackage ./xterm-24bit.nix {})

  ];

  programs = {
    fish = {
      enable = true;
      plugins = [{
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "patrickF1";
          repo = "fzf.fish";
          rev = "v6.2";
          sha256 = "0yjjyid8mkcizcl8g3ixf87mf3hlgxmgkvixq67bya3fx08b13s8";
        };
      }];
    };

    home-manager.enable = true;

    rofi = {
      enable = true;
      font = "Monospace 24"; /* For larger DPIs */
      padding = 10;
      theme = "fancy";
      # Uhh, https://github.com/davatorium/rofi/pull/1074
      # terminal = "${pkgs.gnome3.gnome_terminal}/bin/gnome-terminal";
    };
  
    starship.enable = true;

    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        dracula-vim
        vim-nix
      ];
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
