// Description:
//   A Owl
//   A Owl?
//   A Owl

'use strict';

module.exports = owl;

function owl (robot) {

	// A Owl
	robot.hear(/\ba owl\b/i, function (response) {
		if (/a owl\?/i.test(response.message.text)) {
			response.send('a owl');
		} else {
			response.send('a owl?');
		}
	});

	// A Hour
	robot.hear(/\ba hour\b/i, function (response) {
		if (/a hour\?/i.test(response.message.text)) {
			response.send('a hour');
		} else {
			response.send('a hour?');
		}
	});

}
