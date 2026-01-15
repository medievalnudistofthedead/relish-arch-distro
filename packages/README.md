# Package Repository

This directory contains the custom package repository for Relish Arch Linux.

## Structure

```
packages/
├── x86_64/              # Built binary packages and repository database
├── pkgbuilds/           # PKGBUILD sources for custom packages
├── build-package.sh     # Script to build a single package
├── build-all.sh         # Script to build all packages
└── update-repo.sh       # Script to update repository database
```

## Usage

### Building a Package

```bash
cd packages
./build-package.sh pkgbuilds/package-name
```

### Building All Packages

```bash
cd packages
./build-all.sh
```

### Updating Repository Database

After building packages, update the repository database:

```bash
cd packages
./update-repo.sh
```

This will create/update the repository database in `x86_64/relish-repo.db.tar.gz`.

## Adding to Your System

Add this repository to `/etc/pacman.conf`:

```ini
[relish-repo]
SigLevel = Optional TrustAll
Server = file:///path/to/relish-arch-distro/packages/$arch
```

Or for the hosted version:

```ini
[relish-repo]
SigLevel = Optional TrustAll
Server = https://yourusername.github.io/relish-arch-distro/$arch
```

## Package Signing (Optional)

To enable package signing:

1. Generate a GPG key
2. Add signing to PKGBUILD
3. Update SigLevel in pacman.conf
