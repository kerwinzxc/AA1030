sips -z $width 1136 $height 640  $1 --out Default-568h@2x.png
sips -z $width 1334 $height 750  $1 --out Default-667h@2x.png
sips -z $width 2436 $height 1125 $1 --out Default-2436h@3x.png
sips -z $width 1024 $height 768  $1 --out Default-Portrait.png
sips -z $width 2048 $height 1536 $1 --out Default-Portrait@2x.png
sips -z $width 2208 $height 1242 $1 --out Default-Portrait@3x.png
sips -z $width 480  $height 320  $1 --out Default.png
sips -z $width 960  $height 640  $1 --out Default@2x.png

sips -z $width 1242 $height 2208 $1 --out Default-Landscape@3x.png
sips -z $width 768  $height 1024 $1 --out Default-Landscape.png
sips -z $width 1536 $height 2048 $1 --out Default-Landscape@2x.png
