// Description:
//   Get approval
//
// Commands:
//   hubot approve of me - Get approval
//   hubot approve of <name> - Give someone approval

'use strict';

module.exports = robotRespond(/(approve|endorse)\b/i, [
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/984065.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/cena_whistling_gif.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/jack_nicholson_approve_gif.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_ll3oeqQXbe1qbvaudo1_500.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lq2f6qvNvL1qht847.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lq2f7zadIP1qht847.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lq2fc1GJ0h1qht847.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lq2ffcezuP1qht847.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lq2fgkZcMm1qht847.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lq4b4yIDcZ1qht847.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lrbil8nF2z1qht847.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_ltcxorUo1x1qm32ino1_250.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lwobmpkPmB1r6aoq4o1_400.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lwsb2bdpQ41qht847.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lxndkjUMFl1rn28qio1_500.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_lzdc6nNjNX1rp7jydo1_500.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_m106qgTIZS1r3zat8.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_m1e5h605dX1rqfhi2o1_500.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_m1ebx5RtET1qjdx0q.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_m1f4t7wzmS1r7032do1_500.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_m1q9pm31EM1rp7jydo1_250.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_m1s689mlfX1r4t9iz.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/tumblr_m1u6xxX9b31r7qh7w.gif',
	'http://clutch.mtv.com//wp-content/uploads/clutch/2012/04/ufc_approve_gif.gif',
	'http://i.imgur.com/Mrd5Apn.jpg',
	'http://i.imgur.com/MZtvuUW.jpg',
	'http://i.imgur.com/NfYkHBS.gif',
	'http://www.reactiongifs.com/r/ilt.gif',
	'http://www.reactiongifs.com/r/snoop.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2011/09/troll_approval.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2012/07/20120607035837_auto.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2012/08/well_done_sir.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2013/01/flaming_thumbs_up.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2013/03/Larry.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2013/03/thumbs-aloft.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2013/04/thumbs.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2013/07/needing-approval.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2013/08/barney-yes.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2013/08/kiss.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2013/09/thumbs-up.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2013/11/LOKI_approves.gif',
	'http://www.reactiongifs.com/wp-content/uploads/2014/01/thumbs_up_cat.gif',
	'https://camo.githubusercontent.com/11539938aed6a4c465396715e71ba6b69cc30286/687474703a2f2f7777772e7265616374696f6e676966732e636f6d2f722f776e6f642e676966'
]);
