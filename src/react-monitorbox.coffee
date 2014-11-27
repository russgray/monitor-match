Monitor = require('./monitor')
React = require('react')
window.React = require('react')
R = React.DOM

MonitorBox = React.createClass
    render: ->
        R.div className:"monitorBox",
            R.h1 null, 'Monitors'
            React.createElement MonitorForm
            React.createElement MonitorList, monitors: @props.monitors

MonitorForm = React.createClass
    render: ->
        R.div className:"monitorForm",
            'I am a form'

MonitorList = React.createClass
    render: ->
        R.div className:"monitorList",
            for monitor in @props.monitors
                React.createElement MonitorItem, monitorSpec:monitor.toString(), key:monitor.key

MonitorItem = React.createClass
    render: ->
        R.div className:"monitor",
            R.p className:"monitorSpec", @props.monitorSpec

React.render React.createElement(MonitorBox, monitors:Monitor.monitors),
    document.getElementById 'content'
