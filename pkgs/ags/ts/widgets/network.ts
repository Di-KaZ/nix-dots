import Network from 'resource:///com/github/Aylur/ags/service/network.js';
import Gtk from 'types/@girs/gtk-3.0/gtk-3.0';

const WifiIndicator = () => Widget.Box({
	valign: Gtk.Align.END,
	children: [
		Widget.Icon({
			icon: Network.wifi.bind('icon_name'),
		}),
		// Widget.Box({ widthRequest: 5 }),
		// Widget.Label({
		// 	label: Network.wifi.bind('ssid')
		// 		.as(ssid => ssid || 'Unknown').transform(v => v.toLowerCase()),
		// }),
	],
})

const WiredIndicator = () => Widget.Icon({
	icon: Network.wired.bind('icon_name'),
})

export default () => Widget.Stack({
	children: {
		'wifi': WifiIndicator(),
		'wired': WiredIndicator(),
	},
	shown: Network.bind('primary').as(p => p || 'wifi'),
})
