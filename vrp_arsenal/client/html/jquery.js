$(document).ready(function(){
	let actionContainer = $("#container");

	window.addEventListener("message",function(event){

		switch(event.data.action){
			case "showMenu":
				actionContainer.fadeIn(500);
				$("#armas").load("equip.html");
			break;

			case "hideMenu":
				actionContainer.fadeOut(500);
			break;

			case 'equipList':
				equipList();
			break;
		}
	});


	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_arsenal/shopClose");
		}
	};
});

const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}

const carregarMenu = (name) => {
	return new Promise((resolve) => {
		$("#armas").load(name+".html",function(){
			resolve();
		});
	});
}

const autoList = () => {
	$.post("http://vrp_arsenal/autoList",JSON.stringify({}),(data) => {		
		let i = 0;
		const nameList = data.shopitens.sort((a,b) => (a.name > b.name) ? 1: -1);
		$('#armas').html(`			
			<div class="button">                  
                <div><input class="barrinha" id="amount" type="text"></div>   
                <div class="take">RETIRAR</div>
                <div class="give">DEVOLVER</div>
                <div class="buy">ENCOMENDAR</div>
            </div>	
            <div class="displayarmas">		
			${nameList.map((item) => (`
                <div class="listaarma" data-index="auto" id="${item.index}">
                    <img src="img/${item.img}.png" class="img">
                    <div class="ext">
                        <div class="desc">
	                        <div class="name">${item.name}</div>
                        	${item.desc}
                        </div>
                    </div>
                </div>   
			`)).join('')}
		</div>`);
	});
}

const semiList = () => {
	$.post("http://vrp_arsenal/semiList",JSON.stringify({}),(data) => {		
		let i = 0;
		const nameList = data.shopitens.sort((a,b) => (a.name > b.name) ? 1: -1);
		$('#armas').html(`			
			<div class="button">                  
                <div><input class="barrinha" id="amount" type="text"></div>   
                <div class="take">RETIRAR</div>
                <div class="give">DEVOLVER</div>
                <div class="buy">ENCOMENDAR</div>
            </div>	
            <div class="displayarmas">		
			${nameList.map((item) => (`
                 <div class="listaarma" data-index="semi" id="${item.index}">
                    <img src="img/${item.img}.png" class="img">
                    <div class="ext">
                        <div class="desc">
	                        <div class="name">${item.name}</div>
                        	${item.desc}
                        </div>
                    </div>
                </div>                
			`)).join('')}
		</div>`);
	});
}



const ammoList = () => {
	$.post("http://vrp_arsenal/ammoList",JSON.stringify({}),(data) => {		
		let i = 0;
		const nameList = data.shopitens.sort((a,b) => (a.name > b.name) ? 1: -1);
		$('#armas').html(`
		<div class="button">                  
                <div><input class="barrinha" id="amount" type="text"></div>   
                <div class="take">RETIRAR</div>
                <div class="give">DEVOLVER</div>
                <div class="buy">ENCOMENDAR</div>
            </div>	
            <div class="displayarmas">		
			${nameList.map((item) => (`
                <div class="listaarma" data-index="ammo" id="${item.index}">
                    <img src="img/${item.img}.png" class="img">
                    <div class="ext">
                        <div class="desc">
	                        <div class="name">${item.name}</div>
                        	${item.desc}
                        </div>
                    </div>
                </div>                
			`)).join('')}
		</div>`);
	});
}


const equipList = () => {
	$.post("http://vrp_arsenal/equipList",JSON.stringify({}),(data) => {		
		let i = 0;
		const nameList = data.shopitens.sort((a,b) => (a.name > b.name) ? 1: -1);
		$('#armas').html(`			
			<div class="button">                  
                <div><input class="barrinha" id="amount" type="text"></div>   
                <div class="take">RETIRAR</div>
                <div class="give">DEVOLVER</div>
            </div>	
            <div class="displayarmas">		
			${nameList.map((item) => (`
                <div class="listaarma" id="${item.index}">
                    <img src="img/${item.img}.png" class="img">
                	<div class="ext">
                        <div class="desc">
	                        <div class="name">${item.name}</div>
                        	${item.desc}
                        </div>
                 	</div>
                </div>                
			`)).join('')}
		</div>`);
	});
}



$(document).on("click",".listaarma",function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.listaarma').removeClass('active');
	if(!isActive) $el.addClass('active');
});



$(document).on("click",".menulist",function(){
	let $cls = $(this);
	let ativo = $cls.hasClass('active');
	$('.menulist').removeClass('active');
	if(!ativo) $cls.addClass('active');
});




$(document).on("click",".take",function(){
   	let $el = $('.listaarma.active');
	let amount = Number($('#amount').val());
	if($el && amount > 0){
	 $.post("http://vrp_arsenal/takeGun",JSON.stringify({
	 	index: $el.attr('id'),
	 	amount
	 }));
	}   
	sleep(250,$el.attr('data-index'))
});
  

function sleep(milliseconds,page) {
    const date = Date.now()
    let currentDate = null
    do {
      currentDate = Date.now()
    } while (currentDate - date < milliseconds)
   	carregarMenu(page)
  }