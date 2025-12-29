{ lib, ... }:
{
  programs.starship = {
    # Enable starship.
    enable = true;

    settings = {
      add_newline = false;

      # The prompt format string to use.
      format = lib.concatStrings [
        "$line_break"
        "[╭─────┤ ](bold green)$all[├](bold green)$fill[┤](bold green)$character$cmd_duration$line_break"
        "[╰─▶ ](bold green)"
      ];

      cmd_duration = {
        # Minimum time a command must run before starship tells us how long it took.
        min_time = 0;
        # Include milliseconds in the duration.
        show_milliseconds = true;
        # The format string to use.
        format = "took [$duration]($style)";
      };

      character = {
        # The character string to use when the previous command succeeded.
        success_symbol = "[ OK](bold green)";
        # The character string to use when the previous command failed.
        error_symbol = "[ ERROR](bold red)";
      };

      fill = {
        # The symbol to use for spacing $all and $character$cmd_duration.
        # See format above for use.
        symbol = "─";
        style = "bold green";
      };
    };
  };
}
