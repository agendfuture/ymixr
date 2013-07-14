$.Class("Clock", 
	{
		elapsedTime: 0,
		callback: null,
		intervalObj: null,
		interval: 1000
	}, 
	{
		init : function(){
			this.elapsedTime = 0;
		},
		start : function(callback, interval){
			this.callback = callback;
			this.interval = interval;
			this.intervalObj = setInterval($.proxy(this.tick, this), this.interval)
		},
		stop : function(){
			window.clearInterval(this.intervalObj);
			this.elapsedTime = 0;
		},
		tick : function(){
			this.elapsedTime = this.elapsedTime + 1;
			this.callback(this.elapsedTime);
		}

 });