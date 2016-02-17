module.exports = (function(v, E) {
	var D = {};
	D.library = "components";
	var B = D.lib = {};
	var z = B.Base = (function() {
		function b() {}
		return {
			extend: function(d) {
				b.prototype = this;
				var c = new b();
				if (d) {
					c.mixIn(d)
				}
				if (!c.hasOwnProperty("init")) {
					c.init = function() {
						c.$super.init.apply(this, arguments)
					}
				}
				c.init.prototype = c;
				c.$super = this;
				return c
			},
			create: function() {
				var c = this.extend();
				c.init.apply(c, arguments);
				return c
			},
			init: function() {},
			mixIn: function(d) {
				for (var c in d) {
					if (d.hasOwnProperty(c)) {
						this[c] = d[c]
					}
				}
				if (d.hasOwnProperty("toString")) {
					this.toString = d.toString
				}
			},
			clone: function() {
				return this.init.prototype.extend(this)
			}
		}
	}());
	var n = B.WordArray = z.extend({
		init: function(b, c) {
			b = this.words = b || [];
			if (c != E) {
				this.sigBytes = c
			} else {
				this.sigBytes = b.length * 4
			}
		},
		toString: function(b) {
			return (b || C).stringify(this)
		},
		concat: function(c) {
			var e = this.words;
			var f = c.words;
			var h = this.sigBytes;
			var b = c.sigBytes;
			this.clamp();
			if (h % 4) {
				for (var d = 0; d < b; d++) {
					var g = (f[d >>> 2] >>> (24 - (d % 4) * 8)) & 255;
					e[(h + d) >>> 2] |= g << (24 - ((h + d) % 4) * 8)
				}
			} else {
				if (f.length > 65535) {
					for (var d = 0; d < b; d += 4) {
						e[(h + d) >>> 2] = f[d >>> 2]
					}
				} else {
					e.push.apply(e, f)
				}
			}
			this.sigBytes += b;
			return this
		},
		clamp: function() {
			var b = this.words;
			var c = this.sigBytes;
			b[c >>> 2] &= 4294967295 << (32 - (c % 4) * 8);
			b.length = v.ceil(c / 4)
		},
		clone: function() {
			var b = z.clone.call(this);
			b.words = this.words.slice(0);
			return b
		},
		random: function(b) {
			var c = [];
			for (var d = 0; d < b; d += 4) {
				c.push((v.random() * 4294967296) | 0)
			}
			return new n.init(c, b)
		}
	});
	var F = D.enc = {};
	var I = F.BitConverter = {
		ToInt32: function(d, c) {
			var b = d.slice(c, c + 4);
			return (b[0] << 24) + (b[1] << 16) + (b[2] << 8) + (b[3])
		},
		FromInt32: function(b) {
			return [b >>> 24, (b >> 16) & 255, (b >> 8) & 255, b & 255]
		},
		ToWordArray: function(c) {
			var e = c.length;
			var b = [];
			for (var d = 0; d < e; d++) {
				b[d >>> 2] |= (c[d] & 255) << (24 - (d % 4) * 8)
			}
			return new n.init(b, e)
		},
		FromWordArray: function(d) {
			var c = d.words;
			var e = d.sigBytes;
			var g = [];
			for (var f = 0; f < e; f++) {
				var b = (c[f >>> 2] >>> (24 - (f % 4) * 8)) & 255;
				g.push(b)
			}
			return g
		}
	};
	var C = F.Hex = {
		stringify: function(e) {
			var c = e.words;
			var f = e.sigBytes;
			var d = [];
			for (var g = 0; g < f; g++) {
				var b = (c[g >>> 2] >>> (24 - (g % 4) * 8)) & 255;
				d.push((b >>> 4).toString(16));
				d.push((b & 15).toString(16))
			}
			return d.join("")
		},
		parse: function(c) {
			var e = c.length;
			var b = [];
			for (var d = 0; d < e; d += 2) {
				b[d >>> 3] |= parseInt(c.substr(d, 2), 16) << (24 - (d % 8) * 4)
			}
			return new n.init(b, e / 2)
		}
	};
	var w = F.Latin1 = {
		stringify: function(d) {
			var c = d.words;
			var e = d.sigBytes;
			var g = [];
			for (var f = 0; f < e; f++) {
				var b = (c[f >>> 2] >>> (24 - (f % 4) * 8)) & 255;
				g.push(String.fromCharCode(b))
			}
			return g.join("")
		},
		parse: function(c) {
			var e = c.length;
			var b = [];
			for (var d = 0; d < e; d++) {
				b[d >>> 2] |= (c.charCodeAt(d) & 255) << (24 - (d % 4) * 8)
			}
			return new n.init(b, e)
		}
	};
	var y = F.Utf8 = {
		stringify: function(c) {
			try {
				return decodeURIComponent(escape(w.stringify(c)))
			} catch (b) {
				ExceptionManager.put(b, "Utf8.stringify({wordArray})")
			}
		},
		parse: function(b) {
			return w.parse(unescape(encodeURIComponent(b)))
		}
	};
	var A = B.BufferedBlockAlgorithm = z.extend({
		reset: function() {
			this._data = new n.init();
			this._nDataBytes = 0
		},
		_append: function(b) {
			if (typeof b == "string") {
				b = y.parse(b)
			}
			this._data.concat(b);
			this._nDataBytes += b.sigBytes
		},
		_process: function(c) {
			var d = this._data;
			var b = d.words;
			var g = d.sigBytes;
			var j = this.blockSize;
			var h = j * 4;
			var i = g / h;
			if (c) {
				i = v.ceil(i)
			} else {
				i = v.max((i | 0) - this._minBufferSize, 0)
			}
			var k = i * j;
			var l = v.min(k * 4, g);
			if (k) {
				for (var e = 0; e < k; e += j) {
					this._doProcessBlock(b, e)
				}
				var f = b.splice(0, k);
				d.sigBytes -= l
			}
			return new n.init(f, l)
		},
		clone: function() {
			var b = z.clone.call(this);
			b._data = this._data.clone();
			return b
		},
		_minBufferSize: 0
	});
	var G = B.Hasher = A.extend({
		cfg: z.extend(),
		init: function(b) {
			this.cfg = this.cfg.extend(b);
			this.reset()
		},
		reset: function() {
			A.reset.call(this);
			this._doReset()
		},
		update: function(b) {
			this._append(b);
			this._process();
			return this
		},
		finalize: function(c) {
			if (c) {
				this._append(c)
			}
			var b = this._doFinalize();
			return b
		},
		blockSize: 512 / 32,
		_createHelper: function(b) {
			return function(d, c) {
				return new b.init(c).finalize(d)
			}
		},
		_createHmacHelper: function(b) {
			return function(d, c) {
				return new x.HMAC.init(b, c).finalize(d)
			}
		}
	});
	var x = D.algo = {};
	D.required = {};
	D.require = function(b, d) {
		if (typeof d == "string") {
			b = (d = [].slice.apply(arguments)).shift()
		}
		if (d && d.constructor == Array && d.length > 0) {
			for (var f = 0; f < d.length; f++) {
				D.require(d[f])
			}
		}
		if (D.required[b] === true) {
			return D.require
		}
		var c = __dirname + "\\components\\" + b + ".js";
		if (IO.file.exists(c)) {
			var e = new Function("exports", "module", "__filename", "__dirname", IO.file.readAllText(c));
			e.call(D, D, null, c, __dirname + "\\components");
			D.required[b] = true
		}
		return D.require
	};
	var m = {
		Hmac: ["hmac"],
		MD5: ["md5"],
		SHA1: ["sha1"],
		SHA3: ["sha3", "x64-core"],
		SHA224: ["sha224", "sha256"],
		SHA256: ["sha256"],
		SHA384: ["sha384", "x64-core", "sha512"],
		SHA512: ["sha512", "x64-core"],
		PBKDF2: ["pbkdf2", ["hmac", "sha1"]],
		EvpKDF: ["evpkdf", ["md5"]],
		RIPEMD160: ["ripemd160"],
		Base64: ["enc-base64"],
		Utf16: ["enc-utf16"],
		RC4: ["rc4", "enc-base64", "evpkdf", "cipher-core"],
		RabbitLegacy: ["rabbit-legacy", "enc-base64", "evpkdf", "cipher-core"],
		Rabbit: ["rabbit", "enc-base64", "evpkdf", "cipher-core"],
		DES: ["tripledes", "enc-base64", "evpkdf", "cipher-core"],
		AES: ["aes", "enc-base64", "evpkdf", "cipher-core"],
		Mode: ["mode", "enc-base64", "evpkdf", "cipher-core"],
		Padding: ["pad", "enc-base64", "evpkdf", "cipher-core"],
		X64: ["x64-core"],
		Format: {
			Hex: ["format-hex", "enc-base64", "evpkdf", "cipher-core"]
		}
	};
	var u = function(b) {
		return function(c) {
			return D.require.apply(c, b)
		}
	};
	for (var H in m) {
		if (!m.hasOwnProperty(H)) {
			continue
		}
		if (m[H].constructor == Array) {
			D.require[H] = u(m[H])
		} else {
			D.require[H] = {};
			for (var t in m[H]) {
				if (!m[H].hasOwnProperty(t)) {
					continue
				}
				D.require[H][t] = u(m[H][t])
			}
		}
	}
	delete u;
	delete m;
	return D
}(Math));