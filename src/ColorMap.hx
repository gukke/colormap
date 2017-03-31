class ColorMap {
    static function main(){
        var mood = new Mood({
            id : "1", 
            color : "FF00FF",
            latitude : 12.5,
            longitude : 13.09,
            created : Date.now()
        });
        trace(mood);
    }
}