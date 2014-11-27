Monitor = require('./monitor')
React = require('react')
R = React.DOM

MonitorBox = React.createClass
    handleMonitorSubmit: (monitor) ->
        this.setState monitors:monitor.find_similar()

    getInitialState: ->
        monitors: []

    render: ->
        R.div className:"monitorBox",
            R.h1 null, 'Monitors'
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

        # @refs.x.getDOMNode().value = ''
        # @refs.y.getDOMNode().value = ''
        # @refs.diag.getDOMNode().value = ''

    render: ->
        R.form className:"monitorForm", onSubmit:this.handleSubmit,
            R.input type:"text", placeholder:"Horizontal resolution", ref:"x"
            R.input type:"text", placeholder:"Vertical resolution", ref:"y"
            R.input type:"text", placeholder:"Diagonal size in inches", ref:"diag"
            R.input type:"submit", value:"Search"

MonitorList = React.createClass
    render: ->
        R.div className:"monitorList",
            for monitor in @props.monitors
                React.createElement MonitorItem, monitorSpec:monitor.toString(), key:monitor.key

MonitorItem = React.createClass
    render: ->
        R.div className:"monitor",
            R.p className:"monitorSpec", @props.monitorSpec

React.render React.createElement(MonitorBox, null),
    document.getElementById 'content'
