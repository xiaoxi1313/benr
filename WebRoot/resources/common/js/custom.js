$('#startTime').datepicker({
  format: 'yyyy.mm.dd',
        weekStart: 1,
        autoclose: true,
        language: 'zh-CN',
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0

 }).on('changeDate',function(ev){
  var startTime = ev.date.valueOf();
  if(start<teach){
   alert("“评估开始时间 ”不能早于“授课时间 ” ！");
   $("#starttime").focus();
  }
   });
 $('#endTime').datepicker({
  format: 'yyyy.mm.dd',
        weekStart: 1,
        autoclose: true,
        todayBtn: 1,
        language: 'zh-CN',
 }).on('changeDate',function(ev){
  var endTime = ev.date.valueOf();
  end = endTime;
  if(end<start){
   alert("“评估结束时间 ”不能早于“评估开始时间 ” ！");
   
  }else{
   
  }
 });
