/*
MySQL Code
Host           : localhost:3306
Database       : sparkai
Target Server Type    : MYSQL
Date: 2020-04-19 18:15:08
          ID varchar(100)
*/
-- 创建数据库sparkai
CREATE DATABASE IF NOT EXISTS sparkai
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

-- 取消外码约束
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- **********entity表************
-- Table structure for tb_entity
-- ----------------------------
DROP TABLE IF EXISTS `tb_entity`;
CREATE TABLE `tb_entity` (
  `name` varchar(100) NOT NULL COMMENT '实体名称',
  `attribute` varchar(100) NOT NULL COMMENT '属性',
  `value` varchar(100)  NOT NULL COMMENT '属性值',
  PRIMARY KEY (`name`, `attribute`, `value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='实体表';

-- ----------------------------
-- **********count表************
-- Table structure for `tb_counts`
-- ----------------------------
DROP TABLE IF EXISTS `tb_counts`;
CREATE TABLE `tb_counts` (
  `name` varchar(100) NOT NULL COMMENT '实体名称',
  `counts` int NOT NULL COMMENT '次数统计',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='统计表';

-- -- -------------------------------------
-- -- **************count表触发器**************
-- -- Table update constraint for tb_counts
DELIMITER $$
DROP TRIGGER IF EXISTS `insert_entity_count`$$
CREATE TRIGGER `insert_entity_count` after INSERT ON `tb_entity`
  FOR EACH ROW begin 

    IF NOT EXISTS (select * from tb_counts where tb_counts.name=new.name )

      then INSERT INTO `tb_counts` VALUES (new.name, '0');
    end if;
  end
$$

-- -- -------------------------------------
-- -- **************count表存储过程**************
-- -- Table update constraint for tb_counts
DELIMITER $$
DROP PROCEDURE IF EXISTS `update_count_sum`$$
CREATE PROCEDURE `update_count_sum`(in nname varchar(100))
  BEGIN
     update `tb_counts` set counts = (counts+1) where name='sum';
     update `tb_counts` set counts = (counts+1) where name=nname;
  END
$$
DELIMITER ;

-- ----------------------------
-- **********count表数据*********
-- Records of tb_counts
-- ----------------------------
INSERT INTO `tb_counts` VALUES ("sum",0);

-- ----------------------------
-- **********entity表数据*********
-- Records of tb_entity
-- ----------------------------
INSERT INTO `tb_entity` VALUES ("机器人","描述","机器人（Robot）是自动执行工作的机器装置。");
INSERT INTO `tb_entity` VALUES ("机器人","中文名","机器人");
INSERT INTO `tb_entity` VALUES ("机器人","外文名","Robot");
INSERT INTO `tb_entity` VALUES ("机器人","定义","自动执行工作的机器装置");
INSERT INTO `tb_entity` VALUES ("机器人","技术","人工智能技术");
INSERT INTO `tb_entity` VALUES ("机器人","驱动装置","微型计算机");
INSERT INTO `tb_entity` VALUES ("机器人","标签","科学");

INSERT INTO `tb_entity` VALUES ("机器人","标签","自动化");
INSERT INTO `tb_entity` VALUES ("机器人","标签","计算机控制");
INSERT INTO `tb_entity` VALUES ("机器人","用途","家务型");
INSERT INTO `tb_entity` VALUES ("机器人","用途","操作型");
INSERT INTO `tb_entity` VALUES ("机器人","用途","搜救类");
INSERT INTO `tb_entity` VALUES ("机器人","用途","服务类");
INSERT INTO `tb_entity` VALUES ("机器人","组成","执行机构");
INSERT INTO `tb_entity` VALUES ("机器人","组成","驱动装置");
INSERT INTO `tb_entity` VALUES ("机器人","组成","检测装置");
INSERT INTO `tb_entity` VALUES ("机器人","组成","控制系统");
INSERT INTO `tb_entity` VALUES ("机器人","组成","复杂机械");

INSERT INTO `tb_entity` VALUES ("人工智能","描述","人工智能（Artificial Intelligence），英文缩写为AI。");
INSERT INTO `tb_entity` VALUES ("人工智能","中文名","人工智能");
INSERT INTO `tb_entity` VALUES ("人工智能","外文名","ARTIFICIAL INTELLIGENCE");
INSERT INTO `tb_entity` VALUES ("人工智能","简称","AI");
INSERT INTO `tb_entity` VALUES ("人工智能","提出时间","1956年");
INSERT INTO `tb_entity` VALUES ("人工智能","提出地点","DARTMOUTH学会");
INSERT INTO `tb_entity` VALUES ("人工智能","名称来源","雨果·德·加里斯 的著作");
INSERT INTO `tb_entity` VALUES ("人工智能","标签","中国通信学会");
INSERT INTO `tb_entity` VALUES ("人工智能","标签","学科");
INSERT INTO `tb_entity` VALUES ("数据挖掘","描述","数据挖掘（英语：Data mining），又译为资料探勘、数据采矿。");
INSERT INTO `tb_entity` VALUES ("数据挖掘","中文名","数据挖掘");
INSERT INTO `tb_entity` VALUES ("数据挖掘","外文名","Data mining");
INSERT INTO `tb_entity` VALUES ("数据挖掘","别名","资料探勘");
INSERT INTO `tb_entity` VALUES ("数据挖掘","别名","数据采矿");
INSERT INTO `tb_entity` VALUES ("数据挖掘","所属学科","计算机科学");
INSERT INTO `tb_entity` VALUES ("数据挖掘","应用领域","情报检索、数据分析、模式识别等");
INSERT INTO `tb_entity` VALUES ("数据挖掘","相关领域","人工智能、数据库");
INSERT INTO `tb_entity` VALUES ("数据挖掘","标签","中国通信学会");
INSERT INTO `tb_entity` VALUES ("数据挖掘","标签","技术");
INSERT INTO `tb_entity` VALUES ("数据挖掘","标签","互联网");
INSERT INTO `tb_entity` VALUES ("智能制造","描述","智能制造，源于人工智能的研究。");
INSERT INTO `tb_entity` VALUES ("智能制造","中文名","智能制造");
INSERT INTO `tb_entity` VALUES ("智能制造","外文名","Intelligent Manufacturing");
INSERT INTO `tb_entity` VALUES ("智能制造","起源","于人工智能的研究");
INSERT INTO `tb_entity` VALUES ("智能制造","性质","智能是知识和智力的总和");
INSERT INTO `tb_entity` VALUES ("智能制造","标签","科学百科信息");
INSERT INTO `tb_entity` VALUES ("自然语言处理","描述","自然语言处理是计算机科学领域与人工智能领域中的一个重要方向。");
INSERT INTO `tb_entity` VALUES ("自然语言处理","中文名","自然语言处理");
INSERT INTO `tb_entity` VALUES ("自然语言处理","外文名","natural language processing");
INSERT INTO `tb_entity` VALUES ("自然语言处理","适用领域","计算机、人工智能");
INSERT INTO `tb_entity` VALUES ("自然语言处理","缩写","NLP");
INSERT INTO `tb_entity` VALUES ("自然语言处理","标签","中国电子学会");
INSERT INTO `tb_entity` VALUES ("自然语言处理","标签","科学");
INSERT INTO `tb_entity` VALUES ("人工神经网络","描述","人工神经网络（Artificial Neural Network，即ANN ），是20世纪80 年代以来人工智能领域兴起的研究热点。");
INSERT INTO `tb_entity` VALUES ("人工神经网络","中文名","人工神经网络");
INSERT INTO `tb_entity` VALUES ("人工神经网络","外文名","artificial neural network");
INSERT INTO `tb_entity` VALUES ("人工神经网络","别称","ANN");
INSERT INTO `tb_entity` VALUES ("人工神经网络","应用学科","人工智能");
INSERT INTO `tb_entity` VALUES ("人工神经网络","适用领域范围","模式分类");
INSERT INTO `tb_entity` VALUES ("人工神经网络","标签","生物学");
INSERT INTO `tb_entity` VALUES ("人工神经网络","标签","物理化学");
INSERT INTO `tb_entity` VALUES ("AAAI","描述","国际人工智能协会。");
INSERT INTO `tb_entity` VALUES ("AAAI","中文名","国际人工智能协会");
INSERT INTO `tb_entity` VALUES ("AAAI","外文名","The Association for the Advancement of Artificial Intelligence(AAAI)");
INSERT INTO `tb_entity` VALUES ("AAAI","性质","非盈利的学术研究组织");
INSERT INTO `tb_entity` VALUES ("AAAI","目的","推动针对智能行为本质的科学研究");
INSERT INTO `tb_entity` VALUES ("AAAI","前身","美国人工智能协会");
INSERT INTO `tb_entity` VALUES ("AAAI","标签","组织机构");
INSERT INTO `tb_entity` VALUES ("智能武器","描述","智能武器指的是具有人工智能的武器，通常由信息采集与处理系统、知识库系统、辅助决策系统和任务执行系统等组成。");
INSERT INTO `tb_entity` VALUES ("智能武器","中文名","智能武器");
INSERT INTO `tb_entity` VALUES ("智能武器","外文名","artificial intelligence weapon");
INSERT INTO `tb_entity` VALUES ("智能武器","简称","人工智能武器");
INSERT INTO `tb_entity` VALUES ("智能武器","智能武器拼音","Zhìnéng wǔqì");
INSERT INTO `tb_entity` VALUES ("智能武器","标签","社会");
INSERT INTO `tb_entity` VALUES ("智能武器","标签","武器装备");
INSERT INTO `tb_entity` VALUES ("阿尔法围棋","描述","阿尔法狗（AlphaGo）是第一个击败人类职业围棋选手、第一个战胜围棋世界冠军的人工智能程序，由谷歌（Google）旗下DeepMind公司戴密斯·哈萨比斯领衔的团队开发。");
INSERT INTO `tb_entity` VALUES ("阿尔法围棋","中文名","阿尔法围棋");
INSERT INTO `tb_entity` VALUES ("阿尔法围棋","外文名","AlphaGo");
INSERT INTO `tb_entity` VALUES ("阿尔法围棋","开发商","DeepMind");
INSERT INTO `tb_entity` VALUES ("阿尔法围棋","设计者","戴密斯·哈萨比斯、大卫·席尔瓦等");
INSERT INTO `tb_entity` VALUES ("阿尔法围棋","重大事件","围棋人机大战");
INSERT INTO `tb_entity` VALUES ("阿尔法围棋","主要成绩","战胜人类围棋顶尖高手");
INSERT INTO `tb_entity` VALUES ("阿尔法围棋","标签","科学");
INSERT INTO `tb_entity` VALUES ("图灵测试","描述","图灵测试（The Turing test）由艾伦·麦席森·图灵发明，指测试者与被测试者（一个人和一台机器）隔开的情况下，通过一些装置（如键盘）向被测试者随意提问。");
INSERT INTO `tb_entity` VALUES ("图灵测试","中文名","图灵测试");
INSERT INTO `tb_entity` VALUES ("图灵测试","外文名","The Turing test");
INSERT INTO `tb_entity` VALUES ("图灵测试","发明者","艾伦·麦席森·图灵");
INSERT INTO `tb_entity` VALUES ("图灵测试","类别","对人工智能的测试");
INSERT INTO `tb_entity` VALUES ("图灵测试","提出时间","1950年");
INSERT INTO `tb_entity` VALUES ("图灵测试","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("图灵测试","标签","科学");
INSERT INTO `tb_entity` VALUES ("可计算性理论","描述","可计算性理论（Computability theory）作为计算理论的一个分支，研究在不同的计算模型下哪些算法问题能够被解决。");
INSERT INTO `tb_entity` VALUES ("可计算性理论","中文名","可计算性理论");
INSERT INTO `tb_entity` VALUES ("可计算性理论","外文名","computability theory");
INSERT INTO `tb_entity` VALUES ("可计算性理论","学科","计算机、数学");
INSERT INTO `tb_entity` VALUES ("可计算性理论","又称","算法理论");
INSERT INTO `tb_entity` VALUES ("可计算性理论","基础","算法设计与分析的基础");
INSERT INTO `tb_entity` VALUES ("可计算性理论","应用领域","并行计算、人工智能");
INSERT INTO `tb_entity` VALUES ("可计算性理论","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("面向对象","描述","面向对象(Object Oriented,OO)是软件开发方法。");
INSERT INTO `tb_entity` VALUES ("面向对象","中文名","面向对象");
INSERT INTO `tb_entity` VALUES ("面向对象","外文名","Object Oriented,OO");
INSERT INTO `tb_entity` VALUES ("面向对象","作用","软件开发");
INSERT INTO `tb_entity` VALUES ("面向对象","使用领域","CAD技术、人工智能等");
INSERT INTO `tb_entity` VALUES ("面向对象","标签","中国电子学会");
INSERT INTO `tb_entity` VALUES ("面向对象","标签","通信技术");
INSERT INTO `tb_entity` VALUES ("空间决策支持系统","描述","决策支持系统是综合利用各种数据、信息、知识、人工智能和模型技术，辅助高级决策解决半结构化或非结构化决策问题。");
INSERT INTO `tb_entity` VALUES ("空间决策支持系统","中文名","空间决策支持系统");
INSERT INTO `tb_entity` VALUES ("空间决策支持系统","概念","非结构化决策问题");
INSERT INTO `tb_entity` VALUES ("空间决策支持系统","内容","空间决策支持");
INSERT INTO `tb_entity` VALUES ("空间决策支持系统","组成部分","空间数据库等相互依存、相互作用");
INSERT INTO `tb_entity` VALUES ("空间决策支持系统","标签","科技产品");
INSERT INTO `tb_entity` VALUES ("空间决策支持系统","标签","互联网产品");
INSERT INTO `tb_entity` VALUES ("析取范式","描述","在离散数学中，仅由有限个文字构成的合取式称为简单合取式，而由有限个简单合取式构成的析取式称为析取范式。");
INSERT INTO `tb_entity` VALUES ("析取范式","中文名","析取范式");
INSERT INTO `tb_entity` VALUES ("析取范式","外文名","disjunctive normal form");
INSERT INTO `tb_entity` VALUES ("析取范式","学科","离散数学");
INSERT INTO `tb_entity` VALUES ("析取范式","简称","DNF");
INSERT INTO `tb_entity` VALUES ("析取范式","相关术语","合取范式");
INSERT INTO `tb_entity` VALUES ("析取范式","应用领域","人工智能、数据挖掘");
INSERT INTO `tb_entity` VALUES ("析取范式","标签","科学百科数理科学分类");
INSERT INTO `tb_entity` VALUES ("析取范式","标签","科学");
INSERT INTO `tb_entity` VALUES ("析取","描述","在离散数学中，命题是一个陈述句，它或真或假，但不能既真又假。");
INSERT INTO `tb_entity` VALUES ("析取","中文名","析取");
INSERT INTO `tb_entity` VALUES ("析取","外文名","Disjunctive");
INSERT INTO `tb_entity` VALUES ("析取","性质","一个二元逻辑算符“或”");
INSERT INTO `tb_entity` VALUES ("析取","领域","人工智能、数学、数据挖掘");
INSERT INTO `tb_entity` VALUES ("析取","学科","离散数学、计算机科学");
INSERT INTO `tb_entity` VALUES ("析取","相关术语","合取");
INSERT INTO `tb_entity` VALUES ("析取","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("析取","标签","科学");
INSERT INTO `tb_entity` VALUES ("计算机专家系统","描述","计算机专家系统是人工智能领域唯一有商品化实用价值的软件系统。");
INSERT INTO `tb_entity` VALUES ("计算机专家系统","中文名","计算机专家系统");
INSERT INTO `tb_entity` VALUES ("计算机专家系统","外文名","Computer expert system");
INSERT INTO `tb_entity` VALUES ("计算机专家系统","简介","一组程序软件");
INSERT INTO `tb_entity` VALUES ("计算机专家系统","应用领域","人工智能领域");
INSERT INTO `tb_entity` VALUES ("计算机专家系统","标签","计算机书籍");
INSERT INTO `tb_entity` VALUES ("计算机专家系统","标签","出版物");
INSERT INTO `tb_entity` VALUES ("计算机专家系统","标签","书籍");
INSERT INTO `tb_entity` VALUES ("爬山算法","描述","爬山算法是一种局部择优的方法，采用启发式方法，是对深度优先搜索的一种改进，它利用反馈信息帮助生成解的决策。");
INSERT INTO `tb_entity` VALUES ("爬山算法","中文名","爬山算法");
INSERT INTO `tb_entity` VALUES ("爬山算法","外文名","Hill Climbing");
INSERT INTO `tb_entity` VALUES ("爬山算法","类型","一种局部择优的方法");
INSERT INTO `tb_entity` VALUES ("爬山算法","采用","启发式方法");
INSERT INTO `tb_entity` VALUES ("爬山算法","属于","人工智能算法的一种");
INSERT INTO `tb_entity` VALUES ("LISP","描述","LISP是一种通用高级计算机程序语言，长期以来垄断人工智能领域的应用。");
INSERT INTO `tb_entity` VALUES ("LISP","中文名","LISP");
INSERT INTO `tb_entity` VALUES ("LISP","外文名","LISP Programming Language");
INSERT INTO `tb_entity` VALUES ("LISP","类  别","计算机程序设计语言");
INSERT INTO `tb_entity` VALUES ("LISP","创始人","约翰·麦卡锡");
INSERT INTO `tb_entity` VALUES ("LISP","创始时间","1958年");
INSERT INTO `tb_entity` VALUES ("LISP","发源","IPL");
INSERT INTO `tb_entity` VALUES ("LISP","启发语言","JavaScript,Perl,Ruby,Python");
INSERT INTO `tb_entity` VALUES ("LISP","标签","科学");
INSERT INTO `tb_entity` VALUES ("小Q","描述","QQ机器人是腾讯公司陆续推出的人工智能聊天机器人的总称，目前已经推出小Q弟弟（已经变成了爷们）来陪大家聊天。");
INSERT INTO `tb_entity` VALUES ("小Q","中文名","小Q");
INSERT INTO `tb_entity` VALUES ("小Q","开发机构","腾讯公司");
INSERT INTO `tb_entity` VALUES ("小Q","作用","查询邮编、手机号");
INSERT INTO `tb_entity` VALUES ("小Q","标签","手机");
INSERT INTO `tb_entity` VALUES ("小Q","标签","字词");
INSERT INTO `tb_entity` VALUES ("模糊计算机","描述","日常生活中常碰到诸如天气怎么样啦，近来有何打算，身体可好啊等等发问。");
INSERT INTO `tb_entity` VALUES ("模糊计算机","中文名","模糊计算机");
INSERT INTO `tb_entity` VALUES ("模糊计算机","外文名","Fuzzy Computer");
INSERT INTO `tb_entity` VALUES ("模糊计算机","类别","计算机");
INSERT INTO `tb_entity` VALUES ("模糊计算机","主题词","信息科学");
INSERT INTO `tb_entity` VALUES ("模糊计算机","类型","数字化 人工智能");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","描述","马文·明斯基是“人工智能之父”和框架理论的创立者。");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","中文名","马文·明斯基");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","外文名","Marvin Lee Minsky");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","国籍","美国");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","出生地","纽约市");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","出生日期","1927年8月9日");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","逝世日期","2016年1月24日");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","职业","科学家");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","主要成就","人工智能框架理论的创立者");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","主要成就","人工智能之父");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","代表作品","1969年图灵奖获得者，创建麻省理工学院(MIT)人工智能实验室，《情感机器》《心智社会》。");
INSERT INTO `tb_entity` VALUES ("马文·明斯基","标签","人物");
INSERT INTO `tb_entity` VALUES ("机器视觉","描述","机器视觉是人工智能正在快速发展的一个分支。");
INSERT INTO `tb_entity` VALUES ("机器视觉","中文名","机器视觉");
INSERT INTO `tb_entity` VALUES ("机器视觉","外文名","machine vision");
INSERT INTO `tb_entity` VALUES ("机器视觉","定义","用机器代替人眼来做测量和判断");
INSERT INTO `tb_entity` VALUES ("机器视觉","应用范围","工业、农业、医药、军事、航天等");
INSERT INTO `tb_entity` VALUES ("机器视觉","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("机器视觉","标签","科学");
INSERT INTO `tb_entity` VALUES ("NLP技术","描述","自然语言处理(NLP，Natural Language Processing) 是研究人与计算机交互的语言问题的一门学科。");
INSERT INTO `tb_entity` VALUES ("NLP技术","中文名","NLP（自然语言处理）技术");
INSERT INTO `tb_entity` VALUES ("NLP技术","外文名","Natural Language Processing");
INSERT INTO `tb_entity` VALUES ("NLP技术","内容","研究人与计算机交互的语言问题");
INSERT INTO `tb_entity` VALUES ("NLP技术","课题","语言信息处理、人工智能");
INSERT INTO `tb_entity` VALUES ("粗糙集","描述","粗糙集理论，是继概率论、模糊集、证据理论之后的又一个处理不确定性的数学工具。");
INSERT INTO `tb_entity` VALUES ("粗糙集","中文名","粗糙集");
INSERT INTO `tb_entity` VALUES ("粗糙集","外文名","rough set");
INSERT INTO `tb_entity` VALUES ("粗糙集","领域","计算机科学");
INSERT INTO `tb_entity` VALUES ("粗糙集","应用","人工智能");
INSERT INTO `tb_entity` VALUES ("粗糙集","创始人","Z. Pawlak");
INSERT INTO `tb_entity` VALUES ("粗糙集","创始时间","1982");
INSERT INTO `tb_entity` VALUES ("粗糙集","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("颜色恒常性","描述","在人体生物学领域中，颜色恒常性是指当照射物体表面的颜色光发生变化时，人们对该物体表面颜色的知觉仍然保持不变的知觉特性。");
INSERT INTO `tb_entity` VALUES ("颜色恒常性","中文名","颜色恒常性");
INSERT INTO `tb_entity` VALUES ("颜色恒常性","外文名","Color Constancy");
INSERT INTO `tb_entity` VALUES ("颜色恒常性","类别","人体知觉、图像处理、人工智能");
INSERT INTO `tb_entity` VALUES ("颜色恒常性","含义","视觉对物体颜色变化认知的不变性");
INSERT INTO `tb_entity` VALUES ("颜色恒常性","标签","科学");
INSERT INTO `tb_entity` VALUES ("自然语言理解","描述","自然语言处理是计算机科学领域与人工智能领域中的一个重要方向。");
INSERT INTO `tb_entity` VALUES ("自然语言理解","中文名","自然语言理解");
INSERT INTO `tb_entity` VALUES ("自然语言理解","外文名","Natural Language Understanding");
INSERT INTO `tb_entity` VALUES ("自然语言理解","领域","软件算法，人工智能");
INSERT INTO `tb_entity` VALUES ("自然语言理解","研究方向","系统输入和系统输出");
INSERT INTO `tb_entity` VALUES ("分支限界搜索","描述","分支限界法是以广度优先或以最小耗费 (最大效益) 优先的方式在问题的解空间树T上搜索问题解的一种搜索方法。");
INSERT INTO `tb_entity` VALUES ("分支限界搜索","中文名","分支限界搜索");
INSERT INTO `tb_entity` VALUES ("分支限界搜索","外文名","branch and boundsearch");
INSERT INTO `tb_entity` VALUES ("分支限界搜索","求解目标","最优解");
INSERT INTO `tb_entity` VALUES ("分支限界搜索","性质","搜索算法");
INSERT INTO `tb_entity` VALUES ("分支限界搜索","领域","人工智能");
INSERT INTO `tb_entity` VALUES ("分支限界搜索","学科","计算机");
INSERT INTO `tb_entity` VALUES ("分支限界搜索","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("智能语言","描述","智能语言 任何人工智能系统的构成必须有相应的语言。");
INSERT INTO `tb_entity` VALUES ("强人工智能","描述","强人工智能观点认为有可能制造出真正能推理（Reasoning）和解决问题（Problem_solving）的智能机器，并且，这样的机器能将被认为是有知觉的，有自我意识的。");
INSERT INTO `tb_entity` VALUES ("强人工智能","中文名","强人工智能");
INSERT INTO `tb_entity` VALUES ("强人工智能","创立人","约翰·罗杰斯·希尔勒");
INSERT INTO `tb_entity` VALUES ("强人工智能","特点","具有自我意识的人工智能");
INSERT INTO `tb_entity` VALUES ("强人工智能","创立时间","1980");
INSERT INTO `tb_entity` VALUES ("强人工智能","标签","科学");
INSERT INTO `tb_entity` VALUES ("弱人工智能","描述","弱人工智能是指不能制造出真正地推理（Reasoning）和解决问题（Problem_solving）的智能机器，这些机器只不过看起来像是智能的，但是并不真正拥有智能，也不会有自主意识。");
INSERT INTO `tb_entity` VALUES ("弱人工智能","中文名","弱人工智能");
INSERT INTO `tb_entity` VALUES ("弱人工智能","外文名","AI");
INSERT INTO `tb_entity` VALUES ("弱人工智能","创建人","约翰·罗杰斯·希尔勒");
INSERT INTO `tb_entity` VALUES ("弱人工智能","创建时间","1980年");
INSERT INTO `tb_entity` VALUES ("弱人工智能","标签","科学");
INSERT INTO `tb_entity` VALUES ("计算机智能","描述","计算机智能(CI:Computer Intelligence)是指：利用计算机模拟人的思维方式进行推理，判断的技术. 计算机智能其实质等同于发展多年的人工智能，但严格说的话，计算机智能面更广一点，其可以不仅仅是模拟人的思维方式，还可以模拟是其它一些自然规律、定理，总体目的就是使计算机能够更加符合所要模拟的事物形态，使其凌驾与普通计算机程序执行之上，从而达到常规计算机运算不能达到的效果 ...");
INSERT INTO `tb_entity` VALUES ("可废止推理","描述","可废止推理是对推理形式的研究，它尽管令人信服，却不如演绎推理那么形式化和严格。");
INSERT INTO `tb_entity` VALUES ("可废止推理","中文名","可废止推理");
INSERT INTO `tb_entity` VALUES ("可废止推理","研究","对推理形式的研究");
INSERT INTO `tb_entity` VALUES ("可废止推理","哲学起源","尽管亚里士多德把对逻辑和哲学");
INSERT INTO `tb_entity` VALUES ("可废止推理","人工智能","先驱如约翰·麦卡锡");
INSERT INTO `tb_entity` VALUES ("可废止推理","标签","科学");
INSERT INTO `tb_entity` VALUES ("ASUS人工智能","描述","ASUS人工智能特性是华硕最新推出的系列主板特色技术，主要应用于高端新型号主板产品上。");
INSERT INTO `tb_entity` VALUES ("ASUS人工智能","中文名","ASUS人工智能");
INSERT INTO `tb_entity` VALUES ("ASUS人工智能","推出公司","华硕");
INSERT INTO `tb_entity` VALUES ("ASUS人工智能","主要应用","高端新型号主板产品");
INSERT INTO `tb_entity` VALUES ("ASUS人工智能","四个部分","AI 音效AI 网络AI BIOSAI 超频");
INSERT INTO `tb_entity` VALUES ("ASUS人工智能","标签","科技产品");
INSERT INTO `tb_entity` VALUES ("ASUS人工智能","标签","互联网产品");
INSERT INTO `tb_entity` VALUES ("ASUS人工智能","标签","互联网");
INSERT INTO `tb_entity` VALUES ("人工智能AIEC","描述","人工智能AIEC(Artifical Intelligence Irror Correction):所谓人工智能容错技术就是采用一种，通过对成千上万张有各种毛病的盘片进行读盘测试，通过特殊的软件将每张光盘的读盘情况记录下来。");
INSERT INTO `tb_entity` VALUES ("人工智能AIEC","中文名","人工智能AIEC");
INSERT INTO `tb_entity` VALUES ("人工智能AIEC","外文名","Artifical Intelligence Irror Correction");
INSERT INTO `tb_entity` VALUES ("人工智能AIEC","技术","模糊控制技术");
INSERT INTO `tb_entity` VALUES ("人工智能AIEC","优点","对症下药");
INSERT INTO `tb_entity` VALUES ("人工智能语言","描述","人工智能（AI）语言是一类适应于人工智能和知识工程领域的、具有符号处理和逻辑推理能力的计算机程序设计语言。");
INSERT INTO `tb_entity` VALUES ("人工智能语言","中文名","人工智能语言");
INSERT INTO `tb_entity` VALUES ("人工智能语言","外文名","AI language");
INSERT INTO `tb_entity` VALUES ("人工智能语言","属于","计算机程序设计语言");
INSERT INTO `tb_entity` VALUES ("人工智能语言","举例","LISP、Prolog、Smalltalk、C++");
INSERT INTO `tb_entity` VALUES ("人工智能语言","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("人工智能语言","标签","科学");
INSERT INTO `tb_entity` VALUES ("时态GIS","描述","时态GIS是建立在时态数据库、GIS、人工智能等基础上的一种综合型应用性技术，其研究对象是时空世界中遵循着诞生、成长、生存，直至死亡等自然规律的事物和现象的时空信息。");
INSERT INTO `tb_entity` VALUES ("时态GIS","中文名","时态GIS");
INSERT INTO `tb_entity` VALUES ("时态GIS","性质","一种综合型应用性技术");
INSERT INTO `tb_entity` VALUES ("时态GIS","建立基础","时态数据库、GIS、人工智能等");
INSERT INTO `tb_entity` VALUES ("时态GIS","含义","现实世界是随时间连续变化的");
INSERT INTO `tb_entity` VALUES ("反演","描述","反演是指能够模仿人类智能的计算机程序系统的人工智能系统，它具有学习和推理的功能。");
INSERT INTO `tb_entity` VALUES ("反演","中文名","反演");
INSERT INTO `tb_entity` VALUES ("反演","外文名","inversion");
INSERT INTO `tb_entity` VALUES ("反演","别名","人工智能反演");
INSERT INTO `tb_entity` VALUES ("反演","含义","有学习推理的能力的人工智能系统");
INSERT INTO `tb_entity` VALUES ("反演","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("反演","标签","科学");
INSERT INTO `tb_entity` VALUES ("反演","标签","文化");
INSERT INTO `tb_entity` VALUES ("启发式算法","描述","启发式算法（heuristic algorithm)是相对于最优化算法提出的。");
INSERT INTO `tb_entity` VALUES ("启发式算法","中文名","启发式算法");
INSERT INTO `tb_entity` VALUES ("启发式算法","外文名","heuristic algorithm");
INSERT INTO `tb_entity` VALUES ("启发式算法","主要方法","蚁群算法、模拟退火法、神经网络");
INSERT INTO `tb_entity` VALUES ("启发式算法","类别","人工智能算法");
INSERT INTO `tb_entity` VALUES ("启发式算法","学科","计算机");
INSERT INTO `tb_entity` VALUES ("启发式算法","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("启发式算法","标签","科学");
INSERT INTO `tb_entity` VALUES ("智能计算","描述","智能计算只是一种经验化的计算机思考性程序，是人工智能化体系的一个分支，其是辅助人类去处理各式问题的具有独立思考能力的系统。");
INSERT INTO `tb_entity` VALUES ("军用人工智能","描述","军用人工智能 是计算机模仿人的部分智能，如识别图形、听懂语言、适应环境、接受启发、学习、推理等技术在军事领域的应用，是研究计算机用来完成军事活动中关于部分推理、判断、决策、探索、控制、图形识别、制导、环境适应等有关理论、技术和方法的智能活动。");
INSERT INTO `tb_entity` VALUES ("第五代语言","描述","第五代语言就是自然语言又被称为知识库语言或人工智能语言，目标是最接近日常生活所用语言的程序语言。");
INSERT INTO `tb_entity` VALUES ("第五代语言","中文名","第五代语言");
INSERT INTO `tb_entity` VALUES ("第五代语言","外文名","The fifth generation language");
INSERT INTO `tb_entity` VALUES ("第五代语言","别称","知识库语言或人工智能语言");
INSERT INTO `tb_entity` VALUES ("第五代语言","举例","LISP和PROLOG");
INSERT INTO `tb_entity` VALUES ("第五代语言","标签","语言术语");
INSERT INTO `tb_entity` VALUES ("第五代语言","标签","科技产品");
INSERT INTO `tb_entity` VALUES ("第五代语言","标签","科学");
INSERT INTO `tb_entity` VALUES ("智能CAD","描述","智能CAD是指通过运用专家系统、人工神经网络等人工智能技术使在作业过程中具有某种程度人工智能的CAD系统。");
INSERT INTO `tb_entity` VALUES ("智能CAD","中文名","智能CAD");
INSERT INTO `tb_entity` VALUES ("智能CAD","外文名","smartCAD");
INSERT INTO `tb_entity` VALUES ("智能CAD","1","专家系统、人工神经网络");
INSERT INTO `tb_entity` VALUES ("智能CAD","2","人工智能的CAD系统。");
INSERT INTO `tb_entity` VALUES ("智能CAD","3","在作业过程");
INSERT INTO `tb_entity` VALUES ("机器视觉技术","描述","机器视觉技术，是一门涉及人工智能、神经生物学、心理物理学、计算机科学、图像处理、模式识别等诸多领域的交叉学科。");
INSERT INTO `tb_entity` VALUES ("机器视觉技术","中文名","机器视觉技术");
INSERT INTO `tb_entity` VALUES ("机器视觉技术","类型","视觉技术");
INSERT INTO `tb_entity` VALUES ("机器视觉技术","功能","用于实际检测、测量和控制");
INSERT INTO `tb_entity` VALUES ("机器视觉技术","优点","模式识别等诸多领域的交叉学科");
INSERT INTO `tb_entity` VALUES ("人工智能调节器","描述","人工智能调节器属于万能输入，可与类传感器、变送器配合使用，大大减少备表数量");
INSERT INTO `tb_entity` VALUES ("BDI模型","描述","面向主体(agent)的系统越来越具有广泛的应用价值，在理性主体(agent)的形式化过程中，通常认为主体(agent)的思维状态包括信念、愿望和意图这三个属性，因此BDI模型一直是主体(agent)建模研究的重点。");
INSERT INTO `tb_entity` VALUES ("BDI模型","中文名","BDI 模型");
INSERT INTO `tb_entity` VALUES ("BDI模型","外文名","Belief–desire–intention model");
INSERT INTO `tb_entity` VALUES ("BDI模型","领域","人工智能");
INSERT INTO `tb_entity` VALUES ("BDI模型","标签","组织机构");
INSERT INTO `tb_entity` VALUES ("BDI模型","标签","科技产品");
INSERT INTO `tb_entity` VALUES ("BDI模型","标签","社会");
INSERT INTO `tb_entity` VALUES ("特征点","描述","图像处理中，特征点指的是图像灰度值发生剧烈变化的点或者在图像边缘上曲率较大的点(即两个边缘的交点)。");
INSERT INTO `tb_entity` VALUES ("特征点","中文名","(图像)特征点");
INSERT INTO `tb_entity` VALUES ("特征点","外文名","Image feature points");
INSERT INTO `tb_entity` VALUES ("特征点","领域","人工智能");
INSERT INTO `tb_entity` VALUES ("特征点","性质","明确的图形图像特征");
INSERT INTO `tb_entity` VALUES ("特征点","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("特征点","标签","非地理");
INSERT INTO `tb_entity` VALUES ("特征点","标签","文化");
INSERT INTO `tb_entity` VALUES ("KC网络电话","描述","KC网络电话是一款网络与网络、网络与电话的通信软件。");
INSERT INTO `tb_entity` VALUES ("KC网络电话","中文名","KC网络电话");
INSERT INTO `tb_entity` VALUES ("KC网络电话","性质","通信软件");
INSERT INTO `tb_entity` VALUES ("KC网络电话","功能","智能网络通讯录");
INSERT INTO `tb_entity` VALUES ("KC网络电话","技术","网络搜索及人工智能");
INSERT INTO `tb_entity` VALUES ("KC网络电话","标签","科技产品");
INSERT INTO `tb_entity` VALUES ("KC网络电话","标签","科学");
INSERT INTO `tb_entity` VALUES ("KC网络电话","标签","互联网");
INSERT INTO `tb_entity` VALUES ("机器意识","描述","机器意识是人工智能技术的新一个里程碑，从研究策略来看，机器意识的研究主要分为算法构造策略与仿脑构造策略两种途径。");
INSERT INTO `tb_entity` VALUES ("机器意识","中文名","全球首个高清");
INSERT INTO `tb_entity` VALUES ("机器意识","技术","人工智能技术");
INSERT INTO `tb_entity` VALUES ("机器意识","研究","算法构造策略与仿脑构造策略");
INSERT INTO `tb_entity` VALUES ("机器意识","研究方向","机器意识");
INSERT INTO `tb_entity` VALUES ("机器视觉系统","描述","机器视觉系统就是利用机器代替人眼来作各种测量和判断。");
INSERT INTO `tb_entity` VALUES ("机器视觉系统","中文名","机器视觉系统");
INSERT INTO `tb_entity` VALUES ("机器视觉系统","释义","机器代替人眼来作各种测量和判断");
INSERT INTO `tb_entity` VALUES ("机器视觉系统","包括","光学、机械、计算机软硬件等");
INSERT INTO `tb_entity` VALUES ("机器视觉系统","领域","图像处理、模式识别、人工智能等");
INSERT INTO `tb_entity` VALUES ("机器视觉系统","标签","科学");
INSERT INTO `tb_entity` VALUES ("情感机器人","描述","情感机器人就是用人工的方法和技术赋予计算机或机器人以人类式的情感，使之具有表达、识别和理解喜乐哀怒，模仿、延伸和扩展人的情感的能力，是许多科学家的梦想，与人工智能技术的高度发展相比，人工情感技术所取得的进展却是微乎其微，情感始终是横跨在人脑与电脑之间一条无法愈越的鸿沟。");
INSERT INTO `tb_entity` VALUES ("情感机器人","中文名","情感机器人");
INSERT INTO `tb_entity` VALUES ("情感机器人","特点","表达感情");
INSERT INTO `tb_entity` VALUES ("情感机器人","性质","机器人");
INSERT INTO `tb_entity` VALUES ("情感机器人","发展方式","人工智能");
INSERT INTO `tb_entity` VALUES ("情感机器人","标签","科技产品");
INSERT INTO `tb_entity` VALUES ("情感机器人","标签","电子产品");
INSERT INTO `tb_entity` VALUES ("智能工程","描述","智能工程具有多门学科融合集成的综合特点，由于发展历史较短，但发展速度很快，国内外对它的定义有各种描述和不同理解，尚无统一的确切概念和标准。");
INSERT INTO `tb_entity` VALUES ("智能工程","中文名","智能工程");
INSERT INTO `tb_entity` VALUES ("智能工程","外文名","Intelligent engineering");
INSERT INTO `tb_entity` VALUES ("智能工程","相关","人工智能");
INSERT INTO `tb_entity` VALUES ("智能工程","标签","科技产品");
INSERT INTO `tb_entity` VALUES ("智能工程","标签","科学");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","描述","第四次科技革命，是继蒸汽技术革命（第一次工业革命），电力技术革命（第二次工业革命），计算机及信息技术革命（第三次工业革命）的又一次科技革命。");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","中文名","第四次工业革命");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","外文名","The fourth revolution of science and technology");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","时间","21世纪");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","实质和特征","提高资源生产率 减少污染排放");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","目标","人工智能化");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","特点","灵活易变、高资源效率");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","兴起地","中国、日、德、美等科技大国");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","代表","虚拟现实，人工智能，量子通信");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","标签","社会");
INSERT INTO `tb_entity` VALUES ("第四次工业革命","标签","历史");
INSERT INTO `tb_entity` VALUES ("评价函数","描述","在启发式搜索中，用于评价节点重要性的函数叫做评价函数。");
INSERT INTO `tb_entity` VALUES ("评价函数","中文名","评价函数");
INSERT INTO `tb_entity` VALUES ("评价函数","外文名","Evaluation function");
INSERT INTO `tb_entity` VALUES ("评价函数","所属领域","人工智能");
INSERT INTO `tb_entity` VALUES ("评价函数","基本形式","f(x)=g(x)+h(x）");
INSERT INTO `tb_entity` VALUES ("评价函数","所属学科","计算机");
INSERT INTO `tb_entity` VALUES ("评价函数","应用领域","启发式搜索");
INSERT INTO `tb_entity` VALUES ("评价函数","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("智能科学与生物信息学","描述","智能科学研究智能的本质和实现技术, 是由脑科学、认知科学、人工智能等学科共同研究的交叉学科。");
INSERT INTO `tb_entity` VALUES ("计算机博弈","描述","计算机博弈（也称机器博弈），是一个研究领域，是人工智能领域的重要研究方向，是机器智能、兵棋推演、智能决策系统等人工智能领域的重要科研基础。");
INSERT INTO `tb_entity` VALUES ("计算机博弈","中文名","计算机博弈");
INSERT INTO `tb_entity` VALUES ("计算机博弈","又名","机器博弈");
INSERT INTO `tb_entity` VALUES ("计算机博弈","所属领域","计算机研究领域");
INSERT INTO `tb_entity` VALUES ("计算机博弈","性质","人工智能领域研究方向");
INSERT INTO `tb_entity` VALUES ("国际人工智能联合会议","描述","国际人工智能联合会议（International Joint Conference on Artificial Intelligence, 简称为IJCAI）是人工智能领域中最主要的学术会议之一，在单数年召开。");
INSERT INTO `tb_entity` VALUES ("国际人工智能联合会议","中文名","国际人工智能联合会议");
INSERT INTO `tb_entity` VALUES ("国际人工智能联合会议","外文名","International Joint Conference on Artificial Intelligence");
INSERT INTO `tb_entity` VALUES ("国际人工智能联合会议","性质","人工智能领域");
INSERT INTO `tb_entity` VALUES ("国际人工智能联合会议","地点","中国北京");
INSERT INTO `tb_entity` VALUES ("国际人工智能联合会议","标签","组织机构");
INSERT INTO `tb_entity` VALUES ("混淆矩阵","描述","混淆矩阵也称误差矩阵，是表示精度评价的一种标准格式，用n行n列的矩阵形式来表示。");
INSERT INTO `tb_entity` VALUES ("混淆矩阵","中文名","混淆矩阵");
INSERT INTO `tb_entity` VALUES ("混淆矩阵","外文名","Confusion Matrix");
INSERT INTO `tb_entity` VALUES ("混淆矩阵","用于","人工智能");
INSERT INTO `tb_entity` VALUES ("混淆矩阵","性质","可视化工具");
INSERT INTO `tb_entity` VALUES ("混淆矩阵","用于","监督学习");
INSERT INTO `tb_entity` VALUES ("智能式CAPP系统","描述","智能式CAPP，也称CAPP专家系统，它是将人工智能技术应用在CAPP系统中所形成的专家系统。");
INSERT INTO `tb_entity` VALUES ("智能式CAPP系统","中文名","智能式CAPP系统");
INSERT INTO `tb_entity` VALUES ("智能式CAPP系统","也称","CAPP专家系统");
INSERT INTO `tb_entity` VALUES ("智能式CAPP系统","应用技术","人工智能技术");
INSERT INTO `tb_entity` VALUES ("智能式CAPP系统","特征","""推理+知识""");
INSERT INTO `tb_entity` VALUES ("模式识别技术","描述","模式识别技术是人工智能的基础技术，21世纪是智能化、信息化、计算化、网络化的世纪，在这个以数字计算为特征的世纪里，作为人工智能技术基础学科的模式识别技术，必将获得巨大的发展空间。");
INSERT INTO `tb_entity` VALUES ("模式识别技术","中文名","模式识别技术");
INSERT INTO `tb_entity` VALUES ("模式识别技术","时代","20世纪20年代");
INSERT INTO `tb_entity` VALUES ("模式识别技术","形式","启发式搜索");
INSERT INTO `tb_entity` VALUES ("模式识别技术","发展","语音识别技术");
INSERT INTO `tb_entity` VALUES ("自联想神经网络","描述","自联想神经网络(Auto-Associative Neural Network , 缩写为AANN)是1987年Ballard提出的，其网络原型是一种具有对称拓扑结构的五层前馈传递网络，AANN 应用到数据检验问题时具有比较明显的物理意义。");
INSERT INTO `tb_entity` VALUES ("自联想神经网络","中文名","自联想神经网络");
INSERT INTO `tb_entity` VALUES ("自联想神经网络","外文名","Auto-Associative Neural Network");
INSERT INTO `tb_entity` VALUES ("自联想神经网络","提出时间","1987年");
INSERT INTO `tb_entity` VALUES ("自联想神经网络","提出者","Ballard");
INSERT INTO `tb_entity` VALUES ("自联想神经网络","应用","人工智能、深度学习");
INSERT INTO `tb_entity` VALUES ("自联想神经网络","学科","计算机科学");
INSERT INTO `tb_entity` VALUES ("自联想神经网络","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("图像识别技术","描述","图像识别技术是人工智能的一个重要领域。");
INSERT INTO `tb_entity` VALUES ("图像识别技术","中文名","图像识别技术");
INSERT INTO `tb_entity` VALUES ("图像识别技术","外文名","Image Recognition Technology");
INSERT INTO `tb_entity` VALUES ("图像识别技术","技术范围","人脸识别，指纹识别，图像匹配等");
INSERT INTO `tb_entity` VALUES ("图像识别技术","类型","计算机科学");
INSERT INTO `tb_entity` VALUES ("图像识别技术","学科","跨学科");
INSERT INTO `tb_entity` VALUES ("图像识别技术","性质","识别");
INSERT INTO `tb_entity` VALUES ("图像识别技术","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("图像识别技术","标签","科学");
INSERT INTO `tb_entity` VALUES ("人工智能语义分析","描述","人工智能语义分析是针对网页文字进行概括分析的一种技术。");
INSERT INTO `tb_entity` VALUES ("分布式问题求解","描述","分布式问题求解是分布式人工智能的一个研究分支。");
INSERT INTO `tb_entity` VALUES ("分布式问题求解","中文名","分布式问题求解");
INSERT INTO `tb_entity` VALUES ("分布式问题求解","协作方式","任务分担、结果共享");
INSERT INTO `tb_entity` VALUES ("分布式问题求解","组织结构","层次、平行、混合三种类型");
INSERT INTO `tb_entity` VALUES ("分布式问题求解","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("分布式问题求解","标签","书籍");
INSERT INTO `tb_entity` VALUES ("归纳逻辑程序设计","描述","归纳逻辑程序设计(Inductive Logic Programming，ILP)是基于一阶逻辑的归纳方法，采用的是反向归结(Inverse Resolution)过程。");
INSERT INTO `tb_entity` VALUES ("归纳逻辑程序设计","中文名","归纳逻辑程序设计");
INSERT INTO `tb_entity` VALUES ("归纳逻辑程序设计","外文名","Inductive Logic Programming");
INSERT INTO `tb_entity` VALUES ("归纳逻辑程序设计","简称","ILP");
INSERT INTO `tb_entity` VALUES ("归纳逻辑程序设计","起源时间","20世纪70年代");
INSERT INTO `tb_entity` VALUES ("归纳逻辑程序设计","应用","生物信息学、工程学、环境监控");
INSERT INTO `tb_entity` VALUES ("归纳逻辑程序设计","涉及领域","人工智能、机器学习");
INSERT INTO `tb_entity` VALUES ("归纳逻辑程序设计","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("进化计算","描述","在计算机科学领域，进化计算（Evolutionary Computation）是人工智能（Artificial Intelligence），进一步说是智能计算（Computational Intelligence）中涉及到组合优化问题的一个子域。");
INSERT INTO `tb_entity` VALUES ("进化计算","中文名","进化计算");
INSERT INTO `tb_entity` VALUES ("进化计算","外文名","Evolutionary Computation");
INSERT INTO `tb_entity` VALUES ("进化计算","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("进化计算","标签","历史");
INSERT INTO `tb_entity` VALUES ("aiml","描述","AIML，全名为Artificial Intelligence Markup Language（人工智能标记语言），是一种创建自然语言软件代理的XML语言，是由Richard Wallace和世界各地的自由软件社区在1995年至2002年发明的。");
INSERT INTO `tb_entity` VALUES ("aiml","中文名","人工智能标记语言");
INSERT INTO `tb_entity` VALUES ("aiml","外文名","Artificial Intelligence Markup Language");
INSERT INTO `tb_entity` VALUES ("aiml","简称","aiml");
INSERT INTO `tb_entity` VALUES ("aiml","发明时间","1995-2002");
INSERT INTO `tb_entity` VALUES ("智能拓词","描述","智能拓词是进行竞价推广时关键词拓展的一种协助工具，通过人工智能取代人脑智能拓展关键词，能够帮助竞价人员更加方便、系统地拓展更多的关键词，提高关键词覆盖率，从而提升企业品牌曝光率，增加企业业务。");
INSERT INTO `tb_entity` VALUES ("智能拓词","中文名","智能拓词");
INSERT INTO `tb_entity` VALUES ("智能拓词","功能","竞价推广");
INSERT INTO `tb_entity` VALUES ("智能拓词","属性","协助工具");
INSERT INTO `tb_entity` VALUES ("智能拓词","对应","人工智能取代人脑智能");
INSERT INTO `tb_entity` VALUES ("智能拓词","标签","语言");
INSERT INTO `tb_entity` VALUES ("智能拓词","标签","文化");
INSERT INTO `tb_entity` VALUES ("智能驾驶","描述","智能驾驶本质上涉及注意力吸引和注意力分散的认知工程学，主要包括网络导航、自主驾驶和人工干预三个环节。");
INSERT INTO `tb_entity` VALUES ("智能驾驶","中文名","智能驾驶");
INSERT INTO `tb_entity` VALUES ("智能驾驶","外文名","Intelligent Drive");
INSERT INTO `tb_entity` VALUES ("智能驾驶","领域","人工智能");
INSERT INTO `tb_entity` VALUES ("智能驾驶","作用","提升生产效率和交通效率");
INSERT INTO `tb_entity` VALUES ("智能驾驶","本质","注意力吸引和分散的认知工程学");
INSERT INTO `tb_entity` VALUES ("智能驾驶","意义","工业革命和信息化结合重要抓手");
INSERT INTO `tb_entity` VALUES ("智能驾驶","概念一","机器帮助人进行驾驶");
INSERT INTO `tb_entity` VALUES ("智能驾驶","概念二","特殊情况下完全取代人驾驶");
INSERT INTO `tb_entity` VALUES ("智能驾驶","标签","科学百科工程技术分类");
INSERT INTO `tb_entity` VALUES ("智能驾驶","标签","科学");
INSERT INTO `tb_entity` VALUES ("概率分配函数","描述","概率分配函数是人工智能理论中非经典推理部分,证据理论中用到的一个函数。");
INSERT INTO `tb_entity` VALUES ("信任函数","描述","信任函数是人工智能理论中非经典推理部分,证据理论中用到的一个函数....");
INSERT INTO `tb_entity` VALUES ("信任函数","标签","科学");
INSERT INTO `tb_entity` VALUES ("人物识别","描述","人物识别是也可以叫区分人类之间的不同 ，这个不同有表面和内在，根本不同之处在于DNA的区分，从而有了千姿百态的世界，有了各种面貌和表情。");
INSERT INTO `tb_entity` VALUES ("人物识别","中文名","人物识别");
INSERT INTO `tb_entity` VALUES ("人物识别","又名","人脸识别,人像识别");
INSERT INTO `tb_entity` VALUES ("人物识别","简介","运用人工智能领域内先进的生物");
INSERT INTO `tb_entity` VALUES ("人物识别","主要优势","自然性");
INSERT INTO `tb_entity` VALUES ("声明式编程","描述","声明式编程（英语：Declarative programming）是一种编程范型，与命令式编程相对立。");
INSERT INTO `tb_entity` VALUES ("声明式编程","中文名","声明式编程");
INSERT INTO `tb_entity` VALUES ("声明式编程","外文名","Declarative programming");
INSERT INTO `tb_entity` VALUES ("声明式编程","类别","编程形式");
INSERT INTO `tb_entity` VALUES ("声明式编程","作用","解决人工智能和约束满足问题");
INSERT INTO `tb_entity` VALUES ("图形识别","描述","在当今所处的这个信息爆炸的时代，计算机图形识别已经成为计算机视觉技术的一个重要研究分支，同时也是图像检索的重要基础。");
INSERT INTO `tb_entity` VALUES ("图形识别","中文名","图形识别");
INSERT INTO `tb_entity` VALUES ("图形识别","外文名","patternrecognition");
INSERT INTO `tb_entity` VALUES ("图形识别","领域","计算机视觉");
INSERT INTO `tb_entity` VALUES ("图形识别","学科","计算机科学与技术");
INSERT INTO `tb_entity` VALUES ("图形识别","主要内容","识别物体及图形形状");
INSERT INTO `tb_entity` VALUES ("图形识别","应用","人工智能");
INSERT INTO `tb_entity` VALUES ("图形识别","标签","科学百科信息科学分类");
INSERT INTO `tb_entity` VALUES ("公式推演","描述","公式推演是计算机自动推演数学公式的技术，是人工智能的一个应用领域，又称计算机代数。");
INSERT INTO `tb_entity` VALUES ("公式推演","中文名","公式推演");
INSERT INTO `tb_entity` VALUES ("公式推演","含义","计算机自动推演数学公式的技术");
INSERT INTO `tb_entity` VALUES ("公式推演","属性","人工智能的一个应用");
INSERT INTO `tb_entity` VALUES ("公式推演","别名","计算机代数");
INSERT INTO `tb_entity` VALUES ("NLP神经语言程式","描述","NLP神经语言程式（Neuro Linguistic Programming）是人工智能的一个领域，是指从破解成功人士的语言及思维模式入手，独创性地将他们的思维模式进行解码后，发现了人类思想、情绪和行为背后的规律，并将其归结为一套可复制可模仿的程式。");
INSERT INTO `tb_entity` VALUES ("NLP神经语言程式","中文名","NLP神经语言程式");
INSERT INTO `tb_entity` VALUES ("NLP神经语言程式","应用学科","心理学");
INSERT INTO `tb_entity` VALUES ("NLP神经语言程式","标签","中国心理学会");
INSERT INTO `tb_entity` VALUES ("TensorFlow","描述","TensorFlow是谷歌基于DistBelief进行研发的第二代人工智能学习系统，其命名来源于本身的运行原理。");
INSERT INTO `tb_entity` VALUES ("TensorFlow","外文名","TensorFlow");
INSERT INTO `tb_entity` VALUES ("TensorFlow","研发","谷歌");
INSERT INTO `tb_entity` VALUES ("TensorFlow","研发基础","DistBelie");
INSERT INTO `tb_entity` VALUES ("TensorFlow","属性","第二代人工智能学习系统");
INSERT INTO `tb_entity` VALUES ("TensorFlow","标签","电影");
INSERT INTO `tb_entity` VALUES ("AI计划","描述","AI计划，指人工智能计划，人工智能和虚拟现实一样，显然已经成为科技行业下一个风口。");
INSERT INTO `tb_entity` VALUES ("AI计划","标签","科学");
INSERT INTO `tb_entity` VALUES ("博弈树启发式搜索","描述","启发式搜索策略即为结点排序技术。");
INSERT INTO `tb_entity` VALUES ("博弈树启发式搜索","中文名","博弈树启发式搜索");
INSERT INTO `tb_entity` VALUES ("博弈树启发式搜索","应用学科","计算机");
INSERT INTO `tb_entity` VALUES ("博弈树启发式搜索","适用领域范围","计算机博弈");
INSERT INTO `tb_entity` VALUES ("博弈树启发式搜索","适用领域范围","人工智能");
INSERT INTO `tb_entity` VALUES ("博弈树启发式搜索","标签","科学");
INSERT INTO `tb_entity` VALUES ("AI+","描述","AI+人工智能+（Artificial Intelligence Plus）英文缩写为AI+。");
INSERT INTO `tb_entity` VALUES ("AI+","中文名","人工智能+");
INSERT INTO `tb_entity` VALUES ("AI+","外文名","Artificial Intelligence Plus");
INSERT INTO `tb_entity` VALUES ("AI+","本质","人工智能与传统行业相结合");
INSERT INTO `tb_entity` VALUES ("AI+","简称","AI+ 或 AI Plus");
INSERT INTO `tb_entity` VALUES ("AI+","标签","科学");
INSERT INTO `tb_entity` VALUES ("OpenAI","描述","OpenAI，由诸多硅谷大亨联合建立的人工智能非营利组织。");
INSERT INTO `tb_entity` VALUES ("OpenAI","外文名","OpenAI");
INSERT INTO `tb_entity` VALUES ("OpenAI","性质","人工智能非营利组织");
INSERT INTO `tb_entity` VALUES ("OpenAI","目标","预防人工智能的灾难性影响");
INSERT INTO `tb_entity` VALUES ("OpenAI","年份","2015年");
INSERT INTO `tb_entity` VALUES ("OpenAI","标签","科学");
