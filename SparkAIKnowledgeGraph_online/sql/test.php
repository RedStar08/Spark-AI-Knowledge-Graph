 <?php
 
 	$keyword = "苹果";
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
?>
<script type="text/javascript">
	var post_data = <?php echo ($content); ?>;
	console.log(post_data);
	console.log(post_data.data);
	var name = "<?php echo ($keyword); ?>";
	var post_data_json = [];
	if(JSON.stringify(post_data.data) == '{}'){
		console.log('无数据');
	}
	else {
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
            alert("实体学习成功！");
        } 
      });


</script>