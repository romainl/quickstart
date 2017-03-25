var test   = require('tape');
var sample = require('./../modules/sample');

test('sample', function (t) {
	t.equal(sample, 'foo', 'sample should be equal to foo');
	t.end();
});
