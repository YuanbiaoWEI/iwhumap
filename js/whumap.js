//map中的图层数组
var layer = new Array();
//图层名称数组
var layerName = new Array();
//图层可见属性数组
var layerVisibility = new Array();

/**
* 加载图层列表数据
* @param {ol.Map} map 地图对象
* @param {string} id 图层列表容器ID
*/
function loadLayersControl(map, id) {
    //图层目录容器
    var treeContent = document.getElementById(id); 
    //获取地图中所有图层
    var layers = map.getLayers();
    for (var i = layers.getLength()-1; i>=0 ; i--) {
        //获取每个图层的名称、是否可见属性
        layer[i] = layers.item(i);
        layerName[i] = layer[i].get('name');
        layerVisibility[i] = layer[i].getVisible();
        //新增li元素，用来承载图层项
        var elementLi = document.createElement('li');
        // 添加子节点
        treeContent.appendChild(elementLi); 
        //创建复选框元素
        var elementInput = document.createElement('input');
        elementInput.type = "checkbox";
        elementInput.name = "layers";
        elementLi.appendChild(elementInput);
        //创建label元素
        var elementLable = document.createElement('label');
        elementLable.className = "layer";
        //设置图层名称
        setInnerText(elementLable, layerName[i]);
        elementLi.appendChild(elementLable);
        //设置图层默认显示状态
        if (layerVisibility[i]) {
            elementInput.checked = true;
        }
        //为checkbox添加变更事件
        addChangeEvent(elementInput, layer[i]);  
    }
}
/**
* 为checkbox元素绑定变更事件
* @param {input} element checkbox元素
* @param {ol.layer.Layer} layer 图层对象
*/
function addChangeEvent(element, layer) {
    element.onclick = function () {
        if (element.checked) {
            //显示图层
            layer.setVisible(true);
        }
        else {
            //不显示图层
            layer.setVisible(false); 
        }
    };
}
/**
* 动态设置元素文本内容（兼容）
*/
function setInnerText(element, text) {
    if (typeof element.textContent == "string") {
        element.textContent = text;
    } else {
        element.innerText = text;
    }
}

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
//鼠标单击事件
function createXMLHttpRequest() {
            var XMLHttpRequest1;
            if (window.XMLHttpRequest) {
              XMLHttpRequest_test = new XMLHttpRequest();
            } else if (window.ActiveXObject) {
              try {
                XMLHttpRequest_test = new ActiveXObject("Msxml2.XMLHTTP");
              } catch (e) {
                XMLHttpRequest_test = new ActiveXObject("Microsoft.XMLHTTP");
              }
            }
            return XMLHttpRequest_test;
          }

map.on('singleclick', function(evt) {
        
        document.getElementById('attribute').innerHTML = "正在查询，请稍候...";
        var urlString=encodeURI("http://localhost:8080/iwhumap/AttributeQuery.jsp?coordinary="+evt.coordinate);
        var xmlHttp=createXMLHttpRequest();
        xmlHttp.open("post",urlString,true);
        xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        xmlHttp.onreadystatechange = function() {
              //这个4代表已经发送完毕之后  
              if (xmlHttp.readyState == 4) {
                //200代表正确收到了返回结果  
                if (xmlHttp.status == 200) {
                  //弹出返回结果  
                  //alert(xmlHttp.responseText);
                  document.getElementById('attribute').innerHTML =xmlHttp.responseText;
                } else {
                  //如果不能正常接受结果，你肯定是断网，或者我的服务器关掉了。  
                  alert("请求失败！"+xmlHttp.status);
                }
              }
            };
            //XMLHttpRequest_test.setRequestHeader("Content-Type", "text/html");
            xmlHttp.send(null);
           
});
 //加载图层列表数据
loadLayersControl(map, "layerTree");