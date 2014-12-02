Monitor = require('./monitor')

# React.js should be linked from CDN before including this file
R = React.DOM

MonitorBox = React.createClass
    handleMonitorSubmit: (monitor) ->
        this.setState monitors:monitor.find_similar()

    getInitialState: ->
        monitors: []

    render: ->
        R.div className:"monitor-box",
            React.createElement MonitorForm, onMonitorSubmit:this.handleMonitorSubmit
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
            R.input type:"number", placeholder:"Horizontal resolution",   required:"required", ref:"x"
            R.input type:"number", placeholder:"Vertical resolution",     required:"required", ref:"y"
            R.input type:"number", placeholder:"Diagonal size in inches", required:"required", ref:"diag", \
                    min:"10", max:"70", step:"0.5", defaultValue:"19"
            R.input type:"submit", value:"Search"

MonitorList = React.createClass
    render: ->
        R.div className:"monitor-list",
            for monitor in @props.monitors
                React.createElement MonitorItem, monitorSpec:monitor.toString(), key:monitor.key

MonitorItem = React.createClass
    render: ->
        R.div className:"monitor",
            R.p className:"monitor-spec", @props.monitorSpec

# jquery needs to be present for this
if $('#content').length > 0
    React.render React.createElement(MonitorBox, null), $('#content')[0]
