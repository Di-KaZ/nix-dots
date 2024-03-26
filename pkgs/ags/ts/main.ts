import Battery from './widgets/battery'
import Clock from './widgets/clock';
import Network from './widgets/network';
import Tray from './widgets/tray';
import Gtk from 'types/@girs/gtk-3.0/gtk-3.0';
import Player from './widgets/player';
import VolumeIcon from './widgets/volume_icon';
import Brightness from './widgets/brightness';
import Workspaces from './widgets/workspaces';
import ScreeCorner from './widgets/screen_corner';

const input = `./style.scss`

// target css file
const output = `/tmp/ags/style.css`

try {
	const res = Utils.exec(`sass ${input}:${output} --style compressed`)

	console.log(res)

} catch (e) {
	logError(e)
}

const Bar = (monitor: number) => Widget.Window({
	name: `bar-${monitor}`,
	anchor: ['left', 'top', 'right'],
	exclusivity: "exclusive",
	margins: [
		10, // top
		200, // right
		20, // bottom
		200 // left
	],
	child: Widget.CenterBox({
		className: "bar",
		startWidget: Widget.Box({
			children: [
				Widget.Box({ widthRequest: 10 }),
				Workspaces()
			],
		}),
		centerWidget: Widget.Box({
			children: [
				Player()
			],
		}),
		endWidget: Widget.Box({
			className: "test",
			halign: Gtk.Align.END,
			valign: Gtk.Align.CENTER,
			children: [
				Clock(),
				Widget.Box({ widthRequest: 20 }),
				Network(),
				Widget.Box({ widthRequest: 20 }),
				Brightness(),
				Widget.Box({ widthRequest: 20 }),
				VolumeIcon(),
				Widget.Box({ widthRequest: 20 }),
				Battery(),
				Widget.Box({ widthRequest: 20 }),
				Tray(),
				Widget.Box({ widthRequest: 20 }),
			],
		}),
	}),
},)

App.config({
	style: output,
	windows: [Bar(0)]
})
