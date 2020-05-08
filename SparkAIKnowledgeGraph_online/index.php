<?php
	// 数据库连接
    $con = mysqli_connect('localhost', 'root', '520808', 'sparkai');
    if(!$con){
        echo "Connection error: " . mysqli_connect_error();
    }
    // 全局变量定义
    //
    //关键字
    $keyword = "";

    // 实体搜索次数
    $entity_search = 0;

    // 累计搜索次数
    $total_search = 0;

    // 实体总数
    $entity_total = 0;

    // 实体信息
    $entity_json = "[]";

    // 实体相关信息
    $entity_json_like = "[]";

    // 远程数据
    $content_json = "{}";
    // 判断搜索
    if(empty($_GET['keyword'])){
    	// 未得到关键字
     	$keyword = "";
     	# 啥也不干，不执行查询
    }
    else {
    	// 有关键字，开始查询实体信息
      	$keyword = $_GET['keyword'];
      	// echo "<script>alert('取到'+'{$keyword}');</script>";
    
	    // get-json-entity-data（实体信息）
	    $sql = " select * from tb_entity where name = '{$keyword}' ";
	    $query = mysqli_query($con, $sql);
	    $rows = mysqli_fetch_all($query,MYSQLI_ASSOC);

	    // 把PHP数组转成JSON字符串（查询结果）
	    $entity_json = json_encode($rows,JSON_UNESCAPED_UNICODE );
	    // file_put_contents('./json/entity.json', $entity_json);
	    
	    if($entity_json == "[]"){
	    	// 找不到实体
	    	# 更新总搜索次数，并退出查询
	    	$sql_update = "CALL `update_count_sum`('{$keyword}')";
	    	$update = mysqli_query($con, $sql_update);

        // echo "<script>alert('找不到实体');</script>";
        // 远程获取实体
        $url_keyword = urlencode($keyword);
        $url = "https://api.ownthink.com/kg/knowledge?entity={$url_keyword}";
        // echo $url;
        $str = curl_init();
        curl_setopt($str, CURLOPT_URL, $url);
        curl_setopt($str, CURLOPT_RETURNTRANSFER, 1);
        // 执行
        $content = curl_exec($str);
        if ($content == false) {
         echo "error:" . curl_error($str);
        }
        // 关闭
        curl_close($str);
        //输出结果
        // var_dump($content);
        $content_json = $content;
	    } 
	    else {
	    	// 找到实体
	    	# 查找并更新实体搜索次数，查找相关实体
	    	// get-json-entity-like（相关实体）
		    $sql_like = " select distinct name from tb_entity where name like '%{$keyword}%' ";
		    $query_like = mysqli_query($con, $sql_like);
		    $rows_like = mysqli_fetch_all($query_like,MYSQLI_ASSOC);

		    // 把PHP数组转成JSON字符串
		    $entity_json_like = json_encode($rows_like,JSON_UNESCAPED_UNICODE );
		    // file_put_contents('./json/entity_like.json', $entity_json_like);
		    
		    # 更新搜索次数
	    	$sql_update = "CALL `update_count_sum`('{$keyword}')";
	    	$update = mysqli_query($con, $sql_update);

	    	# 查询搜索次数并退出
	    	$sql_count = "select counts from tb_counts where name ='{$keyword}'";
	    	$query_count = mysqli_query($con, $sql_count);
	    	$entity_search = mysqli_fetch_array($query_count)[0];
	    }
    }

    // 以下两条数据必须查询
    // 无关键字也需查询

    // 总搜索次数
    $sql_total_search = "select counts from tb_counts where name ='sum'";
    $query_total_search = mysqli_query($con, $sql_total_search);
    $total_search = mysqli_fetch_array($query_total_search)[0];

    // 实体总数
    $sql_entity_total = "select count(*)from tb_entity";
    $query_entity_total = mysqli_query($con, $sql_entity_total);
    $entity_total = mysqli_fetch_array($query_entity_total)[0];

    // 释放连接
    mysqli_close($con);

