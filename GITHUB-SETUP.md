# GitHub Setup Instructions

Your local repository is ready! Now let's push it to GitHub.

## Step 1: Create GitHub Repository

1. **Go to GitHub**: https://github.com/new
2. **Repository name**: `relish-arch-distro`
3. **Description**: "Custom Arch Linux distribution with KDE Plasma, Hyprland, and gaming setup"
4. **Visibility**: Public (required for GitHub Pages)
5. **DO NOT** check any of these:
   - ❌ Add a README file
   - ❌ Add .gitignore
   - ❌ Choose a license
6. **Click**: "Create repository"

## Step 2: Push to GitHub

After creating the repository, run these commands:

```bash
cd ~/Projects/relish-arch-distro

# Add GitHub as remote
git remote add origin https://github.com/medievalnudistofthedead/relish-arch-distro.git

# Push to GitHub
git push -u origin main
```

**Note**: You may need to authenticate with GitHub. Options:
- **Personal Access Token** (recommended)
- **SSH Key**
- **GitHub CLI** (`gh auth login`)

### If using Personal Access Token:
1. Go to: https://github.com/settings/tokens
2. Generate new token (classic)
3. Select scopes: `repo` (full control)
4. Copy the token
5. Use it as password when pushing

### If using SSH:
```bash
# Generate SSH key if you don't have one
ssh-keygen -t ed25519 -C "mnotd94@gmail.com"

# Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key and add to GitHub
cat ~/.ssh/id_ed25519.pub

# Change remote to SSH
git remote set-url origin git@github.com:medievalnudistofthedead/relish-arch-distro.git
git push -u origin main
```

## Step 3: Enable GitHub Pages

1. Go to: https://github.com/medievalnudistofthedead/relish-arch-distro/settings/pages
2. Under "Source", select: **GitHub Actions**
3. Click **Save**

## Step 4: Verify

After pushing, check:
- Repository: https://github.com/medievalnudistofthedead/relish-arch-distro
- Actions tab: Workflows should be visible
- After enabling Pages: https://medievalnudistofthedead.github.io/relish-arch-distro/

## What's Next?

Once pushed and Pages is enabled, you can:
1. Add packages to your repository
2. Watch GitHub Actions build them automatically
3. Use the repository on any Arch system

## Troubleshooting

**Authentication failed?**
- Use Personal Access Token instead of password
- Or set up SSH keys

**Push rejected?**
- Make sure repository is empty on GitHub
- Don't initialize with README/license

**GitHub Pages not working?**
- Wait 2-3 minutes after first push
- Check Actions tab for deployment status

---

**Ready?** Let me know when you've created the GitHub repository and I'll help you push!
