<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.preimage.js"></script> 
<script type="text/javascript">
$(document).ready(function(){
	document.title='本然创新研究服务平台';
	
	$('#profileavatar').preimage();
	$('#modifyUserInfoForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
		},
		success:function(d) {
			if(d.errorCode==0){
				alert('操作成功');
				window.location.reload();
				/*$("#modal-editprofile").find(".close").click();
				$("#modal-editprofile").find("button").removeAttr('disabled');
				$("#modal-editprofile").find("button").removeClass('disabled');*/
			}else{
				alert(d.errorMessage);
			} 
		}    	
	});
});

function logout() {
	if (confirm("确定退出吗？")) {
		location.href = "logout.action";
	} 
}
</script>
  <section class="vbox">
    <header class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow">
      <div class="navbar-header aside-xl dk">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
          <i class="fa fa-bars"></i>
        </a>
        <div class="navbar-brand">
          <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/logo.jpg" class="m-r-sm" alt="scale">
          <span class="hidden-nav-xs">本然创新研究服务平台</span>
        </div>
        <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user">
          <i class="fa fa-cog"></i>
        </a>
      </div>
      
      <form class="navbar-form navbar-left input-s-lg m-t m-l-n-xs hidden-xs" role="search" action="article_search.action">
        <div class="form-group">
          <div class="input-group">
            <span class="input-group-btn">
              <button type="submit" class="btn btn-sm bg-white b-white btn-icon"><i class="fa fa-search"></i></button>
            </span>
            <input type="text" class="form-control input-sm no-border" size="35" placeholder="请输入文章标题关键词来检索..." name="articleTitle" value="<s:property value="articleTitle"/>"/>            
          </div>
        </div>
      </form>
      <ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user user">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <span class="thumb-sm avatar pull-left">
            	<s:if test="#session.user.icon == null || #session.user.icon==''">
            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg" >
            	</s:if>
            	<s:else>
            		<img src="<%=UrlHelper.getHomeUrl()%><s:property value='#session.user.icon' />" alt="...">
            	</s:else>
            </span>
            <s:property value="#session.user.userName"/> <b class="caret"></b>
          </a>
          <ul class="dropdown-menu animated fadeInRight">            
            <li>
              <span class="arrow top"></span>
              <a href="#modal-editprofile" data-toggle="modal">个人资料设置</a>
            </li>
            <li class="divider"></li>
            <li>
              <a href="javascript:void(0)" onclick="logout()" >登出</a>
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
                        <s:if test="#session.user.icon == null">
		            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg" >
		            	</s:if>
		            	<s:else>
		            		<img src="<%=UrlHelper.getHomeUrl()%><s:property value='#session.user.icon' />" alt="...">
		            	</s:else>
                        <i class="on md b-black"></i>
                      </span>
                      <span class="hidden-nav-xs clear">
                        <span class="block m-t-xs">
                          <strong class="font-bold text-lt"><s:property value="#session.user.userName"/></strong> 
                          <b class="caret"></b>
                        </span>
                        <span class="text-muted text-xs block"><s:property value="#session.user.role.name"/></span>
                      </span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight m-t-xs">                      
                      <li>
                        <span class="arrow top hidden-nav-xs"></span>
                        <a href="#modal-editprofile" data-toggle="modal">个人资料设置</a>
                      </li>
                      <li class="divider"></li>
                      <li>
                        <a href="javascript:void(0)" onclick="logout()" data-toggle="ajaxModal" >登出</a>
                      </li>
                    </ul>
                  </div>
                </div>                

