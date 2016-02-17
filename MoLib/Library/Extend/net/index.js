var $net = {
	IpToLong: function(g) {
		var h = 0;
		g = "" + g + "";
		if (g.indexOf(".") <= 0) {
			return 0
		}
		var f = g.split(".");
		if (f.length != 4) {
			return 0
		}
		for (var e = 0; e < 4; e++) {
			if (isNaN(f[e]) || parseInt(f[e]) < 0 || parseInt(f[e]) > 255) {
				return 0
			}
			h += parseInt(f[e]) * Math.pow(256, 3 - e)
		}
		return h
	},
	LongToIp: function(c) {
		if (isNaN(c)) {
			return ""
		}
		c = parseInt(c);
		var d = new Array(4);
		d[0] = c >>> 24;
		d[1] = (c >>> 16) & 255;
		d[2] = (c >>> 8) & 255;
		d[3] = c & 255;
		return d.join(".")
	},
	InSameNetWork: function(i, j, k) {
		if (k == undefined) {
			k = j;
			if (i.indexOf("/") <= 0) {
				i += "/255.255.255.255"
			}
			if (i.indexOf("/") == i.length) {
				return false
			}
			var l = i.split("/");
			if (l.length != 2) {
				return false
			}
			i = l[1];
			j = l[0]
		}
		if (!isNaN(i)) {
			var h = parseInt(i);
			if (i < 0 || i > 32) {
				return false
			}
			var m = 0;
			for (var n = 1; n <= 32; n++) {
				if (n <= i) {
					m += Math.pow(2, 32 - n)
				}
			}
			i = this.LongToIp(m)
		}
		if (!this.IsIP(i) || !this.IsIP(j) || !this.IsIP(k)) {
			return false
		}
		i = this.IpToLong(i);
		j = this.IpToLong(j);
		k = this.IpToLong(k);
		if ((i & j) != (i & k)) {
			return false
		}
		return true
	},
	IsIP: function(f) {
		if (f.indexOf(".") <= 0) {
			return false
		}
		var e = f.split(".");
		if (e.length != 4) {
			return false
		}
		for (var d = 0; d < 4; d++) {
			if (e[d] == "" || isNaN(e[d]) || parseInt(e[d]) < 0 || parseInt(e[d]) > 255) {
				return false
			}
		}
		return true
	}
};
module.exports = $net;