
<style>
//
.sw {
	position: relative;
	width: 312px;
	margin: 0 auto;
	left: 636;
	top: 23;
	z-index: 50;
	background: #FFFFFF;
}
</style>
<script>
function js_func1()
{
	alert(document.search.requery.value);
}
</script>
<form name="search" method="post"><input type=hidden
	name='tmpStr' value='' id='tmpStr'> <input type="text"
	style="width: 800px;" class="input" id="suggestKeyword" name="requery"
	value='' tabindex=1 style="ime-mode: active;" autocomplete="off">
<div class="sw" id='sw'>
<div id='lSuggestResult'
	style='display: inline; position: absolute; left: 0; top: -3px; z-index: 50; border: 1px solid #C3C3C3; width: 314px; height: 95px;'>
<iframe src="keywordinfo.html" width="314" height="95" frameborder="1"
	scrolling="no"></iframe></div>
</div>
</form>
<script>
var src_div = document.getElementById('suggestKeyword');
var target_div = document.getElementById('sw');
var src_x = src_div.style.left;
var src_y = src_div.style.top;
target_div.style.position='relative';
//target_div.style.backgroundcolor='red';
target_div.style.left = src_x;
target_div.style.top =  src_y+10;

</script>