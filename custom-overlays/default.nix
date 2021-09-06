self: super: {
  Firefox = super.callPackage ./firefox.nix {};
  Rectangle = super.callPackage ./rectangle.nix {};
  Alfred = super.callPackage ./alfred.nix {};
  iStatMenus = super.callPackage ./istatmenus.nix {};
}
