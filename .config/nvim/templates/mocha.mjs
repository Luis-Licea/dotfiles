#!/usr/bin/env -S npx mocha
import { expect } from 'chai';
describe('Array', function() {
    describe('#indexOf()', function() {
        it('should return -1 when the value is not present', function() {
            expect([1, 2, 3].indexOf(4)).to.equal(-1);
        });
    });
    describe("Chai", function() {
        it('Variables equal', function() {
            var foo = 'bar';
            var beverages = { tea: ['chai', 'matcha', 'oolong'] };

            expect(foo).to.be.a('string');
            expect(foo).to.equal('bar');
            expect(foo).to.have.lengthOf(3);
            expect(beverages).to.have.property('tea').with.lengthOf(3);
        });
    });
});


