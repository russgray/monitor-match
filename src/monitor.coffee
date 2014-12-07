round_number = (num, precision=1) ->
    mul = 10 ** precision
    Math.round(num * mul) / mul

class Monitor
    constructor: (@x, @y, @diag, @dpi, @name='', @uri='', @img='') ->
        @key = "#{@diag}@#{@x}x#{@y}(#{@dpi})"
        console.log @img if @uri

    is_close: (mon, delta=5) ->
        Math.abs(@dpi - mon.dpi) < delta

    find_similar: (delta=5) ->
        m for m in @constructor.monitors when this.is_close m, delta

    toString: ->
        "#{@diag}\" @ #{@x}x#{@y} (#{@dpi} DPI)"

    @create_monitor: (x, y, diag, name='', uri='', img='') ->
        dpi = round_number(Math.sqrt(x**2 + y**2) / diag)
        new Monitor x, y, diag, dpi, name, uri, img

    @dpi_equals: (dpi1, dpi2, tolerance=0.02) ->
        Math.abs(dpi1 - dpi2) < tolerance

    @monitors: [
        new Monitor(1280, 1024, 17, 96.4),
        new Monitor(1440, 900, 19, 89.4),
        new Monitor(1920, 1080, 21.5, 102.5, 'BenQ GL2250HM LED TN Panel 21.5-inch W Multimedia Monitor 1920 x 1080', 'http://www.amazon.co.uk/BenQ-GL2250HM-Multimedia-Monitor-Speakers/dp/B00B7ZE0G2/', 'img/monitors/1920x1080x21.5.jpg'),
        new Monitor(1920, 1200, 22, 102.9),
        Monitor.create_monitor(1920, 1200, 23, 'Dell Ultrasharp U2312HM 23-inch IPS LED Monitor 1920 x 1200', 'http://www.amazon.co.uk/Dell-Ultrasharp-U2312HM-inch-Monitor/dp/B005SNNCEA/', 'img/monitors/1920x1280x23.jpg'),
        new Monitor(1920, 1200, 24, 94.3),
        new Monitor(1920, 1920, 26.5, 102.5),
        new Monitor(2048, 1152, 23, 102.2),
        new Monitor(2048, 1536, 20.8, 123.1),
        new Monitor(2560, 1440, 27, 108.8),
        new Monitor(2560, 1600, 30, 100.6),
        new Monitor(2560, 2048, 20.1, 163.1),
        new Monitor(3280, 2048, 30.4, 127.2),
        new Monitor(3440, 1440, 29, 128.6),
        new Monitor(3840, 2160, 24, 183.6),
        new Monitor(3840, 2160, 28, 157.4),
        new Monitor(3840, 2160, 31.5, 139.9),
        new Monitor(3840, 2400, 22.2, 204.0),
        new Monitor(3840, 2560, 20, 230.8),
        new Monitor(4096, 2160, 31, 149.4),
        new Monitor(4096, 2160, 36.4, 127.2),
        new Monitor(5120, 2880, 27, 217.6),
        new Monitor(7680, 4320, 85, 103.7),
        new Monitor(7680, 4320, 145, 60.8)
    ]

module.exports = Monitor
