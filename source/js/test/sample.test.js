import test from 'tape';
import sample from '../modules/sample';

test('sample', function (t) {
	t.equal(sample, 'foo', 'sample should be equal to foo');
	t.end();
});
