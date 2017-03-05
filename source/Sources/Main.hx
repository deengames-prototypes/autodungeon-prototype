package;

import kha.System;

class Main {
	public static function main() {
		System.init({title:"CoreGame", width:800, height:450}, function () {
			new CoreGame();
		});
	}
}
