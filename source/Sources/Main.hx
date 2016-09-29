package;

import kha.System;

class Main {
	public static function main() {
		System.init("CoreGame", 800, 450, function () {
			new CoreGame();
		});
	}
}
