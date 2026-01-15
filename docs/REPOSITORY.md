# Package Repository Setup Guide

This guide explains how to set up and use the Relish Arch Linux package repository.

## Table of Contents

- [Repository Structure](#repository-structure)
- [Building Packages Locally](#building-packages-locally)
- [Adding Packages to the Repository](#adding-packages-to-the-repository)
- [Using the Repository](#using-the-repository)
- [GitHub Pages Deployment](#github-pages-deployment)
- [Automated Builds](#automated-builds)

## Repository Structure

```
packages/
├── x86_64/                    # Binary packages and repository database
│   ├── *.pkg.tar.zst         # Built packages
│   ├── relish-repo.db.tar.gz # Repository database
│   └── relish-repo.files.tar.gz
├── pkgbuilds/                # PKGBUILD sources
│   ├── package-1/
│   │   └── PKGBUILD
│   └── package-2/
│       └── PKGBUILD
├── build-package.sh          # Build single package
├── build-all.sh              # Build all packages
└── update-repo.sh            # Update repository database
```

## Building Packages Locally

### Prerequisites

Install required tools:

```bash
sudo pacman -S base-devel git
```

### Build a Single Package

1. Create a PKGBUILD directory:

```bash
cd packages/pkgbuilds
mkdir my-package
cd my-package
```

2. Create or copy your PKGBUILD file

3. Build the package:

```bash
cd ../../  # Back to packages directory
./build-package.sh pkgbuilds/my-package
```

### Build All Packages

```bash
cd packages
./build-all.sh
```

This will:
- Build all packages in `pkgbuilds/`
- Place built packages in `x86_64/`
- Automatically update the repository database

## Adding Packages to the Repository

### Method 1: Custom PKGBUILD

Create your own PKGBUILD:

```bash
cd packages/pkgbuilds
mkdir my-custom-package
cd my-custom-package
```

Example PKGBUILD:

```bash
# Maintainer: Your Name <your.email@example.com>
pkgname=my-custom-package
pkgver=1.0.0
pkgrel=1
pkgdesc="My custom package description"
arch=('x86_64')
url="https://github.com/yourusername/my-package"
license=('MIT')
depends=('dependency1' 'dependency2')
source=("https://github.com/yourusername/my-package/archive/v${pkgver}.tar.gz")
sha256sums=('SKIP')

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"
    install -Dm755 my-binary "${pkgdir}/usr/bin/my-binary"
    install -Dm644 LICENSE "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
}
```

### Method 2: AUR Package

To pre-build an AUR package for your repository:

```bash
cd packages/pkgbuilds
git clone https://aur.archlinux.org/package-name.git
cd ../
./build-package.sh pkgbuilds/package-name
```

### Update Repository Database

After building packages:

```bash
cd packages
./update-repo.sh
```

## Using the Repository

### Local Usage

Add to `/etc/pacman.conf`:

```ini
[relish-repo]
SigLevel = Optional TrustAll
Server = file:///home/yourusername/Projects/relish-arch-distro/packages/$arch
```

Update and install:

```bash
sudo pacman -Sy
sudo pacman -S your-package
```

### GitHub Pages Usage

After deploying to GitHub Pages, add to `/etc/pacman.conf`:

```ini
[relish-repo]
SigLevel = Optional TrustAll
Server = https://yourusername.github.io/relish-arch-distro/$arch
```

Update and install:

```bash
sudo pacman -Sy
sudo pacman -S your-package
```

## GitHub Pages Deployment

### Initial Setup

1. **Enable GitHub Pages** in your repository settings:
   - Go to Settings → Pages
   - Source: GitHub Actions

2. **Push your repository**:

```bash
cd ~/Projects/relish-arch-distro
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/yourusername/relish-arch-distro.git
git push -u origin main
```

3. **Trigger the workflow**:
   - The workflow will run automatically when you push changes to `packages/pkgbuilds/`
   - Or manually trigger it from Actions tab

### Repository URL

After deployment, your repository will be available at:

```
https://yourusername.github.io/relish-arch-distro/x86_64
```

## Automated Builds

### GitHub Actions Workflow

The repository includes two workflows:

1. **build-packages.yml**: Builds packages when PKGBUILDs change
2. **deploy-repo.yml**: Deploys the repository to GitHub Pages

### Triggering Builds

Builds are triggered automatically when:
- You push changes to `packages/pkgbuilds/**`
- You create a pull request modifying PKGBUILDs

Manual trigger:
- Go to Actions tab → Build Packages → Run workflow

### Build Process

1. Spins up an Arch Linux container
2. Installs build dependencies
3. Creates a non-root build user
4. Builds all packages
5. Updates repository database
6. Uploads artifacts
7. Deploys to GitHub Pages (on main branch)

## Package Signing (Advanced)

### Generate GPG Key

```bash
gpg --full-generate-key
```

### Export Public Key

```bash
gpg --armor --export your-key-id > relish-repo.gpg
```

### Sign Packages

Add to PKGBUILD or makepkg.conf:

```bash
BUILDENV=(!distcc color !ccache check sign)
GPGKEY="your-key-id"
```

### Update pacman.conf

```ini
[relish-repo]
SigLevel = Required DatabaseOptional
Server = https://yourusername.github.io/relish-arch-distro/$arch
```

Import the key:

```bash
sudo pacman-key --add relish-repo.gpg
sudo pacman-key --lsign-key your-key-id
```

## Troubleshooting

### Build Failures

Check logs:

```bash
cd packages/pkgbuilds/failing-package
makepkg -sf
```

### Repository Not Found

Ensure:
- GitHub Pages is enabled
- Workflow has completed successfully
- URL in pacman.conf is correct

### Permission Errors

Ensure scripts are executable:

```bash
chmod +x packages/*.sh
```

### Package Not Appearing

After building, run:

```bash
cd packages
./update-repo.sh
sudo pacman -Sy
```

## Best Practices

1. **Version Control**: Keep PKGBUILDs in version control
2. **Testing**: Test packages locally before deploying
3. **Documentation**: Document dependencies and build instructions
4. **Naming**: Use descriptive package names
5. **Checksums**: Use proper checksums (not SKIP) in production
6. **Clean Builds**: Use clean chroot for reproducible builds

## Example: Adding Your First Package

```bash
# 1. Create PKGBUILD directory
cd ~/Projects/relish-arch-distro/packages/pkgbuilds
mkdir hello-world
cd hello-world

# 2. Create PKGBUILD
cat > PKGBUILD << 'EOF'
pkgname=hello-world
pkgver=1.0.0
pkgrel=1
pkgdesc="A simple hello world package"
arch=('any')
license=('MIT')

package() {
    mkdir -p "${pkgdir}/usr/bin"
    echo '#!/bin/bash' > "${pkgdir}/usr/bin/hello-world"
    echo 'echo "Hello from Relish Arch!"' >> "${pkgdir}/usr/bin/hello-world"
    chmod +x "${pkgdir}/usr/bin/hello-world"
}
EOF

# 3. Build the package
cd ../../
./build-package.sh pkgbuilds/hello-world

# 4. Update repository
./update-repo.sh

# 5. Test locally
sudo pacman -Sy relish-repo/hello-world
hello-world

# 6. Commit and push
cd ~/Projects/relish-arch-distro
git add packages/pkgbuilds/hello-world
git commit -m "Add hello-world package"
git push
```

## Next Steps

- [Create Custom ISO](ISO.md)
- [Add System Configurations](CUSTOMIZATION.md)
- [Build Installation Scripts](INSTALL.md)
