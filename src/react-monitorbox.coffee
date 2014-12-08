Monitor = require('./monitor')

# React.js should be linked from CDN before including this file
R = React.DOM

MonitorBox = React.createClass
    handleMonitorSubmit: (monitor) ->
        monitors = monitor.find_similar 12
        monitors.sort (a, b) ->
            return if a.diag >= b.diag then 1 else -1
        this.setState monitors:monitors, selected:monitor

    getInitialState: ->
        monitors: [],
        selected: null

    render: ->
        R.div className:"monitor-box",
            React.createElement MonitorForm, onMonitorSubmit:this.handleMonitorSubmit
            React.createElement MonitorSelection, monitor:@state.selected
            React.createElement MonitorList, monitors:@state.monitors

MonitorForm = React.createClass
    handleSubmit: (e) ->
        e.preventDefault()
        x = parseInt @refs.x.getDOMNode().value.trim()
        y = parseInt @refs.y.getDOMNode().value.trim()
        diag = parseFloat @refs.diag.getDOMNode().value.trim()

        m = Monitor.create_monitor x, y, diag
        @props.onMonitorSubmit m

    render: ->
        R.form className:"monitor-form", onSubmit:this.handleSubmit,
            R.input type:"number", placeholder:"Horizontal resolution",   required:"required", ref:"x", defaultValue:"2560"
            R.input type:"number", placeholder:"Vertical resolution",     required:"required", ref:"y", defaultValue:"1440"
            R.input type:"number", placeholder:"Diagonal size in inches", required:"required", ref:"diag", \
                    min:"10", max:"70", step:"0.5", defaultValue:"27"
            R.input type:"submit", value:"Search"


MonitorSelection = React.createClass
    render: ->
        R.div className:"selected-monitor",
            R.p(null, "Your monitor has a DPI of #{@props.monitor.spec.dpi}. The following monitors would be a good match for it!") if @props.monitor


MonitorList = React.createClass
    render: ->
        R.div className:"monitor-list",
            for monitor in @props.monitors
                React.createElement MonitorItem, monitor:monitor, key:monitor.key

MonitorItem = React.createClass
    render: ->
        R.div className:"monitor",
            R.div className:"image",
                R.img src:@props.monitor.img
            R.div className:"name",
                R.a href:@props.monitor.uri, @props.monitor.name
            R.div className:"spec", @props.monitor.toString()

# jquery needs to be present for this
if $('#content').length > 0
    React.render React.createElement(MonitorBox, null), $('#content')[0]
