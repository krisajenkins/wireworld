/* global Elm */

(function () {
    var startup = function () {
        // Start the Elm App.
        var app = Elm.App.fullscreen();
    };

    window.addEventListener('load', startup, false);
}());
