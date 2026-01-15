# Enable GitHub Pages - Quick Guide

## Your Repository is Live! 🎉

**URL**: https://github.com/medievalnudistofthedead/relish-arch-distro

## Next Step: Enable GitHub Pages

### Quick Instructions:

1. **Go to Settings**: https://github.com/medievalnudistofthedead/relish-arch-distro/settings/pages

2. **Under "Build and deployment"**:
   - Source: Select **"GitHub Actions"**

3. **Click Save**

That's it! GitHub Pages will be enabled.

### After Enabling:

Your package repository will be accessible at:
```
https://medievalnudistofthedead.github.io/relish-arch-distro/
```

Package repository URL for pacman.conf:
```
https://medievalnudistofthedead.github.io/relish-arch-distro/x86_64
```

### What Happens Next:

1. GitHub Actions will deploy your repository
2. Wait 2-3 minutes for initial deployment
3. You can then add it to `/etc/pacman.conf`

## Testing After Deployment

Check if it's live:
```bash
curl -I https://medievalnudistofthedead.github.io/relish-arch-distro/
```

Should return `200 OK` when ready.

---

**Let me know when you've enabled GitHub Pages and I'll help verify everything is working!**
