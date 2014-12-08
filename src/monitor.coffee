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
        @img = "img/monitors/#{@spec.x}x#{@spec.y}x#{@spec.diag}.jpg" if not @img
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

    # keep these sorted for easy maintenance
    @monitors: [
        new Monitor(new MonitorSpec(1280, 1024, 19),
            'Samsung S19C450MR 19-inch LED Monitor'
            'http://www.amazon.co.uk/Samsung-S19C450MR-inch-LED-Monitor/dp/B00AT989UK/'),
        new Monitor(new MonitorSpec(1440, 900, 19, 89.4),
            'Asus VE198S 19-inch Widescreen LED Multimedia Monitor',
            'http://www.amazon.co.uk/VE198S-19-inch-Widescreen-Multimedia-1440x900/dp/B00606MAR4/'),

        # 1080p monitors
        new Monitor(new MonitorSpec(1920, 1080, 21.5),
            'BenQ GL2250HM LED TN Panel 21.5-inch W Multimedia Monitor',
            'http://www.amazon.co.uk/BenQ-GL2250HM-Multimedia-Monitor-Speakers/dp/B00B7ZE0G2/'),
        new Monitor(new MonitorSpec(1920, 1080, 23),
            'Asus MX239H 23-inch IPS HD LED-backlit LCD Monitor',
            'http://www.amazon.co.uk/Asus-MX239H-LED-backlit-Monitor-80000000/dp/B00A4K9KVG/'),
        new Monitor(new MonitorSpec(1920, 1080, 23.6),
            'Samsung S24D390HL PLS 23.6-inch LED HDMI Monitor',
            'http://www.amazon.co.uk/Samsung-S24D390HL-23-6-inch-Monitor/dp/B00IJS6OUA/'),
        new Monitor(new MonitorSpec(1920, 1080, 23.8),
            'Dell UltraSharp U2414H 23.8-inch Widescreen IPS LCD Monitor',
            'http://www.amazon.co.uk/Dell-UltraSharp-U2414H-Widescreen-Monitor/dp/B00H3JIGHA/'),
        new Monitor(new MonitorSpec(1920, 1080, 24),
            'BenQ GL2450HM LED TN 24-inch Widescreen Multimedia Monitor',
            'http://www.amazon.co.uk/BenQ-GL2450HM-Widescreen-Multimedia-speakers/dp/B005OPLG0O/'),
        new Monitor(new MonitorSpec(1920, 1080, 27),
            'BenQ GL2250HM LED TN Panel 27-inch W Multimedia Monitor',
            'http://www.amazon.co.uk/BenQ-GL2760H-27-inch-Monitor-1920/dp/B00HZF2ME0/'),

        # Larger sizes
        new Monitor(new MonitorSpec(1920, 1200, 23),
            'Dell Ultrasharp U2312HM 23-inch IPS LED Monitor',
            'http://www.amazon.co.uk/Dell-Ultrasharp-U2312HM-inch-Monitor/dp/B005SNNCEA/'),
        new Monitor(new MonitorSpec(1920, 1200, 24),
            'Dell UltraSharp U2415 24-inch IPS 1920x1200 (16:10) 860-BBEY',
            'http://www.amazon.co.uk/Dell-UltraSharp-U2415-Inch-1920x1200/dp/B00O9ZGI58/'),
        new Monitor(new MonitorSpec(2560, 1080, 29),
            'Dell U2913WM 29-inch Widescreen LED Monitor',
            'http://www.amazon.co.uk/Dell-U2913WM-Widescreen-2560x1080-DisplayPort/dp/B00ADHLSMO/'),
        new Monitor(new MonitorSpec(2560, 1080, 34),
            'LG 34UM65-P 34-inch IPS LED Monitor',
            'http://www.amazon.co.uk/LG-34UM65-P-Inch-IPS-Monitor/dp/B00IKFH3K2/'),
        new Monitor(new MonitorSpec(2560, 1440, 27),
            'BenQ GW2765HT LED IPS 27-inch W Monitor',
            'http://www.amazon.co.uk/BenQ-GW2765HT-LED--inch-Monitor/dp/B00M913DVG/'),
        new Monitor(new MonitorSpec(2560, 1440, 32),
            'BenQ BL3200PT AMVA+ 32-inch Monitor',
            'http://www.amazon.co.uk/BenQ-BL3200PT-AMVA-32-inch-Monitor/dp/B00JIWLNHU/'),
        new Monitor(new MonitorSpec(3440, 1440, 34),
            'LG 34UM95 34-inch Ultrawide QHD IPS Monitor',
            'http://www.amazon.co.uk/LG-34UM95-inch-Ultrawide-Monitor/dp/B00JXD6DL0/'),

        # 4K monitors
        new Monitor(new MonitorSpec(3840, 2160, 28),
            'Dell P2815Q 28 inch Ultra HD 4K LED Monitor',
            'http://www.amazon.co.uk/Dell-P2815Q-inch-Ultra-Monitor/dp/B00IOUBOB2/'),

        # new Monitor(new MonitorSpec(3840, 2400, 22.2, 204.0)),
        # new Monitor(new MonitorSpec(3840, 2560, 20, 230.8)),
        # new Monitor(new MonitorSpec(4096, 2160, 31, 149.4)),
        # new Monitor(new MonitorSpec(4096, 2160, 36.4, 127.2)),
        # new Monitor(new MonitorSpec(5120, 2880, 27, 217.6)),
        # new Monitor(new MonitorSpec(7680, 4320, 85, 103.7)),
        # new Monitor(new MonitorSpec(7680, 4320, 145, 60.8))
    ]

module.exports = Monitor
