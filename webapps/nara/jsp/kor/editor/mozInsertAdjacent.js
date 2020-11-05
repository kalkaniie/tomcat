	alert("mozInsertAdjacent.js");

if(typeof HTMLElement!="undefined" && !HTMLElement.prototype.insertAdjacentElement){
alert("aaa");
	HTMLElement.prototype.insertAdjacentElement = function(where,parsedNode)
	{
			if (this.nextSibling) 
				this.parentNode.insertBefore(parsedNode,this.nextSibling);
			else this.parentNode.appendChild(parsedNode);
	}

	HTMLElement.prototype.insertAdjacentHTML = function(where,htmlStr)
	{
		var r = this.ownerDocument.createRange();
		r.setStartBefore(this);
		var parsedHTML = r.createContextualFragment(htmlStr);
		this.insertAdjacentElement(where,parsedHTML)
	}

alert("22222222");
	HTMLElement.prototype.insertAdjacentText = function(where,txtStr)
	{
		var parsedText = document.createTextNode(txtStr)
		this.insertAdjacentElement(where,parsedText)
	}
	alert("3333333333");
}