{
  pkgs,
  lib,
  ...
}:
pkgs.writeShellScriptBin "tmux-sessionizer" ''
  tmux="${pkgs.tmux}/bin/tmux"
  fzf="${pkgs.fzf}/bin/fzf"
  if [[ $# -eq 1 ]]; then
      selected="$1"
  else
   selected=$(realpath $(${lib.getExe pkgs.fd} --min-depth 1 --max-depth 1 --type d . ~/ /etc/nixos/ ~/git-clone/ /mnt/ /mnt/*/Projects/ /mnt/*/Media/ /mnt/*/Pimsleur/ /mnt/*/Languages/ | $fzf))
  fi

  if [[ -z "$selected" ]]; then
      exit 0
  fi

  # return project name with space replaced with -
  selected_name=$(echo "$selected" | sed "s/\s/-/g" | sed "s/.*\///")
  # selected_name=$(basename "$selected" | tr . _)

  tmux_running=$(pgrep tmux)

  if [[ -z "$TMUX" ]] || [[ -z "$tmux_running" ]]; then
      $tmux new-session -A -s "$selected_name" -c "$selected"
      exit 0
  fi

  if ! $tmux has-session -t="$selected_name" 2> /dev/null; then
      $tmux new-session -ds "$selected_name" -c "$selected"
  fi

  $tmux switch-client -t "$selected_name"
  # $tmux attach-session -t "$selected_name"
''
