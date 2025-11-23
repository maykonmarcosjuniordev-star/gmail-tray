# Gmail-Tray

Minimal Gmail notifier, with tray-icon, unread counter, opening the gmail page on a browser (firefox).

It mostly uses [fetchmail](https://www.fetchmail.info) to search for new emails and notify you,
- so you the main credits go for it's creator

My main job was create an interface and set up the polling code,
- so that it checks for emails on terminal,
- notifies the user
- and update the unread emails count

Also, you must set it (fetchmail) up first for it to work

# Table of Contents
*   [Features](README.md#features)
*   [Running this Repo](README.md#running-the-repo)
*   [Getting Started with Fetchmail](README.md#setting-up-fetchmail)
*   [Customizations](README.md#customizations)
*   [SNI (waybar) Support](README.md#sni-waybar-support)


# Features
*   [x] Regular email checking
*   [x] System notifications
*   [x] Tray icon indication of unread messages
    *   Doesn't work natively with waybar, see ahead
*   [x] Clicking on tray icon allow opening gmail website on browser
*   [x] System service to allow autostart
*   [x] Browser and flags can be added on a config file
*   [x] User settings on ~/.config/gmail-tray
*   [x] Multiple emails accounts suppor
*   [x] Clicking on the desktop app after it started launchs gmail website
*   [x] Clicking on tray icon display unread count per account
*   [x] Clicking on tray icon option can also re-launch notifications per account
*   [x] Full Wayland and Xorg Support
*   [x] Works on any linux using libnotify
*   [x] Make the notifications clickable

In the Future
*   [ ] A TUI to set up fetchmail
*   [ ] A TUI to allow for customizations

## Running the repo
*   This project relies on [maskfile](https://github.com/jacobdeichert/mask) to use the readme as a makefile
*   So you can install mask, and run this README, using: 
*   mask --maskfile README.md <command>
I recommend adding
```sh
alias maskrun='mask --maskfile README.md'
```
*   to your .bash_aliases or .zsh_aliases

## ready
> make sure everything is up to date

**OPTIONS**
* hash_is_done
    * flags: --skip
    * type: boolean
    * desc: wheter to verify the hashes for PKBUILD

```sh
# defaults to false
HASH=${hash_is_done:-false}
echo "Skipping Hash = $HASH"
echo "building project..."
if [[ !$HASH ]]; then
    makepkg -g
    read -p "Press [Enter] to continue after checking the hashes..."
fi
makepkg --printsrcinfo > .SRCINFO
makepkg -fsrc
```

## install
0nly arch linux supported for now:

for the AUR [pkg](https://aur.archlinux.org/packages/gmail-tray-git)
- yay -S gmail-tray-git
- paru -S gmail-tray-git

Or, for manual install:
> at the repository root directory
```sh
echo "creating and installing the package"
makepkg -fsirc
```

## autostart
> Enables an autostart service, that runs on PC startup and ensures it recovers from crashes
```sh
systemctl --user enable --now gmail-tray.service
```

## remove
> Uninstalls from the system, whether in a manual or aided install
```sh
sudo pacman -Rns gmail-tray
```

## push (repo)
> For me to not forget what I need to sync it with the AUR
```sh
echo "Pushing to $repo"
if [[ "$repo" -eq "github" ]]; then
    git remote add github git@github.com:maykonmarcosjuniordev-star/gmail-tray.git
    git push --set-upstream github master
else
    git remote add aur ssh://aur@aur.archlinux.org/gmail-tray-git.git
    git push --set-upstream aur master
fi
```
<br>
<br>
<br>

# Setting up fetchmail:

Create an app password (you need to have 2-Factor Authentication)

*   Go to: [https://myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)
*   Give it a name 
*   Tap **Create**
*   Note it down and save
*   create a file named **.fetchmailrc** in your home folder
*   Edit the .fetchmailrc file to add your desired accounts:
    *   poll imap.gmail.com with proto IMAP  
           user \<your gmail 1 here>@gmail.com password \<"Your App Password 1 between quotes">  
           ssl
    *   poll imap.gmail.com with proto IMAP  
           user \<your gmail 2 here>@gmail.com password \<"Your App Password 2 between quotes">  
           ssl
*   Then:
```sh
chmod 0600 ~/.fetchmailrc
```

# Customizations

The user config file will be in ~/.config/gmail-tray/gmail-tray-configs.json

There, you can change:

*   The checking interval to run fetchmail,
*   The browser used to open gmail (to the one you like most, the default is firefox),
*   The flags used to open the browser

    *   --ProfileManager (on firefox, it allows for picking a profile),
    *   --new-tab (to avoid a new instance),
    *   -P <profile-name> (choose an specific profile)
    *   --safe-mode (to use firefox without extensions and make it lighter),
    *   ...

*   The path to the gmail-tray icon (to another icon perhaps),
*   The app's title,
*   And even the link to open (if you want to open outlook for instance)

## (SNI) Waybar support

Waybar’s tray module (SNI/StatusNotifierItem) displays:
- The icon
- The name
- NOT the dynamic label (the unread count this program use).

This is a known limitation of:
- KDE/Qt SNI spec
- waybar's implementation
- many modern trays in Wayland

Therefore, there is a hack to inclue a unread counter on waybar:

*   Add this to `~/.config/waybar/config.jsonc`
```jsonc
"custom/gmail": {
    "exec": "gmail-tray --once | grep '{'",
    "interval": 30,
    "return-type": "json",
    "format": " @ {} "
},
```
*   Don't forget to enable the module (I recommend putting it right before the tray icons)
```jsonc
    "modules-right": [
        "tray",
        "custom/gmail",
        ...
    ],
```
* Then, customize the module as you want, adding to `~/.config/waybar/styles.css`:
```css
#custom-gmail {
    padding: 0 10px;
    color: #ffffff;
}
```