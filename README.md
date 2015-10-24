# Kodi Addons Development Scripts

This repository contains scripts that I call from the [SourceTree](http://www.sourcetreeapp.com/) Git client, using Custom Actions, to perform certain tasks related to my Kodi addons development.

##### Important Notes

For these scripts to work properly the addon element in the addon.xml file must be in the following format and order:

```
<addon id="???" name="????" version="?.?.?" provider-name="???">
```

Otherwise the scripts will not be able to get the addons version number.

I use the [git-flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model, so these scripts check that they are being run on the correct branch (develop or master).

## update-version.sh

```
usage: update-version.sh addon-directory
```

This script increments the patch version number of the specified addon and `git diff` is run on the addon.xml file.

Example output:

```
./update-version.sh plugin.audio.tuneinradio/
2.0.6
diff --git a/addon.xml b/addon.xml
index 1c8a1ff..b819802 100644
--- a/addon.xml
+++ b/addon.xml
@@ -1,5 +1,5 @@
 <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
-<addon id="plugin.audio.tuneinradio" name="TuneIn Radio" version="2.0.5" provider-name="brianhornsby">
+<addon id="plugin.audio.tuneinradio" name="TuneIn Radio" version="2.0.6" provider-name="brianhornsby">
        <requires>
                <import addon="xbmc.python" version="2.1.0"/>
                <import addon="script.module.simplejson" version="2.0.10"/>
```


## update-changelog.sh

```
usage: update-changelog.sh git-repo
```

This script gets the changes between the develop and master branches for the specified Git repository. The changes are then appended to the start of the changelog.txt file and `git diff` is run on the changelog.txt file.

Example output:

```
./generate-changelog.sh plugin.audio.tuneinradio
diff --git a/changelog.txt b/changelog.txt
index a22b978..6ce0c4c 100644
--- a/changelog.txt
+++ b/changelog.txt
@@ -1,4 +1,19 @@
 *** 2.0.6 ***
+Fixed issue with custom urls not playing. [0a07dbf]
+Fixed issue with adding stations to kodi favourites. [0261b33]
+
+*** 2.0.5 ***
 Fixed issue with stream url being converted to lowercase. [0804367]

 *** 2.0.4 ***
```

## generate-zip.sh

```
usage: generate-zip.sh addon-directory
```

This script generates a zip file of the specifed addon.

Example output:

```
./generate-zip.sh script.openvpn/
  adding: script.openvpn/ (stored 0%)
  adding: script.openvpn/addon.xml (deflated 45%)
  adding: script.openvpn/changelog.txt (deflated 50%)
  adding: script.openvpn/default.py (deflated 71%)
  ...
  adding: script.openvpn/resources/settings.xml (deflated 65%)
Archive ./bin/script.openvpn-2.0.2.zip created
``` 
