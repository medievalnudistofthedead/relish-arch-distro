# Contributing to Relish Arch Linux

Thank you for your interest in contributing! This document provides guidelines for contributing to the project.

## 🤝 How to Contribute

### Reporting Issues

1. Check if the issue already exists
2. Use the issue template
3. Provide detailed information:
   - System information (`uname -a`, `pacman -Q`)
   - Steps to reproduce
   - Expected vs actual behavior
   - Relevant logs

### Suggesting Enhancements

1. Check existing feature requests
2. Describe the enhancement clearly
3. Explain why it would be useful
4. Provide examples if possible

### Contributing Code

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test thoroughly
5. Commit with clear messages
6. Push to your fork
7. Open a Pull Request

## 📦 Adding Packages

### New Package Guidelines

Packages should:
- Be useful to the target audience
- Not be available in official Arch repos (unless customized)
- Have proper licensing
- Include clear documentation

### PKGBUILD Standards

Follow Arch Linux PKGBUILD standards:
- Use proper variable names
- Include checksums (not SKIP in production)
- Test in clean chroot
- Include all dependencies
- Follow naming conventions

Example:

```bash
# Maintainer: Your Name <email@example.com>
pkgname=package-name
pkgver=1.0.0
pkgrel=1
pkgdesc="Clear, concise description"
arch=('x86_64')
url="https://upstream-url.com"
license=('MIT')
depends=('dependency1' 'dependency2')
makedepends=('build-dependency1')
source=("$pkgname-$pkgver.tar.gz::https://source-url.com/archive/$pkgver.tar.gz")
sha256sums=('actual-checksum-here')

build() {
    cd "$pkgname-$pkgver"
    ./configure --prefix=/usr
    make
}

package() {
    cd "$pkgname-$pkgver"
    make DESTDIR="$pkgdir" install
}
```

## 📝 Documentation

### Writing Documentation

- Use clear, concise language
- Include code examples
- Add screenshots where helpful
- Keep formatting consistent
- Test all commands

### Documentation Structure

- **README.md**: Project overview and quick start
- **docs/**: Detailed documentation
  - **INSTALL.md**: Installation guide
  - **REPOSITORY.md**: Repository setup
  - **CUSTOMIZATION.md**: Customization options
  - **CONTRIBUTING.md**: This file

## 🧪 Testing

### Before Submitting

Test your changes:

1. **Local build**: Verify package builds locally
2. **Clean install**: Test in fresh VM/container
3. **Documentation**: Verify docs are accurate
4. **Conflicts**: Check for package conflicts

### Testing Environments

- VirtualBox/QEMU VM
- Docker container with Arch Linux
- Separate test partition

## 🎨 Code Style

### Bash Scripts

- Use `#!/bin/bash` shebang
- Enable error handling: `set -e`
- Use meaningful variable names
- Add comments for complex logic
- Follow [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)

Example:

```bash
#!/bin/bash
# Description of what this script does

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONSTANT_VAR="value"

function descriptive_function_name() {
    local local_var="$1"
    
    # Do something
    echo "Processing: $local_var"
}

# Main execution
main() {
    descriptive_function_name "argument"
}

main "$@"
```

### Markdown

- Use consistent heading levels
- Add blank lines around code blocks
- Use proper list formatting
- Include links where relevant

## 🔄 Pull Request Process

1. **Update documentation** if needed
2. **Test your changes** thoroughly
3. **Update CHANGELOG** if significant
4. **Reference issues** being fixed
5. **Request review** from maintainers

### PR Title Format

- `feat: Add new feature`
- `fix: Fix bug in component`
- `docs: Update documentation`
- `refactor: Refactor code`
- `test: Add tests`
- `chore: Update dependencies`

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## Testing
How was this tested?

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] All tests pass
- [ ] No new warnings
```

## 🏗️ Project Structure

Understanding the structure helps contribute effectively:

```
relish-arch-distro/
├── .github/workflows/    # CI/CD automation
├── configs/              # System configurations
├── docs/                 # Documentation
├── iso/                  # ISO building
├── package-lists/        # Package inventories
├── packages/             # Package repository
│   ├── pkgbuilds/       # Source PKGBUILDs
│   └── x86_64/          # Built packages
└── scripts/              # Installation scripts
```

## 🐛 Debugging

### Common Issues

**Build failures:**
```bash
cd packages/pkgbuilds/package-name
makepkg -sf --noconfirm
```

**Repository database issues:**
```bash
cd packages
rm x86_64/relish-repo.db*
./update-repo.sh
```

**Git issues:**
```bash
git status
git diff
git log --oneline -5
```

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🎓 Learning Resources

### Arch Linux

- [Arch Wiki](https://wiki.archlinux.org/)
- [PKGBUILD Guide](https://wiki.archlinux.org/title/PKGBUILD)
- [Arch Build System](https://wiki.archlinux.org/title/Arch_Build_System)

### Tools

- [archiso](https://wiki.archlinux.org/title/Archiso)
- [makepkg](https://wiki.archlinux.org/title/Makepkg)
- [pacman](https://wiki.archlinux.org/title/Pacman)

## 💬 Communication

- **Issues**: Technical problems and bugs
- **Discussions**: General questions and ideas
- **Pull Requests**: Code contributions

## 🙏 Acknowledgments

Contributors are recognized in:
- README.md contributors section
- Release notes
- Git history

Thank you for contributing to Relish Arch Linux! 🎉
