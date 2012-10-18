describe("CSS Helper", function() {

    var elem = null;

    beforeEach(function() {
        elem = document.createElement("input");
        elem.id = "test";
        elem.className = "coffee hello";

    });

    afterEach(function() {
        elem = null;
    });

    it("should find class on element", function() {
        expect(CSS.hasClass(elem, "test")).toBeTruthy();
        expect(CSS.hasClass(elem, "hello")).toBeTruthy();
    });

    it("should add a class", function() {
        CSS.addClass(elem, "hello2");
        expect(CSS.hasClass(elem, "hello2")).toBeTruthy();
    });

    it("should add a style", function() {
        CSS.add(elem, { width: '100px' });
        expect(elem.style.width).toBe('100px');
    });

    it("should add an opacity style and filter to IE", function() {
        elem = {
            style: {
                opacity: 0.5
            },
            filters: ""
        };

        CSS.add(elem, { opacity: 0.5 });
        expect(elem.style.opacity).toBe(0.5);
        expect(elem.style.filter).toContain("alpha");
    });

    it("should remove a class", function() {
        CSS.removeClass(elem, "hello");
        expect(CSS.hasClass(elem, "hello")).toBeFalsy();
    });

});



describe("Event Helper", function() {

    it("should attach a click event", function() {
        var foo = {
            testAlert: function(){}
        };

        spyOn(foo, 'testAlert');

        var input = $('<input id="coffee" type="button" />');
        $('body').append(input);

        Events.attach(input[0], 'click', foo.testAlert);

        $('#test').click();

        expect(foo.testAlert).toHaveBeenCalled();
    });
});