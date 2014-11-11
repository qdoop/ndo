/**
 * Created by qdoop on 01/11/14.
 */

// --NOTES-------------
//
// nodemon -e js,coffee --ignore out/ --ignore src/  index.js
//
// coffee -o _out -c chathub.coffee
//

console.log('++dummy++00+++++++++++++++++++++++++++');
global.log0=console.log;
global.oapp=global.oapp || {};
// var oapp=global.oapp;
oapp.jprefix='./';

Object.defineProperty(global, '__stack', {
	get: function(){
		var orig = Error.prepareStackTrace;
		Error.prepareStackTrace = function(_, stack){ return stack; };
		var err = new Error;
		Error.captureStackTrace(err, arguments.callee);
		var stack = err.stack;
		Error.prepareStackTrace = orig;
//		debugger;
//		console.log(stack);
		return stack;
	}
});

Object.defineProperty(global, '__line', {
	get: function(){
		return __stack[1].getLineNumber();
	}
});

Object.defineProperty(global, '__function', {
	get: function() {
		return __stack[1].getFunctionName();
	}
});

function test0() {
	console.log(__line);
	console.log(__function);
	console.log(arguments.callee.caller);
	console.log('--------------------------------------------------------------');
}

function test1(){test0();}
// test1();


//var VERSION=require('./version.js');
//console.log(VERSION);


if(!process.env.PORT){

}

var coffee=require('coffee-script/register');


var main=require('./main.coffee');


