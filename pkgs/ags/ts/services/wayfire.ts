import GLib from 'gi://GLib';
import Gio from 'gi://Gio';
import { View, WAYFIRE_EVENTS, WayfireEvent, WaylandIPCMessage, WorkspaceSet, jsonify } from './wayfire_types';

Gio._promisify(Gio.DataInputStream.prototype, 'read_bytes_async');

const SOCKET_PATH = GLib.getenv('WAYFIRE_SOCKET');

const socket = (path: string) => new Gio.SocketClient()
	.connect(new Gio.UnixSocketAddress({ path }), null);

interface Output {
	id: number;
	name: string;
	height: number;
	width: number;
	x: number;
	y: number;
	wset_index: number;
}

const toOutputs = (json: string): Array<Output> => {
	const tmp = JSON.parse(json) as Array<any>;
	console.log(tmp);

	return tmp.map(j => {
		return {
			id: j['id'],
			name: j['name'],
			height: j['geometry']['height'],
			width: j['geometry']['width'],
			x: j['geometry']['x'],
			y: j['geometry']['y'],
			wset_index: j['wset-index'],
		} as Output
	})
}

export class ActiveWorkspaceSet extends Service {

	static {
		Service.register(this, {}, {
			'id': ['int'],
			'output_id': ['int'],
			'active_x': ['int'],
			'active_y': ['int'],
			'active_index': ['int'],
			'grid_width': ['int'],
			'grid_height': ['int'],
		});
	}

	private _id = 0;
	private _output_id = 0;
	private _active_x = 0;
	private _active_y = 0;
	private _active_index = 0;
	private _grid_width = 0;
	private _grid_height = 0;

	get id() { return this._id; }
	get output_id() { return this._output_id }
	get active_x() { return this._active_x; }
	get active_y() { return this._active_y; }
	get active_index() { return this._active_index; }
	get grid_width() { return this._grid_width; }
	get grid_height() { return this._grid_height; }
}

export class ActiveView extends Service {
	static {
		Service.register(this, {}, {
			'id': ['int'],
			'title': ['string'],
		});
	}

	private _title = '';
	private _id = 0;

	get id() { return this._id; }
	get title() { return this._title; }

	update(id: number, title: string) {
		super.updateProperty('id', id);
		super.updateProperty('title', title);
	}
}

export class ActiveOutput extends Service {
	static {
		Service.register(this, {}, {
			'name': ['string'],
		});
	}

	private _name = '';
	private _id = 0;

	get id() { return this._id; }
	get name() { return this._name; }

	update(id: number, name: string) {
		super.updateProperty('id', id);
		super.updateProperty('name', name);
	}
}


export class Actives extends Service {
	static {
		Service.register(this, {}, {
			'view': ['jsobject'],
			'output': ['jsobject'],
			'workspace_set': ['jsobject'],
		});
	}

	private _view = new ActiveView;
	private _output = new ActiveOutput;
	private _workspace_set = new ActiveWorkspaceSet;

	constructor() {
		super();

		(['view', 'workspace_set', 'output'] as const).forEach(obj => {
			this[`_${obj}`].connect('changed', () => {
				this.notify(obj);
				this.emit('changed');
			});
		});
	}

	get view() { return this._view; }
	get output() { return this._output; }
	get workspace_set() { return this._workspace_set; }
}

export class Wayfire extends Service {
	static {
		Service.register(this, {
			'event': ['string', 'string'],
			'output-added': ['int'],
			'output-removed': ['int'],
			'workspace-set-added': ['int'],
			'workspace-set-removed': ['int'],
			'view-added': ['int'],
			'view-removed': ['int'],
		}, {
			'workspaces_sets': ['jsobject'],
			'outputs': ['jsobject'],
			'views': ['jsobject'],
		})
	}

	private _encoder = new TextEncoder();
	private _decoder = new TextDecoder();

	private _active = new Actives();
	private _workspace_sets: { [key: number]: WorkspaceSet } = {};
	private _outputs: { [key: number]: Output } = {};
	private _views: { [key: number]: View } = {};

	get active() { return this._active }
	get workspaces() { return Array.from(Object.values(this._workspace_sets)); }
	get outputs() { return Array.from(Object.values(this._outputs)); }
	get views() { return Array.from(Object.values(this._views)); }

	readonly getOutput = (id: number) => this._outputs[id];
	readonly getWorkspaceSet = (name: string) => this._workspace_sets[name];
	readonly getView = (id: number) => this._views[id];

	constructor() {
		if (SOCKET_PATH === null) {
			throw new Error('Wayfire is not runing')
		}

		super();

		this._syncWorkspaceSets({ inital: true });
		this._syncOutputs({ initial: true });
		this._syncViews({ initial: true });
		this._watchSocket();

		this._active.connect('changed', () => this.changed('active'));
	}

	_payload(payload: WaylandIPCMessage): string { return JSON.stringify(payload) }

