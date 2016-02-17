$(function(){
/*
 * @Author wdb
 * jQuery标签切换(常规切换)
 * 参数：pDiv,cDiv
 * pDiv：标签层
 * pBtn：按钮层
 * cDiv：内容显示层
 * 调用：$.tag(".pDiv",".cDiv");
 * */
	jQuery.tag = function(pDiv,cDiv,pBtn,current){
		//先隐藏cDiv
		$(pDiv + " " + cDiv).hide();
		
		//默认显示第一个
		$(pDiv + " " + pBtn + ":eq(0)").addClass("onfocus");
		$(pDiv + " " + cDiv + ":eq(0)").show();
		
		//获取标签总数
		TheCount = $(pDiv + " " + pBtn).length;
		
		//点击标签时
		$(pDiv + " " + pBtn).click(function(){
			index = $(pDiv + " " + pBtn).index(this);
			$(pDiv + " " + pBtn + ":eq(" + index + ")").addClass(current).siblings("."+current).removeClass(current);
			/*for (var i=0;i < TheCount;i++){	
				alert(i);*/
				$(pDiv + " " + cDiv ).hide();
			/*}*/
			$(pDiv + " " + cDiv + ":eq("+index+")").show();
		})
	}
})