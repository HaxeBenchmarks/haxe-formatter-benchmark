import haxe.Timer;
import haxe.macro.Compiler;

/**
	helper class to build everything, avoids `--next`
**/
class Build {
	/**
		run all build files
	**/
	public static function main() {
		callLix("build/buildCpp.hxml", "C++");
		callLix("build/buildCs.hxml", "C#");
		callLix("build/buildJava.hxml", "Java");
		callLix("build/buildJvm.hxml", "JVM");
		callLix("build/buildHl.hxml", "HL/Jit");
		#if haxe4
		callLix("build/buildHlc.hxml", "HL/C");
		#end
		callLix("build/buildJs.hxml", "JS/ES5");
		callLix("build/buildJsES6.hxml", "JS/ES6");
		callLix("build/buildNeko.hxml", "Neko");
		callLix("build/buildPhp.hxml", "PHP7");
		callLix("build/buildPython.hxml", "Python");
	}

	/**
		perform lix call and take build times

		@param buildFile HXML build file
		@param title description to use when printing build time
	**/
	public static function callLix(buildFile:String, title:String) {
		var startTime = Timer.stamp();
		var exitCode:Int = Sys.command("npx", ["haxe", buildFile]);
		var exitText:String = "";
		if (exitCode != 0) {
			exitText = ' - exitCode: $exitCode';
		}

		Sys.println('[${Compiler.getDefine("haxe_ver")}] building $title (${Timer.stamp() - startTime})$exitText');
	}
}
