# Quick Start Guide

Get your Relish Arch Linux repository up and running in minutes!

## 📋 Prerequisites

- Arch Linux or Arch-based system
- Git installed
- GitHub account
- Basic knowledge of terminal/bash

## 🚀 Initial Setup (5 minutes)

### Step 1: Clone or Initialize Repository

If you've already created this locally, initialize git:

```bash
cd ~/Projects/relish-arch-distro
git init
git add .
git commit -m "Initial commit: Relish Arch Linux repository structure"
```

### Step 2: Create GitHub Repository

1. Go to https://github.com/new
2. Create a new repository named `relish-arch-distro`
3. **Don't** initialize with README (you already have one)
4. Click "Create repository"

### Step 3: Push to GitHub

```bash
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/relish-arch-distro.git
git push -u origin main
```

### Step 4: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** → **Pages**
3. Under "Source", select **GitHub Actions**
4. Save

That's it! Your repository infrastructure is ready.

## 📦 Adding Your First Package (5 minutes)

### Example: Pre-build an AUR Package

Let's add `yay` (AUR helper) to your repository:

```bash
cd ~/Projects/relish-arch-distro/packages/pkgbuilds

# Clone the AUR package
git clone https://aur.archlinux.org/yay-bin.git

# Build it
cd ..
./build-package.sh pkgbuilds/yay-bin

# Update repository database
./update-repo.sh
```

### Commit and Push

```bash
cd ~/Projects/relish-arch-distro
git add packages/pkgbuilds/yay-bin
git commit -m "Add yay-bin package"
git push
```

GitHub Actions will automatically:
- Build the package
- Update the repository database
- Deploy to GitHub Pages

Check the **Actions** tab to watch the progress!

## 🔧 Using Your Repository

### On Your Local System

Add to `/etc/pacman.conf`:

```ini
[relish-repo]
SigLevel = Optional TrustAll
Server = https://YOUR-USERNAME.github.io/relish-arch-distro/$arch
```

Replace `YOUR-USERNAME` with your GitHub username.

### Update and Install

```bash
sudo pacman -Sy
sudo pacman -S yay-bin
```

## 🎯 Next Steps

Now that you have the basics working, here's what to do next:

### 1. Add More AUR Packages
Build packages you frequently use from AUR:

```bash
cd ~/Projects/relish-arch-distro/packages/pkgbuilds
git clone https://aur.archlinux.org/package-name.git
cd ..
./build-package.sh pkgbuilds/package-name
./update-repo.sh
git add packages/pkgbuilds/package-name
git commit -m "Add package-name"
git push
```

### 2. Create Custom Packages
See [REPOSITORY.md](REPOSITORY.md) for how to create custom packages.

### 3. Export Your Current Packages
Generate a list of all your installed packages:

```bash
pacman -Qqe > package-lists/my-packages.txt
```

### 4. Start Building the ISO
Once you have packages in your repository, move on to creating the custom ISO.

## 🐛 Troubleshooting

### GitHub Actions Failing

Check the Actions tab for error logs. Common issues:
- PKGBUILD syntax errors
- Missing dependencies
- Build timeout (large packages)

### Repository Not Accessible

Wait 2-3 minutes after first deployment. GitHub Pages needs time to deploy.

Check:
```bash
curl -I https://YOUR-USERNAME.github.io/relish-arch-distro/x86_64/relish-repo.db
```

Should return `200 OK`.

### Local Build Fails

Ensure you have build tools:
```bash
sudo pacman -S base-devel
```

Run makepkg directly to see detailed errors:
```bash
cd packages/pkgbuilds/package-name
makepkg -sf
```

## 📚 Additional Resources

- [Full Repository Documentation](REPOSITORY.md)
- [Creating Custom ISO](ISO.md) *(coming soon)*
- [System Configuration Guide](CUSTOMIZATION.md) *(coming soon)*

## 💡 Tips

1. **Test locally first**: Build and test packages locally before pushing
2. **Small commits**: Commit one package at a time for easier troubleshooting
3. **Use branches**: Create branches for experimental packages
4. **Check Actions**: Always verify GitHub Actions completed successfully
5. **Keep it organized**: Use meaningful commit messages

## ⏱️ Timeline

- **Day 1**: Set up repository and add first packages (Today!)
- **Day 2-3**: Add more packages and configurations
- **Day 4-5**: Create custom ISO with archiso
- **Day 6-7**: Test and refine

You're off to a great start! 🎉
