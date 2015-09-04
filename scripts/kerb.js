// Description:
//   Eat Street / Kerb Traders List for the week ahead
//
// Commands:
//   hubot kerb me - Get a list of KERB traders for the week ahead
//
// Dependencies:
//   cheerio
//   request
//
// Author:
//   Dawn Budge, then converted to JS by Rowan Manning

'use strict';

var cheerio = require('cheerio');
var request = require('request');

module.exports = kerb;
module.exports.getData = getKerbData;

function kerb (robot) {
	robot.respond(/\b(kerb|what'?s on kerb\??)\b/i, whatsOnKerb.bind(null, robot));
}

function whatsOnKerb (robot, response) {
	getKerbData(function (error, days) {
		if (error) {
			response.send('I couldn\'t get KERB data because of a stupid error. Look at the logs.');
			return console.error(error.stack);
		}
		var attachment = {
			message: {
				room: response.message.room
			},
			content: {
				fallback: '',
				title: 'KERB Traders for the week:',
				color: '#fff422',
				fields: [],
				mrkdwn_in: ['fields']
			}
		};
		days.forEach(function (day) {
			attachment.content.fallback += '*' + day.name + ':*\n';
			attachment.content.fields.push({
				title: day.name,
				value: day.traders.map(function (trader) {
					return trader.name + ': _' + trader.description + '_';
				}).join('\n') + '\n'
			});
		});
		attachment.content.fallback = attachment.content.fallback.trim();
		robot.emit('slack-attachment', attachment);
	});
}

function getKerbData (done) {
	request.get('http://www.kerbfood.com/kings-cross/', function (error, httpResponse, body) {
		if (error) {
			return done(error);
		}
		if (httpResponse.statusCode !== 200) {
			return done(new Error('HTTP Error ' + httpResponse.statusCode));
		}
		done(null, scrapeDataFromHtml(body));
	});
}

function scrapeDataFromHtml (html) {
	var $ = cheerio.load(html);
	return $('#rota .rota_panel > ul > li').map(function () {
		var $day = $(this);
		return {
			name: $day.attr('rel'),
			traders: getTraderDataForDay($, $day)
		};
	}).get();
}

function getTraderDataForDay ($, $day) {
	return $day.find('li').map(function () {
		var $trader = $(this);
		return {
			name: $trader.find('h4').text(),
			description: $trader.find('p').text(),
			url: 'http://www.kerbfood.com' + $trader.find('a').attr('href'),
			image: 'http://www.kerbfood.com' + $trader.find('img').attr('src')
		};
	}).get();
}
