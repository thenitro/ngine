package ngine.utils {
    import starling.utils.formatString;

    [Inline]
    public function formatTime(pHours:int, pMinutes:int, pSeconds:int):String {
        const ZERO:String    = '0';
        const PATTERN:String = '{0}:{1}:{2}';

        var hours:String   = pHours > 9 ? pHours.toString() : '0' + pHours;
        var minutes:String = pMinutes > 9 ? pMinutes.toString() : '0' + pMinutes;
        var seconds:String = pSeconds > 9 ? pSeconds.toString() : '0' + pSeconds;

        return formatString(PATTERN, hours, minutes, seconds);
    }
}
