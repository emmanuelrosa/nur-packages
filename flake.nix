{
  description = "Emmanuel's personal NUR repository; A proxy for my erosanix Nix flake.";
  inputs.erosanix.url = "github:emmanuelrosa/erosanix/master";

  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, erosanix, flake-compat }: erosanix; 
}
