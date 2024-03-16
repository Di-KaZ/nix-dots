import Wayfire, { ActiveWorkspaceSet } from "ts/services/wayfire";
import Gtk from "types/@girs/gtk-3.0/gtk-3.0";

const MiniMap = (wset: ActiveWorkspaceSet) => {
	return Widget.Box({
		className: 'minimap',
		vertical: true,
		valign: Gtk.Align.CENTER,
		halign: Gtk.Align.CENTER,
		children: wset.bind('grid_height').transform(height => [...Array(height).keys()].map(y => {
			return Widget.Box({
				children: wset.bind('grid_width').transform(width => [...Array(width).keys()].map(x => {
					const current_id = wset.grid_width * y + x + 1;
					return Widget.Box({
						className: Wayfire.active.workspace_set.bind('active_index')
							.transform(active_index => active_index === current_id ? 'box active' : 'box'),
					});
				}),
				),
			});
		}),
		),
	});
}

export default () => Widget.Box({
	className: 'workspace',
	valign: Gtk.Align.CENTER,
	children: [
		Widget.Box().bind('child', Wayfire.active, 'workspace_set', wset => MiniMap(wset)),
		Widget.Box({ widthRequest: 5 }),
		Widget.Label({ className: 'index', label: Wayfire.active.workspace_set.bind('active_index').transform(active_index => active_index.toString()) }),
		Widget.Box({ widthRequest: 10 }),
		Widget.Label({ className: 'title', label: Wayfire.active.view.bind('title') }),
	],
});
