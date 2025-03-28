{
  inputs,
  pkgs,
  ...
}: {
  home-manager.sharedModules = [
      (_: {
        imports = [inputs.nvchad4nix.homeManagerModule];
        programs.nvchad = {
          enable = true;
          extraPlugins = ''
            return {
              {
                "Sly-Harvey/radium.nvim",
                priority = 1000,
              },
              {
                "olimorris/codecompanion.nvim",
                config = true,
                priority = 1100,
                dependencies = {
                  "nvim-lua/plenary.nvim",
                  "nvim-treesitter/nvim-treesitter",
                },
              }, 
            }
          '';
          extraPackages = with pkgs; [
            nixd
            # nodePackages.bash-language-server
            # docker-compose-language-service
            # dockerfile-language-server-nodejs
            # emmet-language-server
            /*
             (python3.withPackages (ps:
            with ps; [
              python-lsp-server
              flake8
            ]))
            */
          ];
          hm-activation = true;
          backup = false;
        };
      })
    ];
}
