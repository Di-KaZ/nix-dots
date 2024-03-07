import Gtk from "types/@girs/gtk-3.0/gtk-3.0";

export default () => Widget.Box({
	className: "clock",
	valign: Gtk.Align.END,
	children: [
		Widget.Label().poll(1000, self => self.label = Utils.exec('date +%H:%M')),
		Widget.Label({
			className: "separator",
			label: '//'
		}),
		Widget.Label().poll(1000, self => self.label = Utils.exec('date "+%B %d"')),
	]
});




