{
  # Add your overlays here
  #
  # my-overlay = import ./my-overlay;
  pendingPR = self: super:
  { 
    bitcoind = super.callPackage ../pkgs/applications/blockchains/bitcoin.nix { miniupnpc = super.miniupnpc_2; withGui = false; };
  };

  fonts = self: super:
  {
    century-gothic = super.callPackage ../pkgs/century-gothic { };
  };
}

