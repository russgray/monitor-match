monitor = require('../src/monitor.coffee')
uniq    = require('array-uniq')
dump    = require('stringify-object')

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

    describe 'factory', ->
        it 'creates monitors with correct dpi', ->
            for m in monitor.monitors
                do (m) ->
                    m1 = monitor.create_monitor m.x, m.y, m.diag
                    expect monitor.dpi_equals m.dpi, m1.dpi

        it 'has unique default monitors', ->
            keys = (m.key for m in monitor.monitors)
            # console.log dump(keys)
            expect(keys.length).toEqual(uniq(keys).length)
