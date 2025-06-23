{
  config,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  environment.pathsToLink = [ "/share/bash-completion" ];
  home-manager.users.eax =
    { pkgs, fonts, ... }:
    {
      home.packages = [ ];
      home.stateVersion = "23.05";
      home.sessionVariables = {
        EDITOR = "nvim";
        LESS = "-asrRix8F";
        GRIM_DEFAULT_DIR = "/home/eax/pic/";
        PLAN9 = "${pkgs.plan9port}/plan9";
        XDG_DESKTOP_DIR = "/home/eax/desktop";
        XDG_DOWNLOAD_DIR = "/home/eax/downloads";
      };
      home.shellAliases = {
        "dn" = "makoctl dismiss -a";
        "grimslurp" = ''grim -g "$(slurp)"'';
        "unzip" = "unzrip";
      };
      home.file = {
        ".gitconfig".text = ''
          [init]
            defaultBranch = main
          [push]
            default = current
          [color]
            ui = auto
          [alias]
            aa = add --all
            ap = add --patch
            branches = for-each-ref --sort=-committerdate --format=\"%(color:blue)%(authordate:relative)\t%(color:red)%(authorname)\t%(color:white)%(color:bold)%(refname:short)\" refs/remotes
            ci = commit
            co = checkout
            pf = push --force-with-lease
            st = status
            br = branch
          [core]
              excludesfile = ~/.gitignore
              autocrlf = input
          [merge]
            ff = only
          [fetch]
            prune = true
          [rebase]
            autosquash = true
          [include]
            path = ~/.gitconfig.local
          [diff]
            colorMoved = zebra
          [user]
              email = 55966724+ealvar3z@users.noreply.github.com
              name = ealvar3z
          [pull]
              rebase = true
        '';
        ".gitignore".text = ''
          *.pyc
          *.sw[nop]
          .DS_Store
          .bundle
          .byebug_history
          .env
          .git/
          w3m/.w3m/w3mcache*
          w3m/.w3m/w3msrc*
          w3m/.w3m/w3mtmp*
          w3m/.w3m/history
          /bower_components/
          /log
          /node_modules/
          /tmp
          db/*.sqlite3
          log/*.log
          rerun.txt
          tmp/**/*
          /tags

          .idea/
          .ionide/
          .projectile/
          .vscode
          .vscode/
          .zed

          dump.rdb
          acme.dump
        '';
        ".gitattributes".text = ''
          *.css      diff=csxir
          *.exs      diff=elixir
          *.exs      diff=elixir
          *.html     diff=html
          *.go       diff=golang
          *.md       diff=markdown
          *.org      diff=org
          *.py       diff=python
          *_spec.rb  diff=rspec
          *.gemspec  diff=ruby
          *.rake     diff=ruby
          *.rb       diff=ruby
          *.rs       diff=rusts
          *.ex       diff=elixir
          *.exs      diff=elixir
          *.exs      diff=elixir
          *.html     diff=html
          *.go       diff=golang
          *.md       diff=markdown
          *.org      diff=org
          *.py       diff=python
          *_spec.rb  diff=rspec
          *.gemspec  diff=ruby
          *.rake     diff=ruby
          *.rb       diff=ruby
          *.rs       diff=rust
        '';
      };

      programs = {
        bash = {
          enable = true;
          historyFile = "$HOME/.history";
          historyControl = [
            "erasedups"
            "ignoredups"
            "ignorespace"
          ];
          bashrcExtra = ''
            export PS1="; "
          '';
        };
        neovim = {
          enable = true;
          viAlias = true;
          vimAlias = true;
          coc = {
            enable = true;
            settings = {
              languageserver = {
                nix = {
                  command = "nil";
                  filetypes = [ "nix" ];
                  rootPatterns = [ "flake.nix" ];
                  settings.nil.formatting.command = [ "nixfmt" ];
                };
                go = {
                  command = "gopls";
                  filetypes = [ "go" ];
                  rootPatterns = [
                    "go.work"
                    "go.mod"
                    ".vim/"
                    ".git/"
                    ".hg/"
                  ];
                };
              };
              coc.preferences.formatOnSaveFiletypes = [
                "nix"
                "go"
              ];
            };
          };

          extraConfig = ''
            set termguicolors
            set clipboard=unnamedplus
            set syntax=off
          '';

          plugins = with pkgs.vimPlugins; [
            {
              plugin = vacme-vim;
              config = "colorscheme vacme";
            }
            {
              plugin = nvim-lastplace;
              config = ''
                lua require'nvim-lastplace'.setup{}
                let g:lastplace_ignore_buftype = "quickfix,nofile,help"
                let g:lastplace_ignore_filetype = "gitcommit,gitrebase,svn,hgcommit"
                let g:lastplace_open_folds = 1
              '';
            }
            vim-go
          ];
        };
        foot = {
          enable = true;
          settings = {
            main = {
              term = "xterm-256color";
              font = "VGA:size=12";
              font-bold = "VGA:size=12";
              font-italic = "VGA:size=12";
            };
            cursor.color = "45363b 45363b";
            colors = {
              background = "FFFFFF";
              foreground = "45363b";

              regular0 = "20111a";
              regular1 = "bd100d";
              regular2 = "858062";
              regular3 = "e9a448";
              regular4 = "416978";
              regular5 = "96522b";
              regular6 = "98999c";
              regular7 = "958b83";

              bright0 = "5e5252";
              bright1 = "bd100d";
              bright2 = "858062";
              bright3 = "e9a448";
              bright4 = "416978";
              bright5 = "96522b";
              bright6 = "98999c";
              bright7 = "d4ccb9";
            };
          };
        };
      };

      services = {
        mako = {
          enable = true;
          font = "VGA 12";
          anchor = "top-left";
          output = "HDMI-A-1";
          backgroundColor = "#FFFFFFFF";
          textColor = "#000000FF";
          borderColor = "#55aaaaFF";
          borderSize = 4;
          format = "%s\\n%b";
        };
      };

      wayland.windowManager.sway = {
        enable = true;
        #unfortunately we can not use these flags with homemanger
        config = {
          modifier = "Mod4";
          terminal = "foot";
          bars = [ ];
          colors = {
            focused = {
              background = "#000000";
              border = "#55aaaa";
              text = "#000000";
              childBorder = "#55aaaa";
              indicator = "#000000";
            };
            unfocused = {
              background = "#b2b2b2";
              border = "#9eeeee";
              text = "#000000";
              childBorder = "#9eeeee";
              indicator = "#000000";
            };
          };
          window.commands = [
            {
              command = "border pixel 4";
              criteria = {
                title = "[.]*";
                app_id = "[.]*";
                class = "[.]*";
              };
            }
          ];
          # tiling is for nerds
          floating.criteria = [
            { title = "[.]*"; }
            { app_id = "[.]*"; }
            { class = "[.]*"; }
          ];
          output =
            {
              "tachikoma" = {
                HDMI-A-1 = {
                  bg = "#b2b2b2 solid_color";
                  mode = "1920x1080@60Hz";
                  pos = "5120 700";
                  transform = "normal";
                };
            }
            ."${config.networking.hostName}";
        };
      };
    };

}