<s:if test="#session.user.role.id == 1 ||#session.user.role.id == 2 || #session.user.role.id == 6 ">
                <!-- nav -->                 
                <nav class="nav-primary hidden-xs">
                  <div class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">主菜单</div>
                  <ul class="nav nav-main" data-ride="collapse">
                  <li <s:if test="menuUrl=='index'"> class="active"</s:if> >
                      <a href="index.action?menuUrl=index" class="auto">
                        <i class="i i-home icon">
                        </i>
                        <span class="font-bold">我的主页</span>
                      </a>
                 	</li>
                 	<li <s:if test="menuUrl=='favorite_myFavoriteList'"> class="active"</s:if>>
						<a href="favorite_myFavoriteList.action?menuUrl=favorite_myFavoriteList" class="auto" target="_blank"> 
							<i class="i i-file icon"> </i> <span class="font-bold">我的项目</span> 
						</a>
					</li>
                    <!--<li <s:if test="menuUrl=='favorite_list'">class="active"</s:if>>
                       <a href="favorite_list.action?menuUrl=favorite_list" class="auto"> <i class="i i-file2"></i>
                        <span class="font-bold">我的项目</span>
                      </a>                  
                    </li>-->
                    <li <s:if test="menuUrl=='chart_init' || menuUrl=='chart_initCompare' || menuUrl=='chart_distribution'">class="active"</s:if>>
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
                         <li <s:if test="menuUrl=='chart_init'"> class="active"</s:if> >
                          <a href="chart_init.action?menuUrl=chart_init" class="auto" target="_blank">                                                        
                            <i class="i i-dot"></i>
                            <span>热点发现</span>
                          </a>
                        </li>
                         <li <s:if test="menuUrl=='chart_initCompare'"> class="active"</s:if> >
                          <a href="chart_initCompare.action?menuUrl=chart_initCompare" class="auto" target="_blank">                                                        
                            <i class="i i-dot"></i>

                            <span>热点追踪</span>
                          </a>
                        </li>
                         <li <s:if test="menuUrl=='chart_distribution'"> class="active"</s:if> >
                          <a href="chart_distribution.action?menuUrl=chart_distribution" class="auto" target="_blank">                                                        
                            <i class="i i-dot"></i>

                            <span>热点剖析</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                    
                    <li <s:if test="menuUrl=='category_manage'">class="active"</s:if>>
                       <a href="category_manage.action?menuUrl=category_manage" class="auto" target="_blank"> <i class="i i-flow-tree"></i>
                        <span class="font-bold">类别管理</span>
                      </a>                  
                    </li>
                    <li <s:if test="menuUrl=='tag_manage'">class="active"</s:if>>
                       <a href="tag_manage.action?menuUrl=tag_manage" class="auto" target="_blank"> 
                       	<i class="i i-tag"></i>
                        <span class="font-bold">标签管理</span>
                      </a>                  
                    </li>
                    
                     <!--
                     <li <s:if test="menuUrl=='allprojects'"> class="active"</s:if> >
                      <a href="allprojects.action?menuUrl=allprojects" class="auto">
                        <i class="i i-stack2 icon">
                        </i>
                        <span class="font-bold">查看全部项目</span>
                      </a>
                      </li> -->
                    <!--<li<s:if test="menuUrl=='favorite_benrFavorite'"> class="active"</s:if>><a href="favorite_benrFavorite.action?menuUrl=favorite_benrFavorite" class="auto"> <i
							class="i i-file2 icon"> </i> <span class="font-bold">本然项目</span>
					</a></li>  -->
					
					<li <s:if test="menuUrl=='user_allMember'">class="active"</s:if>>
                      <a href="user_allMember.action?menuUrl=user_allMember" class="auto" target="_blank">
                        <i class="i i-user3 icon">
                        </i>
                        <span class="font-bold">本然成员</span>
                        </a>
                      </li>
					
                    <li <s:if test="menuUrl=='user_log' || menuUrl=='user_list'">class="active"</s:if>>
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="i i-circle-sm-o text"></i>
                          <i class="i i-circle-sm text-active"></i>
                        </span>
                        <i class="i i-settings icon">
                        </i>
                        <span class="font-bold">系统管理</span>
                      </a>
                      <ul class="nav dk">
                        <li <s:if test="menuUrl=='user_list'"> class="active"</s:if> >
                          <a href="user_list.action?menuUrl=user_list" class="auto" target="_blank">                                                        
                            <i class="i i-dot"></i>

                            <span>用户管理</span>
                          </a>
                        </li>
                        <li <s:if test="menuUrl=='group_list'"> class="active"</s:if> >
                          <a href="usergroup_list.action?menuUrl=group_list" class="auto" target="_blank">                                                        
                            <i class="i i-dot"></i>
                            <span>用户组管理</span>
                          </a>
                        </li>
                        
                        <li <s:if test="menuUrl=='user_log'"> class="active"</s:if> >
                        <a href="user_log.action?menuUrl=user_log" class="auto" target="_blank">
                        	<i class="i i-dot"></i>
                        	<span class="font-bold">用户日志</span>
                        </a>
                        </li>
                        
                        <li <s:if test="menuUrl=='user_customer'"> class="active"</s:if> >
                      	<a href="user_allMember.action?menuUrl=user_customer&memberType=1" class="auto" target="_blank">
                        <i class="i i-users3 icon">
                        </i>
                            <span>客户在线状态</span>
                          </a>
                        </li>
                    </ul>
                    </li>
                    
                    <li <s:if test="menuUrl=='batchImport'"> class="active"</s:if> >
                      <a href="batchImport.action?menuUrl=batchImport" class="auto" target="_blank">
                        <i class="i i-domain3 icon">
                        </i>
                        <span class="font-bold">批量工具</span>
                      </a>
                      </li> 
                    <li <s:if test="menuUrl=='pdf_manage'"> class="active"</s:if> >
	                    <a href="pdf_manage.action?menuUrl=pdf_manage" class="auto" target="_blank">
		                    <i class="i i-upload2 icon"></i>
		                    <span class="font-bold">资料上传</span>
	                    </a>
                    </li>
                      
                    <li <s:if test="menuUrl=='article_recycle'"> class="active"</s:if> >
                      <a href="article_recycle.action?menuUrl=article_recycle" class="auto" target="_blank">
                        <i class="i i-trashcan icon">
                        </i>
                        <span class="font-bold">回收站</span>
                      </a>
                      </li> 
                        
                  </ul>
                  <div class="line dk hidden-nav-xs"></div>
                 
                </nav>
                <!-- / nav -->
