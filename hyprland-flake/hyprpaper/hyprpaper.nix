{ backgroundsPath }:

let
  wallpaper = "${backgroundsPath}/cena-lic-lp-nature-cropped.jpg";
in
{
  preload = [ wallpaper ];

  wallpaper = [ ",${wallpaper}" ];
  
  ipc = "off";
}