?>
<!DOCTYPE html>
<html lang="zh" >
<head>
  <meta charset="UTF-8">
  <meta name="author" content="RedStar Liu">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>基于Spark平台的人工智能知识图谱构建</title>
  <!-- css -->
  <link rel="shortcut icon" href="./img/SparkAI.ico">
  <link rel="stylesheet" href="./css/style.css">
  <link rel="stylesheet" href="./css/bootstrap.min.css">
  <link rel="stylesheet" href="./layui/css/layui.css">
  <!-- script -->
  <script type="text/javascript" src="./js/jquery.min.js"></script>
  <!-- amcharts -->
  <script type="text/javascript" src="./js/core.js"></script>
  <script type="text/javascript" src="./js/charts.js"></script>
  <script type="text/javascript" src="./js/forceDirected.js"></script>
  <script type="text/javascript" src="./js/animated.js"></script>
</head>

<body>
  <!-- 标题 -->
  <h1 id="title">
    <span style="color: #F38181">基于</span>
    <span style="color: #FFD800">Spark</span>
    <span style="color: #96C120">平台的</span>
    <span style="color: #F54EA2">人工智能</span>
    <span style="color: #C04D00">知识图谱</span>
  </h1>
  <!-- 搜索框 -->
  <div id="search">
    <form class="layui-form layui-form-pane">
      <div class="layui-input-inline" style="width: 18%;">
        <input class="form-control" type="text" id="keyword" name="keyword" placeholder="请输入关键字" >
      </div>
      <div class="layui-input-inline" style="margin-left: 10px;">
      <button class="layui-btn layui-btn-radius" lay-submit lay-filter="search">
        <i class="layui-icon layui-icon-search"style="margin-right: 10px;"></i>搜索
      </button>
      </div>
    </form>
  </div>
  <!-- 知识图谱-力导向树-绑定数据 -->
<div id="kg-body">
  <!-- 左边 -->
  <div id="kg-left">
    <div id="entity-count">
      <span style="color: #08ffc8">统计</span>
      <span style="color: #f29c2b">信息</span>  
      <table>
        <tr style="color: #08ffc8">
          <th>实体搜索：</th>
          <td><?php echo strval($entity_search);?>次</td>
        </tr>
        <tr style="color: #f29c2b">
          <th>累计搜索：</th>
          <td><?php echo strval($total_search);?>次</td>
        </tr>
        <tr style="color: #F54EA2">
          <th>实体总数：</th>
          <td><?php echo strval($entity_total);?>条</td>
        </tr>
      </table>
    </div>
    <div style="width:85%; margin-left: 18px;">
      <hr class="layui-bg-red">
    </div>
    <div id="entity-info" style="margin-top: 30px;">
      <span style="color: #F38181">实</span>
      <span style="color: #FFD800">体</span>
      <span style="color: #96C120">信</span>
      <span style="color: #F54EA2">息</span>
      <table>
        <tr style="color: #F38181">
          <th id="entityName">名称：</th>
          <!-- <td>机器人</td> -->
        </tr>
        <tr style="color: #FFD800">
          <th id="entityEnglish">外文名：</th>
          <!-- <td>Robot</td> -->
        </tr>
        <tr style="color: #96C120">
          <th id="entityDetail">定义：</th>
          <!-- <td>自动执行工作的机器装置。机器人（Robot）是自动执行工作的机器装置。</td> -->
        </tr>
        <tr style="color: #F54EA2">
          <th id="entityLabel">标签：</th>
          <!-- <td>科学</td> -->
        </tr>
        <tr style="color: #C04D00">
          <th id="entityLike">相关实体：</th>
          <!-- <td>科学</td> -->
        </tr>
      </table>
    </div>
  </div>
  <!-- 中间 -->
  <div id="chartdiv"></div>
  <!-- 右边 -->
  <div id="themes">
    <span>
      <i class="layui-icon layui-icon-theme" style="font-size: 30px; color: #E8110F;"></i>
    </span>
    <button class="layui-btn layui-btn-sm layui-btn-radius"style="margin-left:10px;">
      <a href="./index.php">静态默认</a>
    </button>
    <button class="layui-btn layui-btn-sm layui-btn-radius"style="background-color:#F38181;">
      <a href="./themes/theme0.html">科技颗粒</a>
    </button>
    <button class="layui-btn layui-btn-sm layui-btn-radius"style="background-color:#96C120">
      <a href="./themes/theme1.html">旋转之框</a>
    </button>
    <button class="layui-btn layui-btn-sm layui-btn-radius"style="background-color:#F54EA2">
      <a href="./themes/theme2.html">炫动星光</a>
    </button>
    <button class="layui-btn layui-btn-sm layui-btn-radius"style="background-color:#C04D00">
      <a href="./themes/theme3.html">永痕方块</a>
    </button>
  </div>
