describe('Sample Testing', function () {
    before(function () {
        casper.start('http://localhost:3000');
    });
    it('should prove that 1 = 1', function () {
        casper.then(function () {
            return 1..should.equal(1);
        });
    });
    it('should prove that true = true', function () {
        casper.then(function () {
            return true.should.be["true"];
        });
    });
    it('should prove that false = false', function () {
        casper.then(function () {
            return false.should.be["false"];
        });
    });
});