round_number = (num, precision=1) ->
    mul = 10 ** precision
    Math.round(num * mul) / mul

class Monitor
    constructor: (@x, @y, @diag, @dpi) ->
        @key = "#{@diag}@#{@x}x#{@y}(#{@dpi})"

    is_close: (mon, delta=5) ->
        Math.abs(@dpi - mon.dpi) < delta

    find_similar: ->
        m for m in @constructor.monitors when this.is_close m

    toString: ->
        "#{@diag}\" @ #{@x}x#{@y} (#{@dpi} DPI)"

    @create_monitor: (x, y, diag) ->
        dpi = round_number(Math.sqrt(x**2 + y**2) / diag)
        new Monitor x, y, diag, dpi

    @dpi_equals: (dpi1, dpi2, tolerance=0.02) ->
        Math.abs(dpi1 - dpi2) < tolerance

    @monitors: [
        new Monitor(1024, 768, 6.4, 200.0),
        new Monitor(1024, 768, 7.9, 162.0),
        new Monitor(1024, 768, 8.1, 158.0),
        new Monitor(1024, 768, 9.7, 132.0),
        new Monitor(1136, 640, 4, 326.0),
        new Monitor(1280, 600, 10, 141.4),
        new Monitor(1280, 720, 4.3, 341.5),
        new Monitor(1280, 720, 6.1, 240.8),
        new Monitor(1280, 768, 4.2, 355.4),
        new Monitor(1280, 800, 5.3, 284.8),
        new Monitor(1280, 800, 7, 215.6),
        new Monitor(1280, 800, 12.1, 124.7),
        new Monitor(1280, 800, 13.3, 113.5),
        new Monitor(1200, 825, 9.7, 150.1),
        new Monitor(1200, 900, 7.5, 200.0),
        new Monitor(1280, 1024, 0.61, 2687.2),
        new Monitor(1280, 1024, 17, 96.4),
        new Monitor(1334, 750, 4.5, 340.1),
        new Monitor(1360, 768, 11.1, 140.7),
        new Monitor(1366, 768, 11.6, 135.1),
        new Monitor(1366, 768, 15.6, 100.5),
        new Monitor(1400, 1050, 12, 145.8),
        new Monitor(1440, 900, 13.3, 127.7),
        new Monitor(1440, 900, 19, 89.4),
        new Monitor(1440, 960, 15.2, 113.9),
        new Monitor(1600, 768, 8, 221.8),
        new Monitor(1600, 900, 13.1, 140.1),
        new Monitor(1600, 900, 17.3, 106.1),
        new Monitor(1600, 1200, 19, 105.3),
        new Monitor(1600, 1200, 20.1, 99.5),
        new Monitor(1680, 945, 18.4, 104.8),
        new Monitor(1680, 1050, 15.4, 128.6),
        new Monitor(1680, 1050, 18, 110.1),
        new Monitor(1792, 768, 14.4, 135.4),
        new Monitor(1920, 1080, 0.74, 2976.9),
        new Monitor(1920, 1080, 4.7, 468.7),
        new Monitor(1920, 1080, 5, 440.6),
        new Monitor(1920, 1080, 5.5, 400.5),
        new Monitor(1920, 1080, 11.6, 189.9),
        new Monitor(1920, 1080, 21.5, 102.5),
        new Monitor(1920, 1152, 10.1, 221.7),
        new Monitor(1920, 1200, 7, 323.5),
        new Monitor(1920, 1200, 10.1, 224.2),
        new Monitor(1920, 1200, 15.4, 147.0),
        new Monitor(1920, 1200, 22, 102.9),
        new Monitor(1920, 1200, 24, 94.3),
        new Monitor(1920, 1920, 26.5, 102.5),
        new Monitor(2048, 1152, 23, 102.2),
        new Monitor(2048, 1536, 7.9, 324.1),
        new Monitor(2048, 1536, 9.7, 263.9),
        new Monitor(2048, 1536, 15, 170.7),
        new Monitor(2048, 1536, 20.8, 123.1),
        new Monitor(2560, 1440, 5.1, 575.9),
        new Monitor(2560, 1440, 5.5, 534.0),
        new Monitor(2560, 1440, 6, 489.5),
        new Monitor(2560, 1440, 11.6, 253.2),
        new Monitor(2560, 1440, 13.3, 220.8),
        new Monitor(2560, 1440, 27, 108.8),
        new Monitor(2560, 1536, 5.5, 542.8),
        new Monitor(2560, 1600, 6.1, 494.9),
        new Monitor(2560, 1600, 8.9, 339.2),
        new Monitor(2560, 1600, 10, 301.9),
        new Monitor(2560, 1600, 13.3, 227.0),
        new Monitor(2560, 1700, 12.85, 239.1),
        new Monitor(2560, 1600, 30, 100.6),
        new Monitor(2560, 2048, 20.1, 163.1),
        new Monitor(2880, 1620, 15.6, 211.8),
        new Monitor(2880, 1800, 15.4, 220.5),
        new Monitor(3200, 1800, 13.3, 276.1),
        new Monitor(3200, 1800, 14, 262.3),
        new Monitor(3200, 1800, 15.6, 235.4),
        new Monitor(3280, 2048, 30.4, 127.2),
        new Monitor(3440, 1440, 29, 128.6),
        new Monitor(3840, 2160, 15.6, 282.4),
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
