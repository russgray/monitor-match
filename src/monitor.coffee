round_number = (num, precision=1) ->
    mul = 10 ** precision
    Math.round(num * mul) / mul


class MonitorSpec
    constructor: (@x, @y, @diag, @dpi=null) ->
        @dpi = round_number(Math.sqrt(@x**2 + @y**2) / @diag) if not @dpi
        @key = "#{@diag}@#{@x}x#{@y}(#{@dpi})"

    toString: ->
        "#{@diag}\" @ #{@x}x#{@y} (#{@dpi} DPI)"


class Monitor
    constructor: (@spec, @name='', @uri='', @img='') ->
        @key = @spec.key

    is_close: (mon, delta=5) ->
        Math.abs(@spec.dpi - mon.spec.dpi) < delta

    find_similar: (delta=5) ->
        m for m in @constructor.monitors when this.is_close m, delta

    toString: ->
        @spec.toString()

    @create_monitor: (x, y, diag, name='', uri='', img='') ->
        spec = new MonitorSpec x, y, diag
        new Monitor spec, name, uri, img

    @dpi_equals: (dpi1, dpi2, tolerance=0.02) ->
        Math.abs(dpi1 - dpi2) < tolerance

    # these are sorted by x-res for easy maintenance
    @monitors: [
        new Monitor(new MonitorSpec(1280, 1024, 19, null),
            'Samsung S19C450MR 19 inch LED Monitor'
            'http://www.amazon.co.uk/Samsung-S19C450MR-inch-LED-Monitor/dp/B00AT989UK/',
            'img/monitors/1280x1240x19.jpg'),
        new Monitor(new MonitorSpec(1440, 900, 19, 89.4),
            'Asus VE198S 19-inch Widescreen LED Multimedia Monitor',
            'http://www.amazon.co.uk/VE198S-19-inch-Widescreen-Multimedia-1440x900/dp/B00606MAR4/',
            'img/monitors/1440x900x19.jpg'),
        new Monitor(new MonitorSpec(1920, 1080, 21.5, 102.5),
            'BenQ GL2250HM LED TN Panel 21.5-inch W Multimedia Monitor',
            'http://www.amazon.co.uk/BenQ-GL2250HM-Multimedia-Monitor-Speakers/dp/B00B7ZE0G2/',
            'img/monitors/1920x1080x21.5.jpg'),
        new Monitor(new MonitorSpec(1920, 1080, 24, null),
            'BenQ GL2450HM LED TN 24-inch Widescreen Multimedia Monitor',
            'http://www.amazon.co.uk/BenQ-GL2450HM-Widescreen-Multimedia-speakers/dp/B005OPLG0O/',
            'img/monitors/1920x1080x24.jpg'),
        new Monitor(new MonitorSpec(1920, 1080, 27, null),
            'BenQ GL2250HM LED TN Panel 27-inch W Multimedia Monitor',
            'http://www.amazon.co.uk/BenQ-GL2760H-27-inch-Monitor-1920/dp/B00HZF2ME0/',
            'img/monitors/1920x1080x27.jpg'),
        new Monitor(new MonitorSpec(1920, 1200, 23, null),
            'Dell Ultrasharp U2312HM 23-inch IPS LED Monitor',
            'http://www.amazon.co.uk/Dell-Ultrasharp-U2312HM-inch-Monitor/dp/B005SNNCEA/',
            'img/monitors/1920x1280x23.jpg'),
        new Monitor(new MonitorSpec(1920, 1200, 24, 94.3)),
        new Monitor(new MonitorSpec(1920, 1920, 26.5, 102.5)),
        new Monitor(new MonitorSpec(2048, 1152, 23, 102.2)),
        new Monitor(new MonitorSpec(2048, 1536, 20.8, 123.1)),
        new Monitor(new MonitorSpec(2560, 1440, 27, 108.8)),
        new Monitor(new MonitorSpec(2560, 1600, 30, 100.6)),
        new Monitor(new MonitorSpec(2560, 2048, 20.1, 163.1)),
        new Monitor(new MonitorSpec(3280, 2048, 30.4, 127.2)),
        new Monitor(new MonitorSpec(3440, 1440, 29, 128.6)),
        new Monitor(new MonitorSpec(3840, 2160, 24, 183.6)),
        new Monitor(new MonitorSpec(3840, 2160, 28, 157.4)),
        new Monitor(new MonitorSpec(3840, 2160, 31.5, 139.9)),
        new Monitor(new MonitorSpec(3840, 2400, 22.2, 204.0)),
        new Monitor(new MonitorSpec(3840, 2560, 20, 230.8)),
        new Monitor(new MonitorSpec(4096, 2160, 31, 149.4)),
        new Monitor(new MonitorSpec(4096, 2160, 36.4, 127.2)),
        new Monitor(new MonitorSpec(5120, 2880, 27, 217.6)),
        new Monitor(new MonitorSpec(7680, 4320, 85, 103.7)),
        new Monitor(new MonitorSpec(7680, 4320, 145, 60.8))
    ]

module.exports = Monitor
