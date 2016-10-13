<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en" class="app topadminhome">
<head>  
  <meta charset="utf-8" />
  <title>本然数据库</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" /> 
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/icon.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" /> 
  <link rel="stylesheet" href="js/calendar/bootstrap_calendar.css" type="text/css" />
  <link rel="stylesheet" href="js/utilcarousel/util.carousel.css">
  <link rel="stylesheet" href="js/utilcarousel/util.animate.css" />
  <!--[if lt IE 9]>
    <script src="js/ie/html5shiv.js"></script>
    <script src="js/ie/respond.min.js"></script>
    <script src="js/ie/excanvas.js"></script>
  <![endif]-->  
</head>
<body class="" >
  <section class="vbox">
    <header class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow">
      <div class="navbar-header aside-md dk">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
          <i class="fa fa-bars"></i>
        </a>
        <a href="index.html" class="navbar-brand">
          <img src="images/logo.jpg" class="m-r-sm" alt="scale">
          <span class="hidden-nav-xs">本然数据库</span>
        </a>
        <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user">
          <i class="fa fa-cog"></i>
        </a>
      </div>
      
      <form class="navbar-form navbar-left input-s-lg m-t m-l-n-xs hidden-xs" role="search">
        <div class="form-group">
          <div class="input-group">
            <span class="input-group-btn">
              <button type="submit" class="btn btn-sm bg-white b-white btn-icon"><i class="fa fa-search"></i></button>
            </span>
            <input type="text" class="form-control input-sm no-border" placeholder="请搜索...">            
          </div>
        </div>
      </form>
      <ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user user">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <span class="thumb-sm avatar pull-left">
              <img src="images/a0.png" alt="...">
            </span>
            张小帅 <b class="caret"></b>
          </a>
          <ul class="dropdown-menu animated fadeInRight">            
            <li>
              <span class="arrow top"></span>
              <a href="#">个人资料设置</a>
            </li>
            <li class="divider"></li>
            <li>
              <a href="modal.lockme.html" data-toggle="ajaxModal" >登出</a>
            </li>
          </ul>
        </li>
      </ul>      
    </header>
    <section>
      <section class="hbox stretch">
        <!-- .aside -->
        <aside class="bg-black aside-md hidden-print hidden-xs nav-xs" id="nav">          
          <section class="vbox">
            <section class="w-f scrollable">
              <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railOpacity="0.2">
                <div class="clearfix wrapper dk nav-user hidden-xs">
                  <div class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                      <span class="thumb avatar pull-left m-r">                        
                        <img src="images/a0.png" class="dker" alt="...">
                        <i class="on md b-black"></i>
                      </span>
                      <span class="hidden-nav-xs clear">
                        <span class="block m-t-xs">
                          <strong class="font-bold text-lt">张小帅</strong> 
                          <b class="caret"></b>
                        </span>
                        <span class="text-muted text-xs block">高级研究员</span>
                      </span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight m-t-xs">                      
                      <li>
                        <span class="arrow top hidden-nav-xs"></span>
                        <a href="#">个人资料设置</a>
                      </li>
                      <li class="divider"></li>
                      <li>
                        <a href="modal.lockme.html" data-toggle="ajaxModal" >登出</a>
                      </li>
                    </ul>
                  </div>
                </div>                


                <!-- nav -->                 
                <nav class="nav-primary hidden-xs">
                  <div class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">主菜单</div>
                  <ul class="nav nav-main" data-ride="collapse">
                    <li class="active">
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="i i-circle-sm-o text"></i>
                          <i class="i i-circle-sm text-active"></i>
                        </span>
                        <i class="i i-stack icon">
                        </i>
                        <span class="font-bold">我的项目</span>
                      </a>
                      <ul class="nav dk">
                        <li >
                          <a href="allmember.html" class="auto"> <i class="i i-dot"></i>

                            <span>查看全部成员</span>
                          </a>
                        </li>
                        <li >
                          <a href="favorite.html" class="auto"> <i class="i i-dot"></i>

                            <span>收藏夹</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                    <li>
                      <a href="#" class="auto">
                        <i class="i i-docs icon">
                        </i>
                        <span class="font-bold">全部项目</span>
                      </a>
                    </li>
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="i i-circle-sm-o text"></i>
                          <i class="i i-circle-sm text-active"></i>
                        </span>
                        <i class="i i-lab icon">
                        </i>
                        <span class="font-bold">系统管理</span>
                      </a>
                      <ul class="nav dk">
                        <li >
                          <a href="cataloguemanagement.html" class="auto">                                                        
                            <i class="i i-dot"></i>

                            <span>分类管理</span>
                          </a>
                        </li>
                        <li >
                          <a href="tagmanagement.html" class="auto">                                                                                   
                            <i class="i i-dot"></i>

                            <span>标签管理</span>
                          </a>
                        </li>
                        <li >
                          <a href="usermanagement.html" class="auto">                                                        
                            <i class="i i-dot"></i>

                            <span>用户管理</span>
                          </a>
                        </li>
                    </ul>
                    </li>
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="i i-circle-sm-o text"></i>
                          <i class="i i-circle-sm text-active"></i>
                        </span>
                        <i class="i i-statistics icon">
                        </i>
                        <span class="font-bold">数据分析</span>
                      </a>
                      <ul class="nav dk">
                        <li >
                          <a href="chart.html" class="auto">                                                        
                            <i class="i i-dot"></i>

                            <span>热点走向</span>
                          </a>
                        </li>
                        <li >
                          <a href="chart-compare.html" class="auto">                                                        
                            <i class="i i-dot"></i>

                            <span>数据比较</span>
                          </a>
                        </li>
                        <li >
                          <a href="chart-distribution.html" class="auto">                                                        
                            <i class="i i-dot"></i>

                            <span>热点分布</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                    <li >
                      <a href="userlog.html" class="auto">
                        <i class="i i-grid2 icon">
                        </i>
                        <span class="font-bold">用户登录记录</span>
                      </a>
                      </li>
                  </ul>
                  <div class="line dk hidden-nav-xs"></div>
                 
                  </ul>
                </nav>
                <!-- / nav -->
              </div>
            </section>
            
            <footer class="footer hidden-xs no-padder text-center-nav-xs">
              <a href="modal.lockme.html" data-toggle="ajaxModal" class="btn btn-icon icon-muted btn-inactive pull-right m-l-xs m-r-xs hidden-nav-xs">
                <i class="i i-logout"></i>
              </a>
              <a href="#nav" data-toggle="class:nav-xs" class="btn btn-icon icon-muted btn-inactive m-l-xs m-r-xs">
                <i class="i i-circleleft text"></i>
                <i class="i i-circleright text-active"></i>
              </a>
            </footer>
          </section>
        </aside>
        <!-- /.aside -->
        <section id="content">
          <section class="hbox stretch">
            <section>
              <section class="vbox">
                <section class="scrollable padder">              
                  <section class="m-b-md m-t-md col-md-12">
                  <div class="row">
                  <div id="post-carousel" class="util-carousel">
                        <div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t1.jpg" src="images/p0.jpg" alt="" /></a>
                    <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
				    </div>
						</div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t2.jpg" src="images/p0.jpg" alt="" /></a>           
                    <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t3.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t4.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t5.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
                        <div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t6.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t7.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t8.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
                        <div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t1.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t2.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t3.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t4.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t5.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
                        <div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t6.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t7.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
						</div>
                        </div>
						<div class="item">
							<a href="#"><img class="img-lazy" data-src="images/t8.jpg" src="images/p0.jpg" alt="" /></a>
                             <div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#" >文章标题</a>
					</div>
					</div>
                    </div>
                  </div>
                    </div>
                  </section>
                  <section class="col-md-6 row">
                          <section class="vbox">
                          <div class="wrapper dk p-b-none clearfix ">
                                          <a href="#" data-toggle="class" class="pull-left m-r-sm"><i class="fa fa-star-o fa-lg text"></i><i class="fa fa-star text-warning fa-lg text-active"></i></a>
                                          <h4 class="m-n"> 品牌形象下的智能手机造型设计研究与探讨<span class="badge bg-warning m-l-xs">未读</span></h4>
                                        </div>
                                        <div>
                                          <div class="block clearfix wrapper b-b">
                                            <a href="#" class="thumb-xs inline"><img src="images/a0.png" class="img-circle "></a> 
                                            <span class="inline m-l-xs"> 王小帅</span>
                                            <em class="text-xs m-l-sm">发表于 <span class="text-danger">2014年10月11日</span></em>
                                          </div>
                                          <div class="post-container wrapper b-b">
                                            <p class="text-lt">产品造型设计为实现企业形象统一识别目标的具体表现。以产品设计为核心展开的系统形象设计，塑造和传播企业形象，创造个性品牌，赢利于激烈的市场竞争中。 例如苹果公司的产品造型设计堪称精品设计。产品造型设计服务于企业的整体形象设计，以产品设计为核心，围绕着人对产品的需求，更大限度地适合人的个体与社会的需求而获得普遍的认同感，改变人们的生活方式，提高生活质量和水平。因此对产品形象的设计和评价系统的研究具有十分重要的意义，评价系统复杂而变化多样，有许多不确定因素，特别是涉及到人的感官因素等，包括人的生理和心理因素。通过对企业形象的统一识别的研究，并以此为基础，结合人与产品与社会的关系展开讨论，对产品形象设计及评价系统作有意义的探索。</p>
                                            <blockquote>
                                              <em>产品的造型设计为实现企业的总体形象目标的细化。它是以产品设计为核心而展开的系统形象设计，对产品的设计、开发、研究的观念、原理、功能、结构、构造、技术、材料、造型、色彩、加工工艺、生产设备、包装、装潢、运输、展示、营销手段、广告策略等等进行一系列统一策划、统一设计，形成统一感官形象和统一社会形象，能够起到提升、塑造和传播企业形象的作用，使企业在经营信誉、品牌意识、经营谋略、销售服务、员工素质、企业文化等诸多方面显示企业的个性，强化企业的整体素质，造就品牌效应，赢利于激烈的市场竞争中。</em>
                                            </blockquote>
                                            <div>
                                              <p>工作将决定产品设计的成本和产品设计的效果。所以这一阶段是整个产品设计最为重要的阶段。通过思考形成创意，并加以快速的记录。这一设计初期阶段的想法常表现为一种即时闪现的灵感，缺少精确尺寸信息和几何信息。基于设计人员的构思，通过草图勾画方式记录，绘制各种形态或者标注记录下设计信息，确定三至四个方向，再由设计师进行深入设计。</p>
                                              <p>2D效果图将草图中模糊的设计结果确定化精确化。通过这个环节生成精确的产品外观平面设计图。既可以清晰地向客户展示产品的尺寸和大致的体量感，表达产品的材质和光影关系，是设计草图后的更加直观和完善的表达。</p>
                                              <p>多角度效果图，给人更为直观的方式从多个视觉角度去感受产品的空间体量。全面的评估产品设计，减少设计的不确定性。</p>
                                              <p>产品色彩设计是用来解决客户对产品色彩系列的要求，通过计算机调配出色彩的初步方案，来满足同一产品的不同的色彩需求，扩充客户产品线。</p>
                                              <p>产品表面标志设计将成为面板的亮点，给人带来全新的生活体验。VI在产品上的导入使产品风格更加统一,简洁明晰的LOGO，提供亲切直观的识别感受，同时也成为精致的细节。</p>
                                            </div>
                                            
                                          </div>
                                        </div>
                                        <div class="wrapper">
                                          点此按钮发表新的评论 <a href="#comment-form">发表新评论</a>
                                        </div>
                                    </section>
                          <section class="comment-list block m-b-xl">
                                              <article id="comment-id-1" class="comment-item">
                                                <a class="pull-left thumb-sm avatar">
                                                  <img src="images/a1.png" class="img-circle">
                                                </a>
                                                <span class="arrow left"></span>
                                                <section class="comment-body panel panel-default">
                                                  <header class="panel-heading bg-white">
                                                    <a href="#">王小帅</a>
                                                    <label class="label bg-info m-l-xs">作者</label> 
                                                    <span class="text-muted m-l-sm pull-right">
                                                      <i class="fa fa-clock-o"></i>
                                                      刚才
                                                    </span>
                                                  </header>
                                                  <div class="panel-body">
                                                    <div>这篇文章写得真心地好啊！</div>
                                                    <div class="comment-action m-t-sm">
                                                      <a href="#" data-toggle="class" class="btn btn-default btn-xs active">
                                                        <i class="fa fa-star-o text-muted text"></i>
                                                        <i class="fa fa-star text-danger text-active"></i> 
                                                        喜欢
                                                      </a>
                                                      <a href="#comment-form" class="btn btn-default btn-xs">
                                                        <i class="fa fa-mail-reply text-muted"></i> 回复
                                                      </a>
                                                    </div>
                                                  </div>
                                                </section>
                                              </article>
                                              <!-- .comment-reply -->
                                              <article id="comment-id-2" class="comment-item comment-reply">
                                                <a class="pull-left thumb-sm avatar">
                                                  <img src="images/a8.png">
                                                </a>
                                                <span class="arrow left"></span>
                                                <section class="comment-body panel panel-default text-sm">
                                                  <div class="panel-body">
                                                    <span class="text-muted m-l-sm pull-right">
                                                      <i class="fa fa-clock-o"></i>
                                                      10分钟前
                                                    </span>
                                                    <a href="#">李大毛</a>
                                                    <label class="label bg-dark m-l-xs">高级研究员</label> 
                                                    不错不错！我很满意。                         
                                                  </div>
                                                </section>
                                              </article>
                                              <!-- / .comment-reply --> 
                                              <article id="comment-id-3" class="comment-item">
                                                <a class="pull-left thumb-sm avatar"><img src="images/a5.png"></a>
                                                <span class="arrow left"></span>
                                                <section class="comment-body panel panel-default">
                                                  <header class="panel-heading">
                                                    <a href="#">胡小山</a>
                                                    <label class="label bg-primary m-l-xs">高级用户</label> 
                                                    <span class="text-muted m-l-sm pull-right">
                                                      <i class="fa fa-clock-o"></i>
                                                      1小时前
                                                    </span>
                                                  </header>
                                                  <div class="panel-body">
                                                    <blockquote>
                                                      <p>我认为这篇文章毫无价值！</p>
                                                      <small>张小帅</small>
                                                    </blockquote>
                                                    <div>有道理！</div>
                                                    <div class="comment-action m-t-sm">
                                                      <a href="#" data-toggle="class" class="btn btn-default btn-xs">
                                                        <i class="fa fa-star-o text-muted text"></i>
                                                        <i class="fa fa-star text-danger text-active"></i> 
                                                        喜欢
                                                      </a>
                                                      <a href="#comment-form" class="btn btn-default btn-xs"><i class="fa fa-mail-reply text-muted"></i> 回复</a>
                                                    </div>
                                                  </div>
                                                </section>
                                              </article>
                                              <article id="comment-id-4" class="comment-item">
                                                <a class="pull-left thumb-sm avatar"><img src="images/a9.png"></a>
                                                <span class="arrow left"></span>
                                                <section class="comment-body panel panel-default">
                                                  <header class="panel-heading">                      
                                                    <a href="#">我</a>
                                                    <label class="label bg-success m-l-xs">研究员</label> 
                                                    <span class="text-muted m-l-sm pull-right">
                                                      <i class="fa fa-clock-o"></i>
                                                      2小时前
                                                    </span>
                                                  </header>
                                                  <div class="panel-body">
                                                    <div>我认为这篇文章毫无价值！</div>
                                                    <div class="comment-action m-t-sm">
                                                      <a href="#comment-id-3" data-dismiss="alert" class="btn btn-default btn-xs">
                                                        <i class="fa fa-trash-o text-muted"></i> 
                                                        删除
                                                      </a>
                                                    </div>
                                                  </div>
                                                </section>
                                              </article>
                                              <!-- comment form -->
                                              <article class="comment-item media" id="comment-form">
                                                <a class="pull-left thumb-sm avatar"><img src="images/a6.png"></a>
                                                <section class="media-body">
                                                  <form action="" class="m-b-none">
                                                    <div class="input-group">
                                                      <input type="text" class="form-control" placeholder="在此输入评论">
                                                      <span class="input-group-btn">
                                                        <button class="btn btn-primary" type="button">发表</button>
                                                      </span>
                                                    </div>
                                                  </form>
                                                </section>
                                              </article>
                                            </section>
                  </section>
                  <section class="scrollable col-md-3 siderbar">
                  <ul class="list-group gutter list-group-lg list-group-sp sortable">  
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   标签管理                    
                   </header>
                   <div class="panel-body tagform">
                   <div class="tagtitle" style="margin-top: 0;">新增标签<button href="#" class="btn btn-sm btn-default add-btn">
                   <i class="fa fa-plus text"></i></button></div>
                   <a class="label label-info tag">塑料</a>
                   <a class="label label-info tag">金属</a>
                   <a class="label label-info tag">金属</a>
                   <a class="label label-info tag">金属</a>
                   <a class="label label-info tag">金属</a>
                   <a class="label label-info tag">金属</a>
                   <div class="tagtitle">热门标签<button href="#" class="btn btn-sm btn-default add-btn">
                   <i class="fa fa-plus text"></i></button></div> 
                   <a class="label bg-hot tag">玻璃</a> 
                   <a class="label bg-hot tag">玻璃</a> 
                   <a class="label bg-hot tag">玻璃</a> 
                   <a class="label bg-hot tag">玻璃</a> 
                   <a class="label bg-hot tag">玻璃</a> 
                   <a class="label bg-hot tag">玻璃</a> 
                   <a class="label bg-hot tag">玻璃</a> 
                   
                   </div>
                   </div>
                   </li> 
                                          
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   批注管理                    
                   </header>
                   <div class="text-center p-b-t-l b-b">
                   <button href="#" class="btn btn-sm btn-success">
                   <i class="fa fa-plus text"></i> 添加新批注
                   </button>  
                   </div>                                     
                   <article class="b-b">
                       <div class="panel-body">
                       <span class="pull-left thumb-sm avatar"><img src="images/a1.png" class="img-circle"></span>
                       <div class="media-body">
                       <div class="pull-right media-xs text-center text-muted">
                       <a href="#" class="btn btn-sm btn-default add-btn pull-right">编辑</a>
                       </div>
                       <a href="#" class="h5">张小帅</a>
                       <small class="block">高级研究员</small>
                       </div>
                       <div class="postil m-t-sm t-t">工作将决定产品设计的成本和产品设计的效果。所以这一阶段是整个产品设计最为重要的阶段。通过思考形成创意，并加以快速的记录。这一设计初期阶段的想法常表现为一种即时闪现的灵感，缺少精确尺寸信息和几何信息。基于设计人员的构思，通过草图勾画方式记录，绘制各种形态或者标注记录下设计信息，确定三至四个方向，再由设计师进行深入设计。</div>
                       </div>
                       </article>
                   
                   <article class="b-b disable">
                       <div class="panel-body">
                       <span class="pull-left thumb-sm avatar"><img src="images/a1.png" class="img-circle"></span>
                       <div class="media-body">
                       <a href="#" class="h5">吴小杰</a>
                       <small class="block">高级研究员</small>
                       </div>
                       <div class="postil m-t-sm t-t">工作将决定产品设计的成本和产品设计的效果。所以这一阶段是整个产品设计最为重要的阶段。通过思考形成创意，并加以快速的记录。这一设计初期阶段的想法常表现为一种即时闪现的灵感，缺少精确尺寸信息和几何信息。基于设计人员的构思，通过草图勾画方式记录，绘制各种形态或者标注记录下设计信息，确定三至四个方向，再由设计师进行深入设计。</div>
                       </div>
                       </article>                                        
                   </div>
                   </li>
                   
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   热门标签                    
                   </header>
                   <div class="text-center p-b-t-l b-b">
                   <button href="#" class="btn btn-sm btn-success">
                   <i class="fa fa-plus text"></i> 添加热门标签
                   </button>  
                   </div>                                     
                   <article class="b-b">
                       <div class="panel-body">
                       
                       <div class="media-body">
                       <div class="pull-right media-xs text-center text-muted">
                       <a href="#" class="btn btn-sm btn-default add-btn pull-right">编辑</a>
                       </div>
                       <div class="block writetime">标注时间：2014年10月20日</div>
                       </div>
                       <div class="postil m-t-sm t-t">工作将决定产品设计的成本和产品设计的效果。所以这一阶段是整个产品设计最为重要的阶段。通过思考形成创意，并加以快速的记录。这一设计初期阶段的想法常表现为一种即时闪现的灵感，缺少精确尺寸信息和几何信息。基于设计人员的构思，通过草图勾画方式记录，绘制各种形态或者标注记录下设计信息，确定三至四个方向，再由设计师进行深入设计。</div>
                       </div>
                       </article>
                                    
                   </div>
                   </li>
                   
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   趋势标签                    
                   </header>
                   <div class="text-center p-b-t-l b-b">
                   <button href="#" class="btn btn-sm btn-success">
                   <i class="fa fa-plus text"></i> 添加趋势标签
                   </button>  
                   </div>                                     
                   <article class="b-b">
                       <div class="panel-body">
                       
                       <div class="media-body">
                       <div class="pull-right media-xs text-center text-muted">
                       <a href="#" class="btn btn-sm btn-default add-btn pull-right">编辑</a>
                       </div>
                       <div class="block writetime">标注时间：2014年10月20日</div>
                       </div>
                       <div class="postil m-t-sm t-t">工作将决定产品设计的成本和产品设计的效果。所以这一阶段是整个产品设计最为重要的阶段。通过思考形成创意，并加以快速的记录。这一设计初期阶段的想法常表现为一种即时闪现的灵感，缺少精确尺寸信息和几何信息。基于设计人员的构思，通过草图勾画方式记录，绘制各种形态或者标注记录下设计信息，确定三至四个方向，再由设计师进行深入设计。</div>
                       </div>
                       </article>
                                    
                   </div>
                   </li>
                   
                   </ul>    
                   </section> 
                   
                   <section class="scrollable col-md-3 siderbar">
                   <ul class="list-group gutter list-group-lg list-group-sp sortable">  
                   <li class="list-group-item col-md-12 sortable p-t-none savepanel" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   保存                    
                   </header>
                   <div class="panel-body">
                   <a href="#" class="btn btn-default jumpbtn">跳过本文</a>
                   <a href="#" class="btn btn-success">保存</a>
                   <a href="#" class="btn btn-success">导出</a>
                   </div></div>
                   </li> 
                   
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   文章分类                    
                   </header>
                   <div class="panel-body">
                        <a href="#" class="btn btn-sm btn-default add-btn pull-right">编辑</a>
                        <div class="include">消费电子</div>
                        <div class="part-clear"></div>
                        <span class="pull-left m-r"><img src="images/includeine.png"></span><div class="include seclevel">智能家居</div>
                   </div>
                   </div>
                   </li> 
                   
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   收藏夹                    
                   </header>
                   <div class="panel-body">
                   <div class="text-center p-b-t-l">
                   <button href="#modal-add-to-fav" class="btn btn-sm btn-success text-lg" data-toggle="modal">
                   <i class="fa fa-plus text"></i> 添加到我的收藏夹
                   </button>  
                   </div>
                   </div>
                   
                   <div class="panel-body hidden">
                   <a href="#" class="btn btn-sm btn-default add-btn pull-right">编辑</a>
                   <div class="include">本文已收藏至：</div>
                   <div class="part-clear"></div>
                   <a href="#" class="text-success p-b-t-md fav-list m-t-sm">2014-OPPO信息情报-第9期</a>
                   </div>
                   
                   </div>
                   </li> 
                                   
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   关联文章                    
                   </header>
                   <article class="b-b">
                   <div class="panel-body">
                   <span class="pull-left thumb m-r"><img src="images/placeholder-thumb.png"></span>
                   <div class="media-body">
                   <a href="#" class="h5">工业设计的未来<i class="fa fa-star text-success p-l-sm"></i></a>
                   <small class="block">工业设计的未来简短的文章描述...</small>
                   </div>
                   </div>
                   </article>
                   <article class="b-b">
                   <div class="panel-body">
                   <span class="pull-left thumb m-r"><img src="images/placeholder-thumb.png"></span>
                   <div class="media-body">
                   <a href="#" class="h5">工业设计的未来</a>
                   <small class="block">工业设计的未来简短的文章描述...</small>
                   </div>
                   </div>
                   </article>
                   <article class="b-b">
                   <div class="panel-body">
                   <span class="pull-left thumb m-r"><img src="images/placeholder-thumb.png"></span>
                   <div class="media-body">
                   <a href="#" class="h5">工业设计的未来</a>
                   <small class="block">工业设计的未来简短的文章描述...</small>
                   </div>
                   </div>
                   </article>
                   </div>
                   </li>
                   </ul>    
                   </section> 
                                                     
                </section>
              </section>
            </section>
            

          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
      </section>
    </section>
  </section>
  <script src="js/jquery.min.js" charset="UTF-8"></script>
  <!-- Bootstrap -->
  <script src="js/bootstrap.js" charset="UTF-8"></script>
  <!-- App -->
  <script src="js/app.js"></script>  
  <script src="js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="js/charts/sparkline/jquery.sparkline.min.js"></script>

  <script src="js/calendar/bootstrap_calendar.js"></script>
  <script src="js/calendar/demo.js"></script>

  <script src="js/sortable/jquery.sortable.js"></script>
  <script src="js/app.plugin.js"></script>
  <script src="js/utilcarousel/jquery.utilcarousel.min.js"></script>
  <div class="modal fade" id="modal-add-to-fav" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">添加到收藏夹</h3>
          <small>您可以在此选择此篇文章要添加到哪个收藏夹。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
              <form class="form-horizontal" method="get">
                                     <div class="form-group">
                                     <div class="m-b-xs prename">
                                     <span class="selectname longname">分析范围选择</span>
                                     <div class="btn-group m-r">
                                     <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                                     <span class="dropdown-label">请选择收藏夹</span> 
                                     <span class="caret"></span>
                                     </button>
                                     <ul class="dropdown-menu dropdown-select">
                                     <li class="active"><a href="#"><input type="radio" name="d-s-r" checked="">请选择收藏夹</a></li>
                                     <li class=""><a href="#"><input type="radio" name="d-s-r">收藏夹01</a></li>
                                     <li class=""><a href="#"><input type="radio" name="d-s-r">收藏夹02</a></li>
                                     <li class=""><a href="#"><input type="radio" name="d-s-r">收藏夹03</a></li>
                                     </ul>
                                     </div>
                                     
                                     <div class="btn-group m-r">
                                     <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                                     <span class="dropdown-label">oppo信息情报-第1期</span> 
                                     <span class="caret"></span>
                                     </button>
                                     <ul class="dropdown-menu dropdown-select">
                                     <li class="active"><a href="#"><input type="radio" name="d-s-r" checked="">oppo信息情报-第1期</a></li>
                                     <li class=""><a href="#"><input type="radio" name="d-s-r">oppo信息情报-第2期</a></li>
                                     <li class=""><a href="#"><input type="radio" name="d-s-r">oppo信息情报-第3期</a></li>
                                     <li class=""><a href="#"><input type="radio" name="d-s-r">oppo信息情报-第4期</a></li>
                                     </ul>
                                     </div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    
                                                <div class="checkbox m-t-lg">
                                                
                                                <button type="submit" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="重置中..."><strong>重置</strong></button>
                                                
                                                <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="确定中..."><strong>确定</strong></button>
                                                   
                                                </div>
                                              </form>
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
  <script type="text/javascript">
  $(document).ready(function(){
    $('#post-carousel').utilCarousel({
        responsiveMode : 'itemWidthRange',
		itemWidthRange : [100, 130],
		itemAnimation:'util-flip-in-y',
		navigationText : ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
		navigation : true,
		rewind : false,
		lazyLoad: true
    });
}); 
</script>
</body>
</html>