</s:if>
<s:if test="#session.user.role.name == '录入员'">
                <nav class="nav-primary hidden-xs">
                  <div class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">主菜单</div>
                  <ul class="nav nav-main" data-ride="collapse">
                    <li <s:if test="menuUrl!='category_assigncategory'">class="active"</s:if>>
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
                         <li <s:if test="menuUrl=='article_insert'"> class="active"</s:if> >
                          <a href="article_insert.action?menuUrl=article_insert" class="auto"> <i class="i i-dot"></i>

                            <span>写文章</span>
                          </a>
                        </li>
                         <li <s:if test="menuUrl=='article_list'"> class="active"</s:if> >
                          <a href="article_list.action?menuUrl=article_list" class="auto"> <i class="i i-dot"></i>

                            <span>查看我的文章列表</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                    <!-- <li <s:if test="menuUrl=='category_assigncategory'">class="active"</s:if>>
                       <a href="category_assigncategory.action?menuUrl=category_assigncategory" class="auto" target="_blank"> <i class="i i-flow-tree"></i>
                        <span class="font-bold">类别管理</span>
                      </a>                  
                    </li> -->

        
                   
                  </ul>
                  <div class="line dk hidden-nav-xs"></div>
                 
                </nav>

</s:if>
<s:if test="#session.user.role.id == 4 ||#session.user.role.id == 5">
								<nav class="nav-primary hidden-xs">
									<div
										class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">主菜单</div>
									<ul class="nav nav-main" data-ride="collapse">
										<li<s:if test="menuUrl=='user_index'"> class="active"</s:if>>
											<a href="user_index.action?menuUrl=user_index" class="auto"> 
												<i class="i i-info2 icon"> </i> <span class="font-bold">最新资讯</span>
											</a>
										</li>
										
										<li<s:if test="menuUrl=='favorite_benrFavorite'"> class="active"</s:if>>
											<a href="favorite_benrFavorite.action?menuUrl=favorite_benrFavorite&showType=2" class="auto" target="_blank"> 
												<i class="i i-file2 icon"> </i> <span class="font-bold">精选资讯</span>
											</a>
										</li>
										
										<li<s:if test="menuUrl=='pdf_listByType1'"> class="active"</s:if>>
											<a href="pdf_listByType.action?type=2&menuUrl=pdf_listByType1" class="auto" target="_blank"> 
												<i class="i i-docs icon"> </i> <span class="font-bold">创新情报</span>
											</a>
										</li>
										<li<s:if test="menuUrl=='pdf_listByType2'"> class="active"</s:if>>
											<a href="pdf_listByType.action?type=1&menuUrl=pdf_listByType2" class="auto" target="_blank"> 
												<i class="i i-stats icon"> </i> <span class="font-bold">创新趋势</span>
											</a>
										</li>
										
										<li<s:if test="menuUrl=='favorite_myFavoriteList'"> class="active"</s:if>>
					                      <a href="#" class="auto">
					                        <span class="pull-right text-muted">
					                          <i class="i i-circle-sm-o text"></i>
					                          <i class="i i-circle-sm text-active"></i>
					                        </span>
					                        <i class="i i-folder icon"></i><span class="font-bold">项目文件夹</span>
					                      </a>
					                      <ul class="nav dk">
					                        <li <s:if test="menuUrl=='favorite_myFavoriteList'"> class="active"</s:if>>
												<a href="favorite_myFavoriteList.action?menuUrl=favorite_myFavoriteList" class="auto" target="_blank"> 
													<i class="i i-file icon"> </i> <span class="font-bold">我的收藏</span> 
												</a>
											</li>
					                        <li<s:if test="menuUrl=='usersharefoavorite'"> class="active"</s:if>>
					                        	<a href="usersharefoavorite.action?menuUrl=usersharefoavorite" class="auto" target="_blank"> 
					                        		<i class="i i-dot"></i> <span>共享收藏夹</span> 
					                        	</a>
					                        </li>
						                     <li class="active">
						                       <a href="favorite_benrFavorite.action?menuUrl=favorite_myFavoriteList&st=member&showType=2" class="auto" target="_blank">
						                         <i class="i i-dot icon"></i><span class="font-bold">成员项目</span>
						                       </a>
						                     </li>
					                      </ul>
					                    </li>

										<s:if test="#session.user.groupAdmin == true">
										<li <s:if test="menuUrl=='chart_init' || menuUrl=='chart_initCompare' || menuUrl=='chart_distribution'">class="active"</s:if>>
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
					                         <li <s:if test="menuUrl=='chart_init'"> class="active"</s:if> >
					                          <a href="chart_init.action?menuUrl=chart_init" class="auto" target="_blank">                                                        
					                            <i class="i i-dot"></i>
					                            <span>热点发现</span>
					                          </a>
					                        </li>
					                         <li <s:if test="menuUrl=='chart_initCompare'"> class="active"</s:if> >
					                          <a href="chart_initCompare.action?menuUrl=chart_initCompare" class="auto" target="_blank">                                                        
					                            <i class="i i-dot"></i>
					
					                            <span>热点追踪</span>
					                          </a>
					                        </li>
					                         <li <s:if test="menuUrl=='chart_distribution'"> class="active"</s:if> >
					                          <a href="chart_distribution.action?menuUrl=chart_distribution" class="auto" target="_blank">                                                        
					                            <i class="i i-dot"></i>
					
					                            <span>热点剖析</span>
					                          </a>
					                        </li>
					                      </ul>
					                    </li>
					                    </s:if>
					                    
					                    
										<li<s:if test="menuUrl=='usergroup_members'"> class="active"</s:if>>
                     						<a href="usergroup_members.action?menuUrl=usergroup_members" class="auto" target="_blank">
				                             <i class="i i-users2 icon">
				                             </i>
				                             <span class="font-bold">组员管理</span>
				                           </a>
				                        </li>
		                      			<li <s:if test="menuUrl=='usergroup_detail'"> class="active"</s:if>>
		                            	<a href="usergroup_detail.action?menuUrl=usergroup_detail" class="auto" target="_blank">
		                                    <i class="i i-info icon">
		                                    </i>
		                                    <span class="font-bold">公司帐户信息</span>
		                                  </a>
		                                </li>
									</ul>
									<div class="line dk hidden-nav-xs"></div>
								</nav>
							</s:if>
              </div>
            </section>
            
            <footer class="footer hidden-xs no-padder text-center-nav-xs">
              <a href="javascript:void(0)" onclick="logout()" data-toggle="ajaxModal" class="btn btn-icon icon-muted btn-inactive pull-right m-l-xs m-r-xs hidden-nav-xs">
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
        
     <!-- 用户编辑 -->
     <div class="modal fade" id="modal-editprofile" style="display: none;" aria-hidden="true">
     <div class="modal-dialog">
       <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h3 class="m-t-none">个人资料设置</h3>
         <small>您可以在此修改您的个人资料。</small>
       </div>
         <div class="modal-body wrapper-lg">
           <div class="row">
             <div class="col-sm-12">
             <form class="form-horizontal" method="post" id="modifyUserInfoForm" action="updateUserProfile.action" enctype="multipart/form-data">
             	<input type="hidden" name="user.id" value="<s:property value="#session.user.id"/>"/>
                                    <div class="form-group">
                                    <label class="col-sm-3 control-label p-t-none">用户名</label>
                                    <div class="col-sm-9 ">
                                     <s:property value="#session.user.userName"/>
                                    </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">原密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="password" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请输入你原来的密码。</span>
                                     </div>
                                    </div>
                                    
                                  <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                    <label class="col-sm-3 control-label">新密码<span class="redstar"> *</span></label>
                                    <div class="col-sm-9">
                                    <input type="password" name="newPassword" class="form-control">
                                    <span class="help-block m-b-none">此项为必填，请使用英文字母和数字作为密码，密码长度为8~16位之间，大小写不限，不能使用特殊符号。</span>
                                    </div>
                                   </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">重复新密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="rePassword" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请再次输入密码。</span>
                                     </div>
                                    </div>
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
                                       <div class="form-group">
                                       <label class="col-sm-3 control-label">电子邮箱<span class="redstar"> *</span></label>
                                       <div class="col-sm-9">
                                       <input type="text" class="form-control" value="<s:property value="#session.user.email"/>" name="user.email">
                                                   <span class="help-block m-b-none">此项为必填。</span>
                                                 </div>
                                               </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>

                                    <div class="form-group">
                                                 <label class="col-sm-3 control-label">上传头像</label>
                                                 <div class="col-sm-9">
                                                 <span class="thumb-lg avatar pull-left">
                                                   <s:if test="#session.user.icon == null">
									            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg" width="128" height="128">
									            	</s:if>
									            	<s:else>
									            		<img src="<%=UrlHelper.getHomeUrl()%><s:property value='#session.user.icon' />" width="128" height="128">
									            	</s:else>
									            	<input type="file" id="profileavatar" name="avatar" class="btn btn-s-md btn-default btn-rounded change-avatar" />
                                                   <!-- <a href="#" class="btn btn-s-md btn-default btn-rounded change-avatar">点击更改头像</a> -->
                                                 </span>
                                                 </div>
                                                 
                                                 
                                               </div>
                                               
                                               <div class="line line-dashed b-b line-lg pull-in"></div>
                                               <div class="checkbox m-t-lg">
                                               <button type="button" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="取消中..." onclick="$('#modal-editprofile').find('.close').click();"><strong>关闭</strong></button>
                                               <button type="button" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..." onclick="$('#modifyUserInfoForm').submit();"><strong>保存修改</strong></button>
                                               </div>
                                             </form>
                             </div>
             
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div> 
        
        
