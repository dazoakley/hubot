// jshint unused: false
'use strict';

global.robotHear = robotHear;
global.robotRespond = robotRespond;

// Trigger a response when the robot hears a term:
//
//     module.exports = robotHear(/\b(rug)\b/i, 'That rug really tied the room together.');
//
// You can also specify an array as a response, a random one will be picked:
//
//     module.exports = robotHear(/\b(should i)\b/i, ['Yes', 'No']);
//
function robotHear (trigger, message) {
	message = messageToArray(message);
	return function (robot) {
		robot.hear(trigger, function (response) {
			response.send(response.random(message));
		});
	};
}

// Trigger a response when the robot is issued a command:
//
//     module.exports = robotRespond(/crab me/i, ':crab:');
//
// You can also specify an array as a response, a random one will be picked:
//
//     module.exports = robotRespond(/crab me/i, [':crab:', 'I am all out of crabs :(']);
//
function robotRespond (trigger, message) {
	message = messageToArray(message);
	return function (robot) {
		robot.respond(trigger, function (response) {
			response.send(response.random(message));
		});
	};
}

function messageToArray (message) {
	if (!Array.isArray(message)) {
		return [message];
	}
	return message;
}