</div>
  <!-- 声明 -->
  <div class="footer">
      <h2 class="copyright">Copyright ©2020 RedStar08. All Rights Reserved.</h2>  
  </div>
<script type="text/javascript" src="./js/bootstrap.min.js"></script>
<script type="text/javascript" src="./layui/layui.js"></script>
<script type="text/javascript">
  $('#keyword').val("<?php echo $keyword ?>");
  layui.use(['layer', 'form'], function(){
    var layer = layui.layer
    ,form = layui.form;
    form.on('submit(search)', function(data){
      // console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
      // console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
      // console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
      // location.href='index.php?keyword=' + data.field.keyword;
      // return false;
    });
    // layer.msg('Hello World');

  });
</script>
<!-- 知识图谱 -->
<script type="text/javascript">    
  //选择主题
  am4core.useTheme(am4themes_animated)

  //内部数据绑定（php请求并输出）
  // 初始三元组数据
  var AI_json = <?php echo $entity_json ?>;

  // 判断实体是否存在
  if(AI_json.length == 0){
      // 实体不存在
      // 获取实体
      var post_data = <?php echo ($content_json); ?>;
      // console.log(post_data);
      // console.log(post_data.data);

      if(JSON.stringify(post_data) != '{}'){
        // 有关键字
        var name = "<?php echo ($keyword); ?>";
        var post_data_json = [];
        if(JSON.stringify(post_data.data) == '{}'){
          console.log('无数据');
        }
        else {
          console.log('取到数据');
          post_data_json.push({
            "name": name,
            "attribute": "描述",
            "value": post_data.data.desc
          });
          for(i in post_data.data.avp) {
            var attribute = post_data.data.avp[i][0];
            var value = post_data.data.avp[i][1];
            post_data_json.push({
              "name": name,
              "attribute": attribute,
              "value": value
            });
          }
          for(i in post_data.data.tag) {
            var attribute = "标签";
            var value = post_data.data.tag[i];
            post_data_json.push({
              "name": name,
              "attribute": attribute,
              "value": value
            });
          }
          // console.log(post_data_json);
        }
        $.ajax({
              url: "add-entity.php",  
              type: "POST",
              data:{"add-entity":JSON.stringify(post_data_json)},
              error: function(msg){  
                  alert("暂无数据！");  
              },  
              success: function(data){//如果调用php成功            
                  // alert("实体学习成功！");
                  <?php 
                    $url_keyword = urlencode($keyword); 
                    echo "window.location.href='index.php?keyword={$url_keyword}';";
                  ?>
              } 
        });
      }
  }

  // 实体信息
  var entityEnglish = "";
  var entityLabel = [];

  //数据处理函数
  function getList(entityJson) {

      var entityMap = [];
      var attributeMap = [];
      var entityData = [];

      for(var i in entityJson) {
        var entity = entityJson[i];
        if(!entityMap[entity.name]) { //不存在name分类，新建
          entityData.push({
                "name": entity.name,
                "value":30,
                // "details":entity.value,
                "children": [
          
                ]
            });
            entityMap[entity.name] = entity.name;
            entityName = entity.name
        }
        else {  //存在name分类，追加内容
          if(!attributeMap[entity.attribute]) { //不存在attribute分类，新建
            entityData[0].children.push({
              "name":entity.attribute,
              "details":entity.value,
              "value":5,
              "children":[{
                "name":entity.value,
                      "value":10
              }]
            });
            attributeMap[entity.attribute] = entity.attribute;
          }
          else {  //存在attribute分类，添加
            for(var j in entityData[0].children) {
              var children = entityData[0].children[j]
              if(children["name"] == entity.attribute) {  //找到attribute, 添加children
                entityData[0].children[j].children.push({
                  "name":entity.value,
                        "value":10
                });
              }
            }
          }
          }
      }
      // 添加details
      for(var i in entityJson) {
        var entity = entityJson[i];
        if(entity.attribute == "描述") {
          entityData[0]["details"] = entity.value;
        }
        if(entity.attribute == "外文名") {
          entityEnglish = entity.value;
        }
        if(entity.attribute == "标签") {
          entityLabel.push(entity.value);
        }
      }
      // console.log(entityData[0]);
      return entityData;
  }
  // 数据预处理
  var data = getList(AI_json);
  // 实体信息
  var entityName = "";
  var entityDetail = "";
  if(data.length != 0){
  	entityName = data[0].name;
  	entityDetail = data[0].details;
  }

  var entityList = <?php echo $entity_json_like ?>;
  // console.log(entityLike);
  entityLike = Array.from(new Set(entityList));
  // console.log(entityLikes);
  var entityLikes = "";
  for(i in entityLike){
    entityLikes += entityLike[i].name;
    if( i < entityLike.length - 1) {
      entityLikes += "、";
    }
  }
  $('#entityLike').after("<td>"+entityLikes+"</td>");
  
  //赋值
  // console.log(data);
  // console.log(entityName);
  // console.log(entityEnglish);
  // console.log(entityDetail);
  // console.log(entityLabel);
  $('#entityName').after("<td>"+entityName+"</td>");
  $('#entityEnglish').after("<td>"+entityEnglish+"</td>");
  $('#entityDetail').after("<td>"+entityDetail+"</td>");
  var entityLabels = "";
  for(i in entityLabel){
    entityLabels += entityLabel[i];
    if( i < entityLabel.length - 1) {
      entityLabels += "、";
    }
  }
  $('#entityLabel').after("<td>"+entityLabels+"</td>");
  //初始化力导向树
  var chart = am4core.create("chartdiv", am4plugins_forceDirected.ForceDirectedTree);
  var series = chart.series.push(new am4plugins_forceDirected.ForceDirectedSeries());

  // data绑定
  series.dataFields.value = "value";
  series.dataFields.name = "name";
  series.dataFields.children = "children";
  
  //绑定数据
  chart.data = data;
  //外部数据绑定(目前尚未解决)
  //原因：js不能读取本地文件，需转php执行
  // chart.dataSource.url = "../json/example.json";
  // chart.dataSource.parser = new am4core.JSONParser();
  // chart.dataSource.parser.options.emptyAs = 0;

  // 样式
  series.links.template.distance = 1.0;
  series.links.template.strokeWidth = 1.5;
  series.links.template.strokeOpacity = 0.75;
  // series.centerStrength = 1.2;
  series.links.template.strength = 1;
  series.manyBodyStrength = -50;
  series.Radiumins = am4core.percent(0.8);
  series.minRadius = 5;
  series.maxRadius = 30;
  series.nodes.template.label.fontSize = 14;
  series.nodes.template.outerCircle.filters.push(new am4core.DropShadowFilter());
  series.maxLevels = 1;
  series.nodes.template.label.text = "{name}";
  series.nodes.template.tooltipText = "{name}: [bold]{details}[/]";

  series.colors.list = [
    am4core.color("#F38181"),
    am4core.color("#FFD800"),
    am4core.color("#96C120"),
    am4core.color("#F54EA2"),
    am4core.color("#C04D00")
  ];
  series.dataFields.fixed = "fixed";

</script>

</body>
</html>

