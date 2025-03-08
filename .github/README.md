<h1 align="center">
   <img src="assets/nixos-logo.png" width="100px" />
   <br>
      Chrono NixOS Dotfiles
   <br>
      <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px" /> <br>
   <div align="center">
      
   <div align="center">
      <p></p>
      <div align="center">
         <a href="https://github.com/chrollorifat/chrono-nixos-config/stargazers">
            <img src="https://img.shields.io/github/stars/chrollorifat/chrono-nixos-config?color=F5BDE6&labelColor=303446&style=for-the-badge&logo=starship&logoColor=F5BDE6">
         </a>
         <a href="https://github.com/chrollorifat/chrono-nixos-config">
            <img src="https://img.shields.io/github/repo-size/chrollorifat/chrono-nixos-config?color=C6A0F6&labelColor=303446&style=for-the-badge&logo=github&logoColor=C6A0F6">
         </a>
         <a = href="https://nixos.org">
            <img src="https://img.shields.io/badge/NixOS-Unstable-blue?style=for-the-badge&logo=NixOS&logoColor=white&label=NixOS&labelColor=303446&color=91D7E3">
            <!-- <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=303446&logo=NixOS&logoColor=white&color=91D7E3"> -->
         </a>
         <a href="https://github.com/chrollorifat/chrono-nixos-config/blob/main/LICENSE">
            <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA=313244&colorB=F5A97F&logo=unlicense&logoColor=F5A97F&"/>
         </a>
      </div>
      <br>
   </div>
</h1>

![Screenshot](assets/preview1.png)
![Screenshot](assets/preview2.png)
![Screenshot](assets/preview3.png)
![Screenshot](assets/preview4.png)
![Screenshot](assets/preview5.png)

# Few things to keep in mind

- Still a work in progress, don't just blindly copy. But you can use this as reference tho.
- This config is for Legacy Boot with MBR disk partitioning
- It uses Grub as a bootloader
- You can make the necessary changes to fit your setup in the hosts directory

# Installation
> [!Note]
> <p>You should review the configuration variables in flake.nix before installing.</p>
<!-- ## Using the install script -->
```bash
nix run --experimental-features "nix-command flakes" nixpkgs#git clone https://github.com/chrollorifat/chrono-nixos-config.git ~/NixOS
```
```bash
cd ~/NixOS
```
```bash
./install.sh
```
For a list of keybinds press Super + Shift + K
<details>
<summary>How to use the dev-shells</summary>

```bash
nix flake init -t ~/NixOS#NAME
```
or  use the "new" keyword to initialise a new directory
```bash
nix flake new -t ~/NixOS#NAME PROJECT_NAME
```
where NAME is any of the templates defined in dev-shells/default.nix
</details>

<!-- ## Building manually
> [!IMPORTANT]
> <p>When building manually from the flake make sure to place your hardware-configuration.nix in hosts/Default/<br>
> then change the username variable in flake.nix with your username!! THIS IS IMPORTANT<br>
> afterwards run the command below</p>
```bash
sudo nixos-rebuild switch --flake .#Default
``` -->
### Credits/Inspiration
https://github.com/Sly-Harvey/NixOS<br>
https://github.com/JaKooLit/Hyprland-Dots<br>
https://github.com/prasanthrangan/hyprdots
