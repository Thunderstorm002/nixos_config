{ config, lib, pkgs, ... }:

{
  ## Desktop
  # Options that are useful to desktop experience and general convenience. Some
  # of these may also be to specific server environments, too. Most of these
  # options reduce security to a certain degree.

  # Reenable multilib, may be useful to playing certain games.
  nm-overrides.desktop.allow-multilib.enable = true;

  # Reenable unprivileged userns. Although userns is the target of many
  # exploits, it also used in the Chromium sandbox, unprivileged containers,
  # and bubblewrap among many other applications.
  # nm-overrides.desktop.allow-unprivileged-userns.enable = true;

  # Enable doas-sudo wrapper, useful for scripts that use "sudo." Installs
  # nano for rnano as a "safe" method of editing text as root.
  # Use this when replacing sudo with doas, see "Software Choice."
  # sudo = doas
  # doasedit/sudoedit = doas rnano
  # nm-overrides.desktop.doas-sudo-wrapper.enable = true;

  # Allow executing binaries in /home. Highly relevant for games and other
  # programs executing in the /home folder.
  nm-overrides.desktop.home-exec.enable = true;

  # Allow executing binaries in /tmp. Certain applications may need to execute
  # in /tmp, Java being one example.
  # nm-overrides.desktop.tmp-exec.enable = true;

  # Allow executing binaries in /var/lib. LXC, and system-wide Flatpaks are
  # among some examples of applications that requiring executing in /var/lib.
  # nm-overrides.desktop.var-lib-exec.enable = true;

  # Allow all users to use nix, rather than just users of the "wheel" group.
  # May be useful for allowing a non-wheel user to, for example, use devshell.
  # nm-overrides.desktop.nix-allow-all-users.enable = true;

  # Automatically allow all connected devices at boot in USBGuard. Note that
  # for laptop users, inbuilt speakers and bluetooth cards may be disabled
  # by USBGuard by default, so whitelisting them manually or enabling this
  # option may solve that.
  nm-overrides.desktop.usbguard-allow-at-boot.enable = true;

  # Enable USBGuard dbus daemon and add polkit rules to integrate USBGuard with
  # GNOME Shell. If you use GNOME, this means that USBGuard automatically
  # allows all newly connected devices while unlocked, and blacklists all
  # newly connected devices while locked. This is obviously very convenient,
  # and is similar behavior to handling USB as ChromeOS and GrapheneOS.
  # nm-overrides.usbguard-gnome-integration.enable = true;

  # Completely disable USBGuard to avoid hassle with handling USB devices at
  # all.
  # nm-overrides.desktop.usbguard-disable.enable = true;

  # Rather than disable ptrace entirely, restrict ptrace so that parent
  # processes can ptrace descendants. May allow certain Linux game anticheats
  # to function.
  # nm-overrides.desktop.yama-relaxed.enable = true;

  # Allow processes that can ptrace a process to read its process information.
  # Requires ptrace to even be allowed in the first place, see above option.
  # Note: While nix-mineral has made provisions to unbreak systemd, it is
  # not supported by upstream, and breakage may still occur:
  # https://github.com/systemd/systemd/issues/12955
  # nm-overrides.desktop.hideproc-relaxed.enable = true;
}
