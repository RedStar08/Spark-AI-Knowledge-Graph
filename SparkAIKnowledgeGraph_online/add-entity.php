 <?php
    // 数据库连接
    $con = mysqli_connect('localhost', 'root', '520808', 'sparkai');
    if(!$con){
        echo "Connection error: " . mysqli_connect_error();
    }
    // 得到新的实体数据
    if(isset($_POST['add-entity'])){

        // 转换数据
        $dataSet = json_decode($_POST['add-entity'],true);
        $keyword = $dataSet[0]['name'];
        // 插入数据
        foreach ($dataSet as $data){
            // 更新实体表
            $sql = "INSERT INTO `tb_entity` VALUES ('{$data['name']}', '{$data['attribute']}', '{$data['value']}');";
            $query = mysqli_query($con, $sql);
            if(!$query){
                echo "啊哈，实体学习失败啦";
            }       
        }
        $url_keyword = urlencode($keyword);
        echo "<script>window.location.href='index.php?keyword={$url_keyword}';</script>";
        // echo "index.php?keyword={$keyword}";
    }
    // 关闭连接
    mysqli_close($con);

 ?>