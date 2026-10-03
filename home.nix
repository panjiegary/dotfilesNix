{ config, lib, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    # cli i use constantly
    ripgrep   # fast search
    fd        # fast find
    fzf       # fuzzy finder
    jq        # json on the command line
    lazygit
    neovim
    # the font everything renders in
    nerd-fonts.hack
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.NVM_DIR = "${config.home.homeDirectory}/.nvm";
  home.sessionVariables.EZA_CONFIG_DIR = "${config.home.homeDirectory}/.config/eza";

  # Homebrew's nvm formula doesn't create this on its own.
  home.activation.nvmDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/.nvm"
  '';

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;      # ghost text from history
    syntaxHighlighting.enable = true;  # commands turn green when valid
    initContent = ''
      bindkey '^f' autosuggest-accept
      [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
      [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    '';
    shellAliases = {
      ".." = "cd ..";
      vi = "nvim";
      add = "git add .";
      push = "git push";
      pull = "git pull";
      m = "git switch main";
      cc = "claude --dangerously-skip-permissions";
      co = "codex --full-auto";
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };

  programs.starship = {
    enable = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";

      # nerd-font-symbols preset (`starship preset nerd-font-symbols`)
      aws.symbol = " ";
      azure.symbol = " ";
      battery = {
        full_symbol = "󰁹 ";
        charging_symbol = "󰂄 ";
        discharging_symbol = "󰂃 ";
        unknown_symbol = "󰂑 ";
        empty_symbol = "󰂎 ";
      };
      buf.symbol = " ";
      bun.symbol = " ";
      c.symbol = " ";
      cpp.symbol = " ";
      cmake.symbol = " ";
      cobol.symbol = " ";
      conda.symbol = " ";
      container.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      deno.symbol = " ";
      direnv.symbol = " ";
      directory.read_only = " 󰌾";
      docker_context.symbol = " ";
      dotnet.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      erlang.symbol = " ";
      fennel.symbol = " ";
      fortran.symbol = " ";
      fossil_branch.symbol = " ";
      gcloud.symbol = "󱇶 ";
      gleam.symbol = " ";
      git_branch.symbol = " ";
      git_commit.tag_symbol = "  ";
      golang.symbol = " ";
      gradle.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      helm.symbol = " ";
      hg_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      kotlin.symbol = " ";
      kubernetes.symbol = "󱃾 ";
      lua.symbol = " ";
      maven.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      mojo.symbol = "󰈸 ";
      nats.symbol = " ";
      netns.symbol = "󰛳 ";
      nim.symbol = " ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      ocaml.symbol = " ";
      odin.symbol = "󰟢 ";
      opa.symbol = " ";
      openstack.symbol = " ";
      os.symbols = {
        AIX = " ";
        AlmaLinux = " ";
        Alpaquita = " ";
        Alpine = " ";
        ALTLinux = " ";
        Amazon = " ";
        Android = " ";
        AOSC = " ";
        Arch = " ";
        Artix = " ";
        Bluefin = " ";
        CachyOS = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Elementary = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = " ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = " ";
        InstantOS = " ";
        Ios = "󰀷 ";
        Kali = " ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        Nobara = " ";
        OpenBSD = " ";
        OpenCloudOS = " ";
        openEuler = " ";
        openSUSE = " ";
        OracleLinux = "󰺡 ";
        PikaOS = " ";
        Pop = " ";
        Raspbian = " ";
        Redhat = "󱄛 ";
        RedHatEnterprise = "󱄛 ";
        Redox = "󰀘 ";
        RockyLinux = " ";
        Solus = " ";
        SUSE = " ";
        Ubuntu = " ";
        Ultramarine = " ";
        Unknown = " ";
        Uos = " ";
        Void = " ";
        Windows = "󰍲 ";
        Zorin = " ";
      };
      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      pijul_channel.symbol = " ";
      pixi.symbol = "󰏗 ";
      pulumi.symbol = " ";
      purescript.symbol = " ";
      python.symbol = " ";
      raku.symbol = "󱖊 ";
      red.symbol = "󱍼 ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";
      rust.symbol = "󱘗 ";
      scala.symbol = " ";
      shlvl.symbol = "󰹍 ";
      singularity.symbol = " ";
      solidity.symbol = " ";
      spack.symbol = " ";
      status.symbol = " ";
      sudo.symbol = " ";
      swift.symbol = " ";
      terraform.symbol = " ";
      vlang.symbol = " ";
      typst.symbol = " ";
      vagrant.symbol = " ";
      xmake.symbol = " ";
      zig.symbol = " ";
    };
  };

  # Edit-in-place: the real file stays in my repo, ~/.config just points at it.
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";
  home.file.".config/herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr";
  home.file.".config/eza".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/eza";
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.claude/settings.json";

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".codex/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".config/opencode/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
}