	private async _watchSocket() {
		const payload = this._payload({
			method: 'window-rules/events/watch',
			data: {
				events: WAYFIRE_EVENTS,
			},
		});

		const { stream } = this._socketStream(payload)

		while (true) {
			try {
				const response = await this.responseAsync(stream);

				const json = jsonify<any>(response);

				const triggered_event: WayfireEvent | undefined = json?.event;

				switch (triggered_event) {
					case "view-mapped":
						this._syncViews({ notify: true });
						this.emit('view-added', json.view.id.toString())
						break;
					case "view-unmapped":
						this._syncViews({ notify: true });
						this.emit('view-removed', json.view.id.toString())
						break;
					case "output-added":
						this._syncOutputs({ notify: true });
						this.emit('output-added', json.output.id.toString())
						break;
					case "output-removed":
						this._syncOutputs({ notify: true });
						this.emit('output-removed', json.output.id.toString())
						break;
					case "wset-workspace-changed":
						await this._syncWorkspaceSets({ notify: true });
						this._active.workspace_set.updateProperty('active_x', json.new_workspace.x);
						this._active.workspace_set.updateProperty('active_y', json.new_workspace.y);
						this._active.workspace_set.updateProperty(
							'active_index',
							this.active.workspace_set.grid_width *
							this.active.workspace_set.active_y +
							this.active.workspace_set.active_x + 1
						);
						break;
					case "output-wset-changed":
						// TODO: trigger it to see what it does
						this._syncWorkspaceSets({ notify: true });
						break;
				}
				if (triggered_event) {
					this.emit('event', triggered_event, response);
					this.emit('changed');
				}
			} catch (e) {
				logError(e)
			}
		}
	}

	private _socketStream(cmd: string) {
		const connection = socket(SOCKET_PATH!);

		// send payload size header
		const payload_header = new DataView(new ArrayBuffer(4));
		payload_header.setUint32(0, cmd.length, true);
		const output = connection.get_output_stream()

		// write header and payload
		output.write(new Uint8Array(payload_header.buffer), null);
		output.write(this._encoder.encode(cmd), null);

		const stream = new Gio.DataInputStream({
			close_base_stream: true,
			base_stream: connection.get_input_stream(),
		});

		return { connection, stream } as const;
	}

	readonly message = (cmd: string) => {
		const { connection, stream } = this._socketStream(cmd);
		try {
			// reading response
			return this.response(stream);
		} catch (error: any) {
			logError(error);
			return '';
		} finally {
			connection.close(null);
		}
	}

	readonly messageAsync = async (cmd: string) => {
		const { connection, stream } = this._socketStream(cmd);
		try {
			// reading response
			return await this.responseAsync(stream);
		} catch (error: any) {
			logError(error);
			return ''
		} finally {
			connection.close(null);
		}
	}

	readonly response = (stream: Gio.DataInputStream) => {
		// reading response
		const response_header = new DataView(stream.read_bytes(4, null)
			.toArray().buffer).getInt32(0, true);
		return this._decoder.decode(stream.read_bytes(response_header, null).toArray());
	}

	readonly responseAsync = async (stream: Gio.DataInputStream) => {
		// reading response
		const response_header = new DataView((await stream.read_bytes_async(4, -1, null))
			.toArray().buffer).getInt32(0, true);
		const response = this._decoder.decode((await stream.read_bytes_async(response_header, -1, null)).toArray());
		return response;
	}

	private async _syncWorkspaceSets({ inital = false, notify = true }) {
		try {
			const payload = this._payload({ method: 'window-rules/list-wsets', data: {} });

			const wsets = jsonify<Array<WorkspaceSet>>(inital ? this.message(payload) : await this.messageAsync(payload))

			this._workspace_sets = {};

			for (const wset of wsets) {
				this._workspace_sets[wset.index] = wset;
				if (this._active.workspace_set.output_id === wset.output_id || inital) {
					this._active.workspace_set.updateProperty('output_id', wset.output_id)
					this._active.workspace_set.updateProperty('grid_width', wset.workspace.grid_width)
					this._active.workspace_set.updateProperty('grid_height', wset.workspace.grid_height)
				}
				if (inital) {
					this._active.workspace_set.updateProperty(
						'active_index',
						wset.workspace.grid_width *
						wset.workspace.y +
						wset.workspace.x + 1
					);
				}
			}
			if (notify) this.notify('workspaces_sets');
		} catch (e) { logError(e); }
	}

	private async _syncOutputs({ initial = false, notify = true }) {
		try {
			const payload = this._payload({ method: 'window-rules/list-outputs', data: {} });

			const outputs = toOutputs(initial ? this.message(payload) : await this.messageAsync(payload));

			this._outputs = [];

			for (const output of outputs) {
				this._outputs[output.id] = output;
				// TODO: find a way to handle this
				// this._active.output.update(output.id, output.name);
			}

			if (notify)
				this.notify('outputs');

		} catch (e) {
			logError(e);
		}
	}

	private async _syncViews({ initial = false, notify = true }) {
		try {
			const payload = this._payload({ method: 'window-rules/list-views', data: {} });

			const views = jsonify<Array<View>>(initial ? this.message(payload) : await this.messageAsync(payload))
			console.log(views);

			this._views = {};

			for (const view of views) {
				this._views[view.id] = view;
				if (view.activated) {
					this._active.view.update(view.id, view.title);
				}
			}

			if (notify) this.notify('views');
		} catch (e) {
			logError(e);
		}
	}
}

export default new Wayfire;
