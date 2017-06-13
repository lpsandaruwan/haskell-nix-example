# haskell-nix-example
Example HTTP API for a file server, with Nix package manager.

#### Getting started
Make sure you have installed nix. If not see, [http://nixos.org/nix/manual/#chap-installation](http://nixos.org/nix/manual/#chap-installation).
And now,
```bash
cd app
cabal2nix --shell . > shell.nix
nix-shell
```

On the appearing nix-shell run,
```bash
cabal configure
cabal run
```

Now you have the working application.

To check the status of running server,
```bash
curl -v "http://localhost:4000"
```

To test file uploads,
```bash
curl -i -X POST  -F "file=@FILENAME" http://localhost:4000/files/upload
```