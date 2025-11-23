# Gmail-Tray

Minimal Gmail notifier, with tray-icon, unread counter, opening the gmail page on a browser (firefox).

It mostly uses [fetchmail](https://www.fetchmail.info) to search for new emails and notify you, so you the main credits go for it's creator

*   My main job was create an interface and set up the polling code, so that it checks for emails on terminal, notifies the user and update the unread emails count

Also, you must set it (fetchmail) up first for it to work

## Running the repo
*   This project relies on maskfile to use the readme as a makefile
*   So you can install mask, and run this README, using: 
*   mask --maskfile README.md <ready|install|push >

## ready

> make sure everything is up to date

```sh
echo "building project..."
makepkg -g
read -p "Press [Enter] to continue after checking the hashes..."
makepkg --printsrcinfo > .SRCINFO
makepkg -fsrc
```

## install
> at the repository root directory
```sh
echo "creating and installing the package"
makepkg -fsirc
```

## push
> For me to not forget what I need to sync it with the AUR
```sh
git remote add aur ssh://aur@aur.archlinux.org/gmail-tray-git.git
git push --set-upstream aur master
```

## Setting up fetchmail:

*   Create an app password (you need to have 2-Factor Authentication)
    *   Go to: [https://myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)
    *   Type Gmail-Tray > Create
    *   Note it down
*   Edit the .fetchmailrc file (create it on your home folder)
    *   Make it like:
        *   # account 1
            poll imap.gmail.com with proto IMAP  
               user \<your gmail 1 here>@gmail.com password \<"Your App Password 1 between quotes">  
               ssl
            # account 2
            poll imap.gmail.com with proto IMAP  
               user \<your gmail 2 here>@gmail.com password \<"Your App Password 2 between quotes">  
               ssl
            

    Then:
        chmod 0600 ~/.fetchmailrc

## Enable service autostart
```sh
systemctl --user enable --now gmail-tray.service
```

## Uninstall
```sh
sudo pacman -Rns gmail-tray
```

Customizations  
The user config file will be in ~/.config/gmail-tray/gmail-tray-configs.json

There, you can change:

*   The checking interval to run fetchmail,
*   The browser used to open gmail (to the one you like most, the default is firefox),
*   The flags used to open the browser


> (like:
    --new-tab,
    --safe-mode (to use firefox without extensions and make it lighter), ...),

*   The path to the gmail-tray icon (to another icon perhaps),
*   The app's title,
*   And even the link to open (if you, for some reason, want to open an alternative page instead of gmail)

# Features
*   [x] Regular email checking
*   [x] System notifications
*   [x] Tray icon indication of unread messages
    *   Doesn't work natively with waybar
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

Future
*   [ ] A TUI to set up fetchmail
*   [ ] A TUI to allow for customizations
*   [ ] Create a installer file