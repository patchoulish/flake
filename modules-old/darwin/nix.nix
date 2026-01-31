{
  nix = {
    gc = {
      # Run the GC on the same schedule as NixOS; can't be set in /shared.
      interval = {
        Hour = 3;
        Minute = 15;
      };
    };
  };
}
