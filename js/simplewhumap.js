/********************加载地图 ***********************/
 var format = 'image/png';
var bounds = [114.34244000000000, 30.52648700000000,
              114.37301635742188, 30.557];
var tiled = new ol.layer.Tile({
  name: "校园矢量图层",
  source: new ol.source.TileWMS({
    url: 'http://localhost:8080/geoserver/whumap/wms',
    params: {'FORMAT': format, 
             'VERSION': '1.1.1',
             tiled: true,
          "STYLES": '',
          "LAYERS": 'whumap:whumap2',
          "exceptions": 'application/vnd.ogc.se_inimage',
       tilesOrigin: 114.3 + "," + 30.5
    }
  })
});
var osmtile = new ol.layer.Tile(
  {
    name: "OSM矢量图层",
    source: new ol.source.OSM()
  }
);
var TiandiMap_vec = new ol.layer.Tile({
      name: "天地图矢量图层",
      source: new ol.source.XYZ({
          url: "http://t0.tianditu.com/DataServer?T=vec_w&x={x}&y={y}&l={z}&tk=3bc6874f2b919aa581635abab7759a3f",
          wrapX: false
      })
  });
  var TiandiMap_cva = new ol.layer.Tile({
      name: "注记图层",
      source: new ol.source.XYZ({
          url: "http://t0.tianditu.com/DataServer?T=cva_w&x={x}&y={y}&l={z}&tk=3bc6874f2b919aa581635abab7759a3f",
          wrapX: false
      })
  });
  var TiandiMap_img = new ol.layer.Tile({
      name: "影像图层",
      source: new ol.source.XYZ({
          url: "http://t0.tianditu.com/DataServer?T=img_w&x={x}&y={y}&l={z}&tk=3bc6874f2b919aa581635abab7759a3f",
          wrapX: false
      })
  });
var projection = new ol.proj.Projection({
    code: 'EPSG:4326',
    units: 'degrees',
    axisOrientation: 'neu',
    global: true
});
var mousePositionControl = new ol.control.MousePosition({
        className: 'custom-mouse-position',
        target: document.getElementById('location'),
        coordinateFormat: ol.coordinate.createStringXY(5),
        placeholder: false
      });
var map = new ol.Map({
  target: "mapCon",
  layers: [
  //注意图层顺序，最上层的放在数组最后
  TiandiMap_img,
    osmtile,
    TiandiMap_vec,
    tiled,
    TiandiMap_cva,
  ],
  view: new ol.View({
     projection: projection,
     center: [114.35926, 30.53890],
     zoom: 14
  }),
  controls: ol.control.defaults({
          attributionOptions: ({
              collapsible: true
          })
        }).extend([
    new ol.control.ZoomToExtent({
        extent: bounds
    }),
    mousePositionControl
  ])
});  
//实例化ZoomSlider控件并加载到地图容器中
var zoomslider = new ol.control.ZoomSlider();
  map.addControl(zoomslider);
//尺度变化加载比例尺
  map.getView().on('change:resolution', function(evt) {
        var resolution = evt.target.get('resolution');
        var units = map.getView().getProjection().getUnits();
        var dpi = 25.4 / 0.28;
        var mpu = ol.proj.METERS_PER_UNIT[units];
        var scale = resolution * mpu * 39.37 * dpi;
        if (scale >= 9500 && scale <= 950000) {
          scale = Math.round(scale / 1000) + "K";
        } else if (scale >= 950000) {
          scale = Math.round(scale / 1000000) + "M";
        } else {
          scale = Math.round(scale);
        }
        document.getElementById('scale').innerHTML = "比例尺 = 1 : " + scale;
      });
//加载地图
map.getView().fit(bounds, map.getSize());