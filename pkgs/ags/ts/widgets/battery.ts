import Battery from 'resource:///com/github/Aylur/ags/service/battery.js'
import Gtk from 'types/@girs/gtk-3.0/gtk-3.0';

export default () => Widget.Box({
	children: [
		Widget.Icon({
			icon: Battery.bind('icon_name')
		}),
		// Widget.ProgressBar({
		// 	className: clsx(""),
		// 	valign: Gtk.Align.CENTER,
		// 	value: Battery.bind('percent').as(p => p > 0 ? p / 100 : 0),
		// }),
	]
});

