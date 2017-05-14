var tmr_delay = 0;
function hidePurchaseType() {
	if (tmr_delay == 5) {
		//PurchaseCDMode.ButtonClose.onRelease();
		Cart._visible = false;
		tmr_delay = 0;
		clearInterval(purchaseID);
	} else {
		tmr_delay += 1;
	}
}
Cart.Button.onRollOver = function() {
	selectObj("Cart.Movie");
	level = 4;
};
Cart.Button.onRelease = function() {
	fscommand("showShopping", true);
};
PurchaseCDMode.ButtonClose.onRollOver = function() {
	selectObj("PurchaseCDMode.MovieClose");
	level = 3;
};
PurchaseCDMode.ButtonClose.onRelease = function() {
	tmr_delay = 0;
	PurchaseCDMode._visible = false;
	enableMouse._visible = false;
	Cart.Button.onRollOver();
};
for (var j = 0; j<4; j++) {
	eval("PurchaseCDMode.Button"+j).onRollOver = function() {
		level = 3;
		selectObj("PurchaseCDMode.Movie"+getindex(this._name, "n"));
	};
	eval("PurchaseCDMode.Button"+j).onRelease = function() {
		var k = getindex(this._name, "n");
		if (eval("PurchaseCDMode.Button"+k).enabled) {
			PurchaseCDMode._visible = false;
			enableMouse._visible = false;
			Cart.Button.onRollOver();
			fscommand("buyCD", k);
		}
	};
	eval("PurchaseCDMode.ButtonCart"+j).onRollOver = function() {
		level = 3;
		selectObj("PurchaseCDMode.MovieCart"+getindex(this._name, "t"));
	};
	eval("PurchaseCDMode.ButtonCart"+j).onRelease = function() {
		var k = getindex(this._name, "t");
		if (eval("PurchaseCDMode.ButtonCart"+k).enabled) {
			PurchaseCDMode._visible = false;
			enableMouse._visible = false;
			Cart.Button.onRollOver();
			loadWebShopping(k);
		}
	};
}
function VisibleChecked(str) {
	var spl = str.split("~");
	for (var j = 0; j<spl.length; j++) {
		if (spl[j].length>0) {
			eval("PurchaseCDMode.Button"+j).enabled = true;
			eval("PurchaseCDMode.Text"+j).TextColor = text_color;
		} else {
			eval("PurchaseCDMode.Button"+j).enabled = false;
			eval("PurchaseCDMode.Text"+j).TextColor = "0x999999";
		}
	}
}
function MovePurchaseKey(Key) {
	if (Key == 38) {
		fscommand("offScreen", true);
		StaticMove("PurchaseCDMode.MovieClose,PurchaseCDMode.Movie0,PurchaseCDMode.Movie1,PurchaseCDMode.Movie2,PurchaseCDMode.Movie3,PurchaseCDMode.MovieCart0,PurchaseCDMode.MovieCart1,PurchaseCDMode.MovieCart2,PurchaseCDMode.MovieCart3", storeName, "Left");
	} else if (Key == 40) {
		fscommand("offScreen", true);
		StaticMove("PurchaseCDMode.MovieClose,PurchaseCDMode.Movie0,PurchaseCDMode.Movie1,PurchaseCDMode.Movie2,PurchaseCDMode.Movie3,PurchaseCDMode.MovieCart0,PurchaseCDMode.MovieCart1,PurchaseCDMode.MovieCart2,PurchaseCDMode.MovieCart3", storeName, "Right");
	} else if (Key == 37) {
		fscommand("offScreen", true);
		if (storeName == "PurchaseCDMode.MovieCart0") {
			PurchaseCDMode.Button0.onRollOver();
		} else if (storeName == "PurchaseCDMode.MovieCart1") {
			PurchaseCDMode.Button1.onRollOver();
		} else if (storeName == "PurchaseCDMode.MovieCart2") {
			PurchaseCDMode.Button2.onRollOver();
		} else if (storeName == "PurchaseCDMode.MovieCart3") {
			PurchaseCDMode.Button3.onRollOver();
		}
	} else if (Key == 39) {
		fscommand("offScreen", true);
		if (storeName == "PurchaseCDMode.Movie0") {
			PurchaseCDMode.ButtonCart0.onRollOver();
		} else if (storeName == "PurchaseCDMode.Movie1") {
			PurchaseCDMode.ButtonCart1.onRollOver();
		} else if (storeName == "PurchaseCDMode.Movie2") {
			PurchaseCDMode.ButtonCart2.onRollOver();
		} else if (storeName == "PurchaseCDMode.Movie3") {
			PurchaseCDMode.ButtonCart3.onRollOver();
		} else if (storeName == "PurchaseCDMode.MovieCart0") {
			PurchaseCDMode.ButtonClose.onRollOver();
		}
	}
}