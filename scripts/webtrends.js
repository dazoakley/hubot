// description:
//     Webtreds command for getting basic user technology stats
//
// Commands:
//     hubot webtrends browsers - Gets the top 10 browsers for the last 3 months
//     hubot webtrends mobile browsers - Gets the top 10 mobile browsers for the last 3 months
//     hubot webtrends ie versions - Gets the top 5 Internet Explorer versions for the last 3 months
//
// Dependencies:
//     request
//
// Author:
//     Glynn Phillips


// jshint maxcomplexity: false, maxstatements: false, maxdepth: false
'use strict';

var request = require('request');

var types = {
	browsers: {
		url: 'https://ws.webtrends.com/v3/Reporting/profiles/17730/reports/95df19b6d9f/?totals=all&start_period=current_month-3&end_period=current_month&period_type=agg&measures=0&sortby=Visits&format=json',
		limit: 10,
		title: 'Top 10 browsers in the last 3 months'
	},
	mobileBrowsers: {
		url: 'https://ws.webtrends.com/v3/Reporting/profiles/17730/reports/yldOxrHP0P6/?totals=all&start_period=current_month-3&end_period=current_month&period_type=agg&measures=0&sortby=Visits&format=json',
		limit: 10,
		title: 'Top 10 mobile browsers in the last 3 months'
	},
	ieVersions: {
		url: 'https://ws.webtrends.com/v3/Reporting/profiles/17730/reports/95df19b6d9e/?totals=all&start_period=current_month-3&end_period=current_month&period_type=agg&format=json',
		limit: 5,
		title: 'Top 5 Internet Explorer versions in the last 3 months'
	}
};

module.exports = webtrends;
module.exports.getData = getWebtrendsData;

function webtrends (robot) {
	robot.respond(/\b(webtrends browsers)\b/i, topBrowsers.bind(null, robot, 'browsers'));
	robot.respond(/\b(webtrends mobile browsers)\b/i, topBrowsers.bind(null, robot, 'mobileBrowsers'));
	robot.respond(/\b(webtrends ie versions)\b/i, topBrowsers.bind(null, robot, 'ieVersions'));
}

function topBrowsers (robot, type, response) {
	getWebtrendsData(type, function (error, browsers) {
		if (error) {
			response.send('I couldn\'t get Webtrends data because of a stupid error. Look at the logs.');
			return console.error(error.stack);
		}
		var attachment = {
			message: {
				room: response.message.room
			},
			content: {
				fallback: '',
				title: types[type].title,
				color: '#fff422',
				fields: [],
				mrkdwn_in: ['fields']
			}
		};

		browsers.forEach(function (browser) {
			attachment.content.fields.push({
				title: browser.name + ' (' + browser.percent + '%)',
				value: formatNumber(browser.visits) + ' visits'
			});
		});
		robot.emit('slack-attachment', attachment);
	});
}

function getWebtrendsData (type, done) {
	request.get(types[type].url, {
		auth: {
			user: process.env.WT_USER,
			pass: process.env.WT_PASS
		}
	}, function (error, httpResponse, body) {
		if (error) {
			return done(error);
		}
		if (httpResponse.statusCode !== 200) {
			return done(new Error('HTTP Error ' + httpResponse.statusCode));
		}
		done(null, scrapeDataFromJson(body, type));
	});
}

function scrapeDataFromJson (json, type) {
	json = JSON.parse(json);

	var data = json.data[0].SubRows;
	var	total = json.data[0].measures.Visits;
	var browsers = [];

	for (var key in data) {
		if (data.hasOwnProperty(key)) {
			var obj = data[key];
			for (var prop in obj) {
				if (obj.hasOwnProperty(prop)) {
					if (type !== 'ieVersions') {
						browsers.push({
							name: prop,
							visits: obj[prop].measures.Visits,
							percent: getPercent(total, obj[prop].measures.Visits)
						});
					}
					else {
						if (prop.toLowerCase().indexOf('internet explorer') > -1) {
							var ieObj = obj[prop].SubRows;
							for (var ieProp in ieObj) {
								if (ieObj.hasOwnProperty(ieProp)) {

									var arrayPos = browsers.map(function (x) {
										return x.name;
									}).indexOf('IE ' + ieProp.substring(0, ieProp.indexOf('.')));

									if (arrayPos < 0) {
										browsers.push({
											name: 'IE ' + ieProp.substring(0, ieProp.indexOf('.')),
											visits: ieObj[ieProp].measures.Visits,
											percent: getPercent(total, obj[prop].measures.Visits)
										});
									}
									else {
										browsers[arrayPos].visits = browsers[arrayPos].visits + ieObj[ieProp].measures.Visits;
										browsers[arrayPos].percent = getPercent(total,	browsers[arrayPos].visits);
									}
								}
							}
						}
					}
				}
			}
		}
	}

	browsers.sort(function (a, b) {
		return parseFloat(a.visits) - parseFloat(b.visits);
	}).reverse().length = types[type].limit;

	return browsers;
}


function getPercent (totalVisits, browserVisits) {
	return (browserVisits / totalVisits * 100).toFixed(2);
}

function formatNumber (number) {
	return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
