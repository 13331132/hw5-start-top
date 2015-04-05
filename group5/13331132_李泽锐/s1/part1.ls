$ ->
	fresh!
	start!
	document.getElementById("test").onmouseout = !->
		if (event.offsetX < -1 || event.offsetX > 140 || event.offsetY > 279 || event.offsetY < -1)
			fresh!
			start!
worked = []
ready = []

fresh = !->
	enable-all-buts!
	set-unread!

enable-all-buts = !->
	i = 0
	buts = $ ".control-ring-container li"
	for but in buts
		$(but).add-class "init"
		worked[i] = \free
		ready[i++] = \yes

set-unread = !->
	unreads = $ ".control-ring-container span"
	for unread in unreads
		$(unread).css "visibility","hidden" .html "..."


start = !->
	
	range = [0,1,2,3,4]
	buts = $ ".control-ring-container li"
	for but in buts
		but.onclick  = action

action = !->
	range = [0,1,2,3,4]
	buts = $ ".control-ring-container li"
	for i in range
		if @ == buts[i]
			p = i

	if worked[p] == \work || ready[p] == \no
		return
	worked[p] = \work
	for i in range
		ready[i] = \no
		if i !~= p
			$(buts[i]).remove-class "init" .add-class "disabled"
	XMLhttp = new XMLHttpRequest();
	XMLhttp.open("GET", "/", true)
	XMLhttp.send();
	XMLhttp.onreadystatechange = !->
		if XMLhttp.readyState == 4 && XMLhttp.status == 200
			$(buts[p]).find "span" .html XMLhttp.responseText
			$(buts[p]). remove-class "init" .add-class"disabled"
			for i in range
				if worked[i] == \free
					ready[i] = \yes
			for i in range
				if ready[i] == \yes
					$(buts[i]).remove-class "disabled" .add-class "init"
			for i in range
				if worked[i] == \free
					return
			$ ".info" .add-class "init"
			$ ".info".onclick = !->
				sum = 0
				for i in range
					sum += parseInt ($(buts[i]). find "span" .html!)
				$ ".info ul" .html sum.to-string!
	$(buts[p]).find "span" .css "visibility","visible"



