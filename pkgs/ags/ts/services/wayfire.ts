import GLib from 'gi://GLib';
import Gio from 'gi://Gio';

Gio._promisify(Gio.DataInputStream.prototype, 'read_upto_async');
const HIS = GLib.getenv('HYPRLAND_INSTANCE_SIGNATURE');

const socket = (path: string) => new Gio.SocketClient()
	.connect(new Gio.UnixSocketAddress({ path }), null);

export class Wayfire extends Service {
	static {
		Service.register(this, {}, {
		})
	}
}
