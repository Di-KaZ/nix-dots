export const WAYFIRE_EVENTS = [
	"view-mapped",
	"view-unmapped",
	"output-added",
	"output-removed",
	"wset-workspace-changed",
	"output-wset-changed",
] as const;

export type WayfireEvent = typeof WAYFIRE_EVENTS[number];

export interface WaylandIPCMessage {
	method: string;
	data: { [key: string]: any };
}

interface _Geometry {
	height: number;
	width: number;
	x: number;
	y: number;
}

export interface View {
	activated: boolean;
	app_id: string;
	base_geometry: _Geometry;
	bbox: _Geometry;
	focusable: boolean;
	fullscreen: boolean;
	geometry: _Geometry;
	id: number;
	last_focus_timestamp: number;
	layer: string;
	mapped: boolean;
	minimized: boolean;
	output_id: number;
	output_name: string;
	parent: number;
	pid: number;
	role: string;
	sticky: boolean;
	wset_index: number;
}

interface _Grid {
	grid_height: number;
	grid_width: number;
	x: number;
	y: number;
}

export interface WorkspaceSet {
	index: number;
	name: string;
	output_id: number;
	output_name: string;
	workspace: _Grid;
}

export const jsonify = <T>(json: string): T => {
	const obj = JSON.parse(json);
	if (Array.isArray(obj)) {
		return obj.map(o => Object.fromEntries(
			Object.entries(o).map(([k, v]) => [k.replaceAll('-', '_'), v])
		)) as T;
	}
	return Object.fromEntries(
		Object.entries(obj).map(([k, v]) => [k.replaceAll('-', '_'), v])
	) as T;
};
