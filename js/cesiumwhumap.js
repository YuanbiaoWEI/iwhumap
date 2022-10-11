var viewer = new Cesium.Viewer("cesiumContainer",{  
    animation : false,//是否创建动画小器件，左下角仪表  
    //baseLayerPicker : false,//是否显示图层选择器  
    fullscreenButton : false,//是否显示全屏按钮  
    //geocoder : false,//是否显示geocoder小器件，右上角查询按钮  
    //homeButton : false,//是否显示Home按钮  
    infoBox : false,//是否显示信息框  
    //sceneModePicker : false,//是否显示3D/2D选择器  
    //selectionIndicator : false,//是否显示选取指示器组件  
    timeline : false,//是否显示时间轴  
    //navigationHelpButton : false,//是否显示右上角的帮助按钮  
    scene3DOnly : true,//如果设置为true，则所有几何图形以3D模式绘制以节约GPU资源   
});


viewer.homeButton.viewModel.command.beforeExecute.addEventListener(function(e) {
    e.cancel = true;
    //你要飞的位置	
    viewer.camera.flyTo({
        destination: Cesium.Cartesian3.fromDegrees(114.35853, 30.54190,8000000.0)
    });
});

viewer.camera.setView({
    destination:Cesium.Cartesian3.fromDegrees(114.35853, 30.54190,8000000.0),
  });


viewer.entities.add({
    position: Cesium.Cartesian3.fromDegrees(114.35853, 30.54190),
    billboard: {
      image: "../img/schoolname.png",
      scale: 0.5
    },
  });

  viewer.dataSources.add(Cesium.GeoJsonDataSource.load('https://geo.datav.aliyun.com/areas_v3/bound/100000_full.json', {
    stroke: Cesium.Color.HOTPINK,
    fill: Cesium.Color.fromBytes(255,192,205,64),
    //fill: Cesium.Color(1,0.75,0.79,0.5),
    strokeWidth: 10,
  }));
