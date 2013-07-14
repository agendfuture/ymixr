$.Class("Clock", 
	{
		elapsedTime: 0,
		callback: null,
		intervalObj: null,
		interval: 1000
	}, 
	{
		start : function(callback, interval, seek){
			this.elapsedTime = seek;
			this.callback = callback;
			this.interval = interval;
			this.intervalObj = window.setInterval($.proxy(this.tick, this), this.interval);
		},
		stop : function(){
			window.clearInterval(this.intervalObj);
		},
		tick : function(){
			this.elapsedTime = this.elapsedTime + 1;
			this.callback(this.elapsedTime);
		}

 });