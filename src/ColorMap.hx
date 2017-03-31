class ColorMap {
    static function main() {
        js.Lib.require('dotenv').config();

        var express = js.Lib.require('express');
        var app = express();

        app.get('/', index);

        app.listen(3000, function () {
            trace('Example app listening on port 3000!');
        });
    }

    static function index(req, res) {
        var i = 0;

        var testdata = [
            { lat: -31.563910, lng: 147.154312 },
            { lat: -13.718234, lng: 150.363181 },
            { lat: -33.727111, lng: 150.371124 },
            { lat: -33.848588, lng: 151.209834 },
            { lat: -33.851702, lng: 151.216968 }
        ];

        var moods = [for(data in testdata)
            new Mood({
                id : Std.string(++i), 
                color : "FF00FF",
                lat : data.lat,
                lng : data.lng,
                created : Date.now()
            })
        ];

        var viewmoods = [for(mood in moods) haxe.Json.stringify({
            lat: mood.lat,
            lng: mood.lng,
            color: '#' + mood.color
        })];

        js.node.Fs.readFile('index.html', {encoding: 'utf-8'}, function(err, html) {
            var template = new haxe.Template(html);
            var output = template.execute({
                MOODS: viewmoods,
                KEY: Sys.getEnv('GOOGLE_API_KEY')
            });
            res.send(output);        
        });
    }
}