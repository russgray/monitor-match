monitor = require '../src/monitor.coffee'
uniq    = require 'array-uniq'
dump    = require 'stringify-object'
fs      = require 'fs'


describe 'A monitor', ->

    it 'considers dpi equal within tolerance ', ->
        expect(monitor.dpi_equals 108.79, 108.8, 0.02).toBe true

    it 'considers dpi unequal if exceeds tolerance', ->
        expect(monitor.dpi_equals 106.0, 108.8, 0.02).toBe false

    it 'compares similar monitors', ->
        m1 = monitor.create_monitor 2560, 1440, 27
        m2 = monitor.create_monitor 1600, 1200, 19
        expect(m1.is_close m2).toBe true

    it 'finds similar monitors', ->
        m = monitor.create_monitor 2560, 1440, 27
        similar = m.find_similar(10)
        expect(similar.length).toBeGreaterThan(1)

    it 'creates a sensible default img name', ->
        m = monitor.create_monitor 2560, 1440, 27
        expect(m.img).toEqual('img/monitors/2560x1440x27.jpg')

    describe 'thumbnail', ->
        for m in monitor.monitors
            do (m) ->
                p = 'assets/' + m.img
                describe 'for monitor ' + m.key, ->
                    it 'should be at path ' + p, ->
                        expect(fs.existsSync('assets/' + m.img)).toBe(true)

    describe 'factory', ->
        # it 'creates monitors with correct dpi', ->
        #     for m in monitor.monitors
        #         do (m) ->
        #             m1 = monitor.create_monitor m.spec.x, m.spec.y, m.spec.diag
        #             expect(monitor.dpi_equals m.spec.dpi, m1.spec.dpi).toBe(true)

        it 'has unique default monitors', ->
            keys = (m.key for m in monitor.monitors)
            # console.log dump(keys)
            expect(keys.length).toEqual(uniq(keys).length)
