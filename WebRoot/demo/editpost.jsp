<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en" class="app topadmineditpost">
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
  <link rel="stylesheet" href="js/datepicker/bootstrap-datetimepicker.min.css" type="text/css"> 
  <link rel="stylesheet" href="js/calendar/bootstrap_calendar.css" type="text/css" />
  <link rel="stylesheet" href="js/chosen/chosen.css" type="text/css" />
  <link rel="stylesheet" href="js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
  <link rel="stylesheet" href="js/typehead/typehead.css" type="text/css" />
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
        <aside class="bg-black aside-md hidden-print hidden-xs" id="nav">          
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
                  <section class="row m-b-md col-md-9">
                  <div class="row">
                    <div class="col-sm-6">
                      <h3 class="m-b-xs text-black">编辑文章</h3>
                      <small>您可以在此撰写或编辑文章。</small>
                    </div>
                    </div>
                  </section>
                  <section class="col-md-9 row">
                  
                  <section class="panel panel-default">
                  <header class="panel-heading">编辑选项</header>
                  <div class="panel-body">
                  
                  <div class="row wrapper selectrow">
                   <div class="m-b-xs prename">
                   <span class="selectname midname">编辑日期</span>
                   <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                   	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                   
                   </div>
                   </div>
                   
                  <div class="row wrapper selectrow">
                  <div class="m-b-xs prename">
                  <span class="selectname midname">类别</span>
                  
                  <div class="btn-group m-r">
                  <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                  <span class="dropdown-label">小家电</span> 
                  <span class="caret"></span>
                  </button>
                  <ul class="dropdown-menu dropdown-select">
                  <li class="active"><a href="#"><input type="radio" name="d-s-r" checked="">小家电</a></li>
                  <li class=""><a href="#"><input type="radio" name="d-s-r">大家电</a></li>
                  <li class=""><a href="#"><input type="radio" name="d-s-r">日用品</a></li>
                  <li class=""><a href="#"><input type="radio" name="d-s-r">网络产品</a></li>
                  </ul>
                  </div>
                 
                  <div class="btn-group m-r">
                  <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                  <span class="dropdown-label">手机</span> 
                  <span class="caret"></span>
                  </button>
                  <ul class="dropdown-menu dropdown-select">
                  <li class="active"><a href="#"><input type="radio" name="d-s-r" checked="">手机</a></li>
                  <li class=""><a href="#"><input type="radio" name="d-s-r">Mifi</a></li>
                  <li class=""><a href="#"><input type="radio" name="d-s-r">路由器</a></li>
                  <li class=""><a href="#"><input type="radio" name="d-s-r">电子书</a></li>
                  </ul>
                  </div>
                  </div>
                  </div>
                  
                  <div class="row wrapper selectrow" style="padding-bottom: 10px;">
                  <div class="m-b-xs prename">
                  <span class="selectname midname">标题</span>
                                    
                  <div class="btn-group m-r titleinput">
                  <input type="text" class="form-control">
                  </div>
                                    
                  </div>
                  </div>              


                  </div>
                  </section>
                  <section class="panel panel-default list-show">
                  <header class="panel-heading">
                  编辑文章
                  </header>

                                  <div class="panel-body">
                                  <a href="#modal-form" class="btn btn-success" data-toggle="upload-img"><i class="fa fa-picture-o"></i> 上传图片</a>
                                    <div class="btn-toolbar m-b-sm m-t-sm btn-editor" data-role="editor-toolbar" data-target="#editor">
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="Font"><i class="fa fa-font"></i><b class="caret"></b></a>
                                          <ul class="dropdown-menu">
                                          </ul>
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="字体大小"><i class="fa fa-text-height"></i>&nbsp;<b class="caret"></b></a>
                                          <ul class="dropdown-menu">
                                          <li><a data-edit="fontSize 5"><font size="5">巨大</font></a></li>
                                          <li><a data-edit="fontSize 3"><font size="3">正常</font></a></li>
                                          <li><a data-edit="fontSize 1"><font size="1">小</font></a></li>
                                          </ul>
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm" data-edit="bold" title="加粗 (Ctrl/Cmd+B)"><i class="fa fa-bold"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="italic" title="斜体 (Ctrl/Cmd+I)"><i class="fa fa-italic"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="strikethrough" title="中划线"><i class="fa fa-strikethrough"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="underline" title="Underline (Ctrl/Cmd+U)"><i class="fa fa-underline"></i></a>
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm" data-edit="insertunorderedlist" title="点列"><i class="fa fa-list-ul"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="insertorderedlist" title="数字列"><i class="fa fa-list-ol"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="outdent" title="减少缩进 (Shift+Tab)"><i class="fa fa-dedent"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="indent" title="缩进 (Tab)"><i class="fa fa-indent"></i></a>
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm" data-edit="justifyleft" title="左对齐 (Ctrl/Cmd+L)"><i class="fa fa-align-left"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="justifycenter" title="居中 (Ctrl/Cmd+E)"><i class="fa fa-align-center"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="justifyright" title="右对齐 (Ctrl/Cmd+R)"><i class="fa fa-align-right"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="justifyfull" title="左右对齐 (Ctrl/Cmd+J)"><i class="fa fa-align-justify"></i></a>
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="超链接"><i class="fa fa-link"></i></a>
                                        <div class="dropdown-menu">
                                          <div class="input-group m-l-xs m-r-xs">
                                            <input class="form-control input-sm" placeholder="URL" type="text" data-edit="createLink"/>
                                            <div class="input-group-btn">
                                              <button class="btn btn-default btn-sm" type="button">添加</button>
                                            </div>
                                          </div>
                                        </div>
                                        <a class="btn btn-default btn-sm" data-edit="unlink" title="移除超链接"><i class="fa fa-cut"></i></a>
                                      </div>
                                      
                                      <div class="btn-group hide">
                                        <a class="btn btn-default btn-sm" title="插入图片 (或拖拽)" id="pictureBtn"><i class="fa fa-picture-o"></i></a>
                                        <input type="file" data-role="magic-overlay" data-target="#pictureBtn" data-edit="insertImage" />
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm" data-edit="undo" title="撤销 (Ctrl/Cmd+Z)"><i class="fa fa-undo"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="redo" title="重做 (Ctrl/Cmd+Y)"><i class="fa fa-repeat"></i></a>
                                      </div>
                                    </div>
                                    <div id="editor" class="form-control" style="overflow:scroll;height:100%;min-height:400px;;">
                                      
                                    </div>
                                  </div>
                                  
                     </section>
                  </section>
                     
                   <section class="scrollable col-md-3 siderbar">
                   <ul class="list-group gutter list-group-lg list-group-sp sortable m-b-none">
                   
                   <li class="list-group-item col-md-12 sortable p-t-none savepanel" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   发布                    
                   </header>
                   <div class="panel-body">
                   <a href="#" class="btn btn-success">预览</a>
                   <a href="#" class="btn btn-success">发布</a>
                   </div></div>
                   </li> 
                     
                    <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                    <div class="panel panel-default portlet-item m-b-none">
                    <header class="panel-heading">
                    <ul class="nav nav-pills pull-right">
                    <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                    </ul>
                    标签管理                    
                    </header>
                    <div class="panel-body tagform">
                    <div class="tagtitle" style="margin-top: 0;">新增标签<button href="#modal-add-tag" data-toggle="modal" class="btn btn-sm btn-default add-btn">
                    <i class="fa fa-plus text"></i></button></div>
                    <a class="label label-info tag">塑料<button type="button" class="close" data-dismiss="alert">×</button></a>
                    <a class="label label-info tag">金属<button type="button" class="close" data-dismiss="alert">×</button></a>
                    <a class="label label-info tag">金属<button type="button" class="close" data-dismiss="alert">×</button></a>
                    <a class="label label-info tag">金属<button type="button" class="close" data-dismiss="alert">×</button></a>
                    <a class="label label-info tag">金属<button type="button" class="close" data-dismiss="alert">×</button></a>
                    <a class="label label-info tag">金属<button type="button" class="close" data-dismiss="alert">×</button></a>
                    <div class="tagtitle">热门标签<button href="#modal-add-hot-tag" data-toggle="modal" class="btn btn-sm btn-default add-btn">
                    <i class="fa fa-plus text"></i></button></div> 
                    <a class="label bg-hot tag">玻璃<button type="button" class="close" data-dismiss="alert">×</button></a> 
                    <a class="label bg-hot tag">玻璃<button type="button" class="close" data-dismiss="alert">×</button></a> 
                    <a class="label bg-hot tag">玻璃<button type="button" class="close" data-dismiss="alert">×</button></a> 
                    <a class="label bg-hot tag">玻璃<button type="button" class="close" data-dismiss="alert">×</button></a> 
                    <a class="label bg-hot tag">玻璃<button type="button" class="close" data-dismiss="alert">×</button></a> 
                    <a class="label bg-hot tag">玻璃<button type="button" class="close" data-dismiss="alert">×</button></a> 
                    <a class="label bg-hot tag">玻璃<button type="button" class="close" data-dismiss="alert">×</button></a> 
                    
                    </div>
                    </div>
                    </li> 
                                    

                                           
                    <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                    <div class="panel panel-default portlet-item m-b-none title-pic">
                    <header class="panel-heading">
                    <ul class="nav nav-pills pull-right">
                    <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                    </ul>
                    标题图片                    
                    </header>
                                                            
                    <div class="panel-body item">
                    <a href="#"><img src="images/p1.jpg" class="thumb-o"/></a>
                    <div class="hover-content">
                    <div class="overlay"></div>
                    <div class="link-contianer">
                    	<a href="#modal-media" data-toggle="modal" >更改图片</a>
                        </div>
                        </div>
                    </div>
                    
                    <div class="panel-body item text-center hidden">  
                      <a href="#modal-form" class="btn btn-success add-pic-btn" data-toggle="upload-img"><i class="fa fa-picture-o"></i> 添加标题图片</a>
                     </div> 
                                                                               
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
 <div class="modal fade" id="modal-add-tag" style="display: none;" aria-hidden="true">
     <div class="modal-dialog">
       <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h3 class="m-t-none">添加新标签</h3>
         <small>您可以在此添加新的热门标签。</small>
       </div>
         <div class="modal-body wrapper-lg">
           <div class="row">
             <div class="col-sm-12">
               <form class="form-horizontal" method="get">
                                      <div class="form-group">
                                      <label class="col-sm-2 control-label tagselectname">请输入标签</label>
                                      <div class="col-sm-9">
                                      <input type="text" class="form-control">
                                      <span class="help-block m-b-none">在此输入热门标签，已有的标签会联想显示。库中没有的标签会自动生成新的。连续输入多个标签请用英文逗号（,）或中文顿号(、)分隔。</span>
                                      </div>
                                      </div>
                                                                         
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
              <div class="checkbox m-t-lg">
                 <button type="submit" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" data-loading-text="确定中..."><strong>确定</strong></button>
              </div>
              </form>
              
             </div>
             
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div>
 <div class="modal fade" id="modal-add-hot-tag" style="display: none;" aria-hidden="true">
     <div class="modal-dialog">
       <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h3 class="m-t-none">添加热门标签</h3>
         <small>您可以在此添加新的标签。</small>
       </div>
         <div class="modal-body wrapper-lg">
           <div class="row">
             <div class="col-sm-12">
               <form class="form-horizontal" method="get">
                                      <div class="form-group">
                                      <label class="col-sm-2 control-label tagselectname" style="width: 10em;">请输入热门标签</label>
                                      <div class="col-sm-9">
                                      <input type="text" class="form-control">
                                      <span class="help-block m-b-none">在此输入标签，已有的标签会联想显示。库中没有的标签会自动生成新的。连续输入多个标签请用英文逗号（,）或中文顿号(、)分隔。</span>
                                      </div>
                                      </div>
                                                                         
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
              <div class="checkbox m-t-lg">
                 <button type="submit" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" data-loading-text="确定中..."><strong>确定</strong></button>
              </div>
              </form>
              
             </div>
             
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div>
   
   <div class="modal fade" id="modal-media" style="display: none;" aria-hidden="true">
       <div class="modal-dialog" style="min-width: 80%;">
         <div class="modal-content">
         <div class="modal-header p-b-lg">
           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
           <h3 class="m-t-none">设置标题特征图片</h3>
           <small>您可以在此设置文章的标题特征图片。</small>
           <div class="col-sm-3 pull-right">
                <div class="input-group">
                     <input type="text" class="input-sm form-control" placeholder="搜索">
                     <span class="input-group-btn">
                     <button class="btn btn-sm btn-default" type="button"><i class="fa fa-search"></i></button>
                     </span>
                 </div>
            </div>
         </div>
           <div class="modal-body">
             <div class="row">
               <div class="col-sm-12">
                 <form class="form-horizontal picgrid" method="get">
  
                  <div class="row row-sm">
                  <div class="btn-group no-padder" data-toggle="buttons">
                  
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                    <label class="btn no-padder active">
  
                      <div class="thumbnail">
                        <a href="#"><img src="images/p1.jpg" alt=""></a>
                        <small class="medianame">图片名字.jpg</small>
                      </div>
                      
                      <input type="radio" name="options" id="option1"><i class="fa fa-check text-active"></i>
                       </label>
                     </div>
                     
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                    <label class="btn no-padder"> 
  
                      <div class="thumbnail">
                        <a href="#"><img src="images/p2.jpg" alt=""></a>
                        <small class="medianame">图片名字.jpg</small>
                      </div>
                      <input type="radio" name="options" id="option2"><i class="fa fa-check text-active"></i>
                    </label>
                    </div>
                    
                    <div class="clearfix visible-xs"></div>
                    
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                         <label class="btn no-padder"> 
                    
                          <div class="thumbnail">
                                          <a href="#"><img src="images/p3.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option3"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                      <label class="btn no-padder"> 
                    
                                        <div class="thumbnail">
                                          <a href="#"><img src="images/p4.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option4"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="clearfix visible-xs"></div>
                    
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                      <label class="btn no-padder"> 
                    
                                        <div class="thumbnail">
                                          <a href="#"><img src="images/p5.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option5"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                      <label class="btn no-padder"> 
                    
                                        <div class="thumbnail">
                                          <a href="#"><img src="images/p6.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option6"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="clearfix visible-xs"></div>
                    
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                      <label class="btn no-padder"> 
                    
                                        <div class="thumbnail">
                                          <a href="#"><img src="images/p7.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option7"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                      <label class="btn no-padder"> 
                    
                                        <div class="thumbnail">
                                          <a href="#"><img src="images/p8.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option8"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="clearfix visible-xs"></div>
                    
                                                          
                  </div>
                  <div>
                    <div class="btn-group m-r">
                      <button type="button" class="btn btn-default"><i class="i i-arrow-left4"></i></button>
                      <button type="button" class="btn btn-default"><i class="i i-arrow-right4"></i></button>
                    </div>
                    已显示 <strong>8</strong> 张图片，共25张图片
                  </div>
                  </div>

                                                                           
                 <div class="line line-dashed b-b line-lg pull-in"></div>
                <div class="checkbox m-t-lg">
                   <button type="submit" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" data-loading-text="确定中..."><strong>确定</strong></button>
                </div>
                </form>
                
               </div>
               
             </div>          
           </div>
         </div><!-- /.modal-content -->
       </div><!-- /.modal-dialog -->
     </div>
   
   
  <script src="js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="js/charts/easypiechart/jquery.easy-pie-chart.js"></script>
  <script src="js/charts/sparkline/jquery.sparkline.min.js"></script>
  <script src="js/charts/flot/jquery.flot.min.js"></script>

  <script src="js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script> 
  <script src="js/datepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
  
  <script src="js/file-input/bootstrap-filestyle.min.js"></script>
  <script src="js/wysiwyg/jquery.hotkeys.js"></script>
  <script src="js/wysiwyg/bootstrap-wysiwyg.js"></script>
  <script src="js/wysiwyg/demo.js"></script>
  
  <script src="js/markdown/epiceditor.min.js"></script>
  <script src="js/calendar/bootstrap_calendar.js"></script>
  <script src="js/calendar/demo.js"></script>
  
  <script src="js/chosen/chosen.jquery.min.js"></script>
  <script src="js/spinner/jquery.bootstrap-touchspin.min.js"></script>
  <script src="js/typehead/typeahead.bundle.min.js"></script>

  <script src="js/sortable/jquery.sortable.js"></script>
  <script src="js/app.plugin.js"></script>
<script type="text/javascript">
  $('.form_date').datetimepicker({
      language: 'zh-CN',
      format: 'yyyy-mm-dd',
      weekStart: 1,
      todayBtn: 1,
      autoclose: 1,
      todayHighlight: 1,
      startView: 2,
      minView: 2,
      forceParse: 0
  });
</script>
</body>
</html>