const Bar = (monitor: number) => Widget.Window({
	name: `bar-${monitor}`,
	child: Widget.Label('hello'),
})

export default {
	windows: [Bar(0)]
}
