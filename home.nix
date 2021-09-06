{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "rafa";
  home.homeDirectory = "/Users/rafa";

  home.stateVersion = "21.11";

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
    (import ./custom-overlays)
  ];

  home.packages = [
    pkgs.stow
    pkgs.git
    pkgs.ag
    pkgs.starship
    pkgs.graphviz
    pkgs.plantuml
    pkgs.nerdfonts
    pkgs.tree-sitter
    pkgs.neovim-nightly
    pkgs.jq
    pkgs.autojump
    pkgs.bat
    pkgs.diff-so-fancy

    pkgs.gnupg
    pkgs.pinentry_mac
    pkgs.yubikey-personalization

    pkgs.Firefox
    pkgs.Rectangle
    pkgs.Alfred
    pkgs.iStatMenus
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.Firefox;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      privacy-badger
      decentraleyes
      clearurls
      cookie-autodelete
      https-everywhere
      multi-account-containers
      vimium
    ];
    profiles = 
      let defaultSettings = {
        "browser.startup.homepage" = "about:blank";
        "browser.search.region" = "GB";
        "browser.search.countryCode" = "GB";
        "browser.search.isUS" = false;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.newtabpage.enabled" = false;
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.uidensity" = 1;
        "browser.urlbar.update1" = true;
        "distribution.searchplugins.defaultLocale" = "en-GB";
        "general.useragent.locale" = "en-GB";
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
        "services.sync.declinedEngines" = "addons,passwords,prefs";
        "services.sync.engine.addons" = false;
        "services.sync.engineStatusChanged.addons" = true;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engineStatusChanged.prefs" = true;
        "signon.rememberSignons" = false;
      };
      in {
        home = {
          id = 0;
          settings = defaultSettings;
          isDefault = true;
      };
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
