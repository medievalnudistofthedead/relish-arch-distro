# Relish Arch Linux

A custom Arch Linux distribution built with archiso, tailored for gaming, development, and a beautiful KDE Plasma/Hyprland desktop experience.

## 🎯 Features

- **Pre-configured Desktop Environments**: KDE Plasma and Hyprland
- **Gaming Ready**: Steam, Wine, Proton, and essential gaming tools pre-installed
- **Development Tools**: Complete development environment for Go, Flutter, Python, C/C++, and more
- **Performance Optimized**: AMD GPU optimizations and performance tweaks
- **Beautiful Defaults**: Custom themes (Tokyo, Catppuccin), oh-my-posh, and fastfetch
- **Custom Package Repository**: Pre-built AUR packages and custom configurations

## 📦 Repository Structure

```
relish-arch-distro/
├── iso/                    # Archiso configuration and build scripts
├── packages/               # Custom package repository
├── configs/                # Dotfiles and system configurations
├── scripts/                # Installation and maintenance scripts
├── package-lists/          # Categorized package lists
└── docs/                   # Documentation
```

## 🚀 Quick Start

### Download ISO

Latest release: [Releases Page](https://github.com/yourusername/relish-arch-distro/releases)

### Build from Source

```bash
git clone https://github.com/yourusername/relish-arch-distro.git
cd relish-arch-distro/iso
sudo ./build.sh
```

### Install

1. Boot from the ISO
2. Run the installer: `sudo install-relish`
3. Follow the prompts to customize your installation
4. Reboot and enjoy!

## 📚 Documentation

- [Installation Guide](docs/INSTALL.md)
- [Customization Guide](docs/CUSTOMIZATION.md)
- [Package Repository Setup](docs/REPOSITORY.md)
- [Contributing](docs/CONTRIBUTING.md)

## 🔧 Custom Package Repository

Add this to your `/etc/pacman.conf`:

```ini
[relish-repo]
SigLevel = Optional TrustAll
Server = https://yourusername.github.io/relish-arch-distro/$arch
```

## 📋 System Requirements

- **CPU**: x86_64 architecture
- **RAM**: 2GB minimum, 4GB recommended
- **Storage**: 20GB minimum, 50GB+ recommended
- **GPU**: AMD/NVIDIA/Intel (AMD optimized by default)

## 🤝 Contributing

Contributions are welcome! See [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- Based on [Arch Linux](https://archlinux.org/)
- Built with [archiso](https://gitlab.archlinux.org/archlinux/archiso)
- Inspired by [EndeavourOS](https://endeavouros.com/)

