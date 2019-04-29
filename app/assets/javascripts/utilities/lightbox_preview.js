(function() {
    var LightBoxPreview,
        __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

    $(function() {
        return new LightBoxPreview();
    });

    LightBoxPreview = (function() {
        function LightBoxPreview() {
            this.initLightbox = __bind(this.initLightbox, this);
            this.initLightbox();
        }

        LightBoxPreview.prototype.initLightbox = function() {
            lightbox.option({
                resizeDuration: 200,
                wrapAround: true,
                albumLabel: ''
            });
            return lightbox.init();
        };

        return LightBoxPreview;

    })();

}).call(this);
