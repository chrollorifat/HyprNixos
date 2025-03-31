{pkgs, ...}: {
  force = true;
  default = "Brave";
  privateDefault = "Searx";
  order = [
    "Brave"
    "Startpage"
    "Searx"
    "NixOS Packages"
    "NixOS Options"
    "NixOS Wiki"
    "Home Manager Options"
    "google"
  ];
  engines = {
    "Startpage" = {
      urls = [
        {
          template = "https://www.startpage.com/sp/search?query={searchTerms}&prfe=c602752472dd4a3d8286a7ce441403da08e5c4656092384ed3091a946a5a4a4c99962d0935b509f2866ff1fdeaa3c33a007d4d26e89149869f2f7d0bdfdb1b51aa7ae7f5f17ff4a233ff313d";
        }
      ];
      # icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      icon = "https://www.startpage.com/sp/cdn/favicons/favicon-gradient.ico";
      definedAliases = ["@sp"];
      updateInterval = 24 * 60 * 60 * 1000;
    };
    "Brave" = {
      urls = [
        {
          template = "https://search.brave.com/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://brave.com/static-assets/images/brave-logo-sans-text.svg";
      definedAliases = ["@br"];
      updateInterval = 24 * 60 * 60 * 1000;
    };
    "Searx" = {
      urls = [{template = "https://searx.aicampground.com/?q={searchTerms}";}];
      # icon = "https://nixos.wiki/favicon.png";
      icon = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/searxng/searxng/edf6d96625444b5b214b4ca0e2885467ed265411/src/brand/searxng-wordmark.svg";
        sha256 = "sha256:0lnc0cf7rgl6a54zm4i5z3i3npp87bg9kmwf5mii88gys980y32g";
      };
      definedAliases = ["@sx"];
    };
    "NixOS Packages" = {
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@np" "@nixpkgs"];
    };
    "NixOS Options" = {
      urls = [
        {
          template = "https://search.nixos.org/options";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@no" "@nixopts"];
    };
    "NixOS Wiki" = {
      urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
      icon = "https://wiki.nixos.org/favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["@nw"];
    };
    "Home Manager" = {
      urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}";}];
      # urls = [
      #   {
      #     template = "https://mipmip.github.io/home-manager-option-search";
      #     params = [
      #       {
      #         name = "query";
      #         value = "{searchTerms}";
      #       }
      #     ];
      #   }
      # ];
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@hm" "@home" "'homeman"];
    };
    "My NixOS" = {
    urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
    definedAliases = [
        "@mn"
        "@nx"
        "@mynixos"
    ];
    };
    "Noogle" = {
    urls = [{template = "https://noogle.dev/q?term={searchTerms}";}];
    iconUpdateUrl = "https://noogle.dev/favicon.png";
    updateInterval = 24 * 60 * 60 * 1000;
    definedAliases = [
        "@noogle"
        "@ng"
    ];
    };
    "bing".metaData.hidden = true;
    "Ebay".metaData.hidden = true;
    "google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
  };
}
