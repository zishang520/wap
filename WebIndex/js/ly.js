
window.onload = function ()
{
	var OLi = document.getElementById("right_title").getElementsByTagName("li");
	var ODd = document.getElementById("right_main").getElementsByTagName("dd");
	
	for(var i = 0; i < OLi.length; i++)
	{
		OLi[i].index = i;
		OLi[i].onclick = function ()
		{
			for(var n = 0; n < OLi.length; n++) OLi[n].className="";
			this.className = "current";
			for(var n = 0; n < OUl.length; n++) OUl[n].style.display = "none";
			OUl[this.index].style.display = "block"
		}	
	}
}
