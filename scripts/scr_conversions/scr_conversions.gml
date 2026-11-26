function bin_to_dec(_bin) {
	var _dec = 0;
	var _len = string_length(_bin);
	for (var i = 0; i < _len; i++) {
		if (string_char_at(_bin, i) == "1") {
			_dec += 1 << (_len - i);
		}
	}
	return _dec;
}

function dec_to_bin(_dec, _min_len = 1) {
	if (_dec == 0) {
		return string_repeat("0", _min_len);
	}
	var _bin = "";
	while (_dec > 0) {
		_bin = string(_dec & 1) + _bin;
		_dec = _dec >> 1;
	}
	while (string_length(_bin) < _min_len) {
		_bin = "0" + _bin;
	}
	return _bin;
}

function make_hex() {
	var _chars = ["0", "1", "2", "3", "4", "5", "6", "7",
                  "8", "9", "A", "B", "C", "D", "E", "F"];
	var _hex = "0x";
	for (var i = 0; i < 6; i++) {
		_hex += _chars[irandom(15)];
	}
	return _hex;
}