import Systemtray from 'resource:///com/github/Aylur/ags/service/systemtray.js'
import Gtk from 'types/@girs/gtk-3.0/gtk-3.0';
import { TrayItem } from 'types/service/systemtray';

const SysTrayItem = (item: TrayItem) => Widget.Button({
	className: "button",
	child: Widget.Icon().bind('icon', item, 'icon'),
	tooltipMarkup: item.bind('tooltip_markup'),
	onPrimaryClick: (_, event) => item.activate(event),
	onSecondaryClick: (_, event) => item.openMenu(event),
});

export default () => {
	const items = Systemtray.bind('items').as(i => i.map(SysTrayItem));
	return Widget.Box({
		valign: Gtk.Align.CENTER,
		className: "tray",
		children: items,
	});
}
