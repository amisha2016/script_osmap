#!/bin/bash
source ./install.conf
mkdir $web_folder
cd $web_folder
wget -c $ol_css_url
unzip v4.3.2-dist.zip
#wget -c $ol_js_url
cat <<EOF >index.html
<!DOCTYPE html>
<html>
<head>
<title>Accessible Map</title>
<link rel="stylesheet" href="v4.3.2-dist/ol.css" type="text/css">
<script src="v4.3.2-dist/ol.js"></script>
<style>
  a.skiplink {
    position: absolute;
    clip: rect(1px, 1px, 1px, 1px);
    padding: 0;
    border: 0;
    height: 1px;
    width: 1px;
    overflow: hidden;
  }
  a.skiplink:focus {
    clip: auto;
    height: auto;
    width: auto;
    background-color: #fff;
    padding: 0.3em;
  }
  #map:focus {
    outline: #4A74A8 solid 0.15em;
  }
</style>
</head>
<body>
  <a class="skiplink" href="#map">Go to map</a>
  <div id="map" class="map" tabindex="0"></div>
  <button id="zoom-out">Zoom out</button>
  <button id="zoom-in">Zoom in</button>
  <script>
    var map = new ol.Map({
      layers: [
        new ol.layer.Tile({
          source: new ol.source.OSM({
             url: '../osm_tiles/{z}/{x}/{y}.png'
          })
       })
     ],
     target: 'map',
     controls: ol.control.defaults({
        attributionOptions: /** @type {olx.control.AttributionOptions} */ ({
          collapsible: false
        })
     }),
    view: new ol.View({
       center: [244780.24508882355, 7386452.183179816],
       zoom:5
    })
 });

  document.getElementById('zoom-out').onclick = function() {
    var view = map.getView();
    var zoom = view.getZoom();
    view.setZoom(zoom - 1);
  };

  document.getElementById('zoom-in').onclick = function() {
     var view = map.getView();
     var zoom = view.getZoom();
     view.setZoom(zoom + 1);
  };
</script>
</body>
</html>
EOF

exit
