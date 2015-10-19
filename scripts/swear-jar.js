// Description:
//   The swear jar
//
// Commands:
//   hubot swearjar - Count how much is in the swear jar
//   hubot swearjar by name - Count how much is in the swear jar per person
//   hubot swearjar by word - Count how many times each word is used
//   hubot swearjar for <user> - Count how much a user owes the swear jar

'use strict';

module.exports = swearJar;
module.exports.getValue = getJarValue;
module.exports.getValueByName = getJarValueByName;
module.exports.getValueByWord = getJarValueByWord;

var swears = new RegExp('\\b(' + [
	'(mother ?)?fuck(ing|ers?|ed|s)?',
	'clusterfuck(s)?',
	'shit(e|ting|ter|ty|test|s)?',
	'piss(ing|er|ed|s)?',
	'cunt(ed|ing|s)?',
	'assholes?',
	'arseholes?',
	'springer',
	'java',
	'scala',
	'wankers?',
	'twats?',
	'bollo(ck|x)(ing|ed|s)?',
	'wank(ing|ed|s)?',
	'twat(ting|ted)',
	'dick(s|heads?)?',
	'cock(ing|s)?',
	'ass(es)?',
	'arses?',
	'bastard(ing|s)?',
	'damn',
	'chelsea',
	'crap(ped|ping|per|py|s)?',
	'sod(ding|s)?',
	'bugger(ed|y|s)?'
].join('|') + ')\\b', 'ig');

function swearJar (robot) {
	robot.hear(swears, logSwears.bind(null, robot));
	robot.respond(/swear[ -]?jar$/i, getSwearJar.bind(null, robot));
	robot.respond(/swear[ -]?jar by (name|person|user)$/i, getSwearJarByName.bind(null, robot));
	robot.respond(/swear[ -]?jar by (swear|swearword|word)$/i, getSwearJarByWord.bind(null, robot));
	robot.respond(/swear[ -]?jar for ([a-z\s\-\']+)$/i, getSwearJarByUser.bind(null, robot));
}

function logSwears (robot, response) {
	if (Array.isArray(response.match)) {
		incrementUserSwears(robot, response.message.user.id, response.match);
	}
}

function getSwearJar (robot, response) {
	var text = 'There\'s £' + getJarValue(robot) + ' in the swear jar';
	robot.emit('slack-attachment', {
		message: {
			room: response.message.room
		},
		content: {
			fallback: text,
			title: text,
			color: '#9b7c41'
		}
	});
}

function getSwearJarByName (robot, response) {
	var data = getJarValueByName(robot);
	var text = data.map(function (row) {
		return row.title + ': _£' + row.value + '_';
	}).join('\n');
	robot.emit('slack-attachment', {
		message: {
			room: response.message.room
		},
		content: {
			fallback: text,
			title: 'How much everybody owes the swear jar:',
			text: text,
			color: '#9b7c41',
			mrkdwn_in: ['text']
		}
	});
}

function getSwearJarByWord (robot, response) {
	var data = getJarValueByWord(robot);
	var text = data.map(function (row) {
		return row.title + ': _' + row.value + '_';
	}).join('\n');
	robot.emit('slack-attachment', {
		message: {
			room: response.message.room
		},
		content: {
			fallback: text,
			title: 'Which swear words you lot like to use:',
			text: text,
			color: '#9b7c41',
			mrkdwn_in: ['text']
		}
	});
}

function getSwearJarByUser (robot, response) {
	var name = response.match[1];
	var users = robot.brain.usersForFuzzyName(name);
	if (!users.length) {
		return response.send('No user "' + name + '" was found');
	}
	if (users.length > 1) {
		users = users.map(function (user) {
			return user.name;
		});
		return response.send('Multiple matching users found: "' + users.join('", "') + '"');
	}
	var user = users[0];
	var value = getJarValueByUser(robot, user.id);
	var words = getJarWordsByUser(robot, user.id);
	var text = words.map(function (row) {
		return row.title + ': _' + row.value + '_';
	}).join('\n');
	robot.emit('slack-attachment', {
		message: {
			room: response.message.room
		},
		content: {
			fallback: text,
			title: user.name + ' owes £' + value + ' and likes to use these words:',
			text: text,
			color: '#9b7c41',
			mrkdwn_in: ['text']
		}
	});
}

function loadSwearJar (robot) {
	return robot.brain.get('swearJar') || {};
}

function saveSwearJar (robot, jar) {
	robot.brain.set('swearJar', jar);
}

function incrementUserSwears (robot, uid, swears) {
	var jar = loadSwearJar(robot);
	jar[uid] = jar[uid] || {};
	swears.forEach(function (swear) {
		swear = normalizeSwear(swear);
		jar[uid][swear] = jar[uid][swear] || 0;
		jar[uid][swear] += 1;
	});
	saveSwearJar(robot, jar);
}

function normalizeSwear (swear) {
	return swear.toLowerCase().replace(/[^a-z0-9\s\-]+/i, '');
}

function getJarValue (robot) {
	var jar = loadSwearJar(robot);
	var total = 0;
	Object.keys(jar).forEach(function (uid) {
		Object.keys(jar[uid]).forEach(function (word) {
			total += jar[uid][word];
		});
	});
	return total;
}

function getJarValueByName (robot) {
	var jar = loadSwearJar(robot);
	var records = [];
	Object.keys(jar).forEach(function (uid) {
		var user = robot.brain.userForId(uid);
		var totalForUser = 0;
		Object.keys(jar[uid]).forEach(function (word) {
			totalForUser += jar[uid][word];
		});
		records.push({
			title: (user.real_name || user.name),
			value: totalForUser
		});
	});
	records.sort(sortByValue).reverse();
	return records;
}

function getJarValueByWord (robot) {
	var jar = loadSwearJar(robot);
	var words = {};
	Object.keys(jar).forEach(function (uid) {
		Object.keys(jar[uid]).forEach(function (word) {
			words[word] = words[word] || 0;
			words[word] += jar[uid][word];
		});
	});
	var records = Object.keys(words).map(function (word) {
		return {
			title: word,
			value: words[word]
		};
	});
	records.sort(sortByValue).reverse();
	return records;
}

function getJarValueByUser (robot, uid) {
	var jar = loadSwearJar(robot);
	var total = 0;
	if (!jar[uid]) {
		return total;
	}
	Object.keys(jar[uid]).forEach(function (word) {
		total += jar[uid][word];
	});
	return total;
}

function getJarWordsByUser (robot, uid) {
	var jar = loadSwearJar(robot);
	var records = [];
	if (!jar[uid]) {
		return records;
	}
	Object.keys(jar[uid]).forEach(function (word) {
		records.push({
			title: word,
			value: jar[uid][word]
		});
	});
	records.sort(sortByValue).reverse();
	return records;
}

function sortByValue (a, b) {
	if (a.value > b.value) {
		return 1;
	}
	if (a.value < b.value) {
		return -1;
	}
	return 0;
}
