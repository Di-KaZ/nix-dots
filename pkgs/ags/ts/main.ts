import Gio from 'gi://Gio';

const socket = (path: string) => new Gio.SocketClient()
	.connect(new Gio.UnixSocketAddress({ path }), null);

// const s = socket('/tmp/wayfire-wayland-1.socket');
//
// const stream = new Gio.DataInputStream({
// 	close_base_stream: true,
// 	base_stream: s.get_input_stream(),
// })
//
// stream.read_line_async(0, null, (stream, result) => {
// 	if (!stream)
// 		return console.error('Error reading Hyprland socket');
//
// 	const [line] = stream.read_line_finish(result);
// 	console.log(line);
// });
//
const enc = new TextEncoder()

const connection = socket('/tmp/wayfire-wayland-1.socket');

const payload = JSON.stringify({ method: "list-methods", data: {} })

console.log('writing size')
const arr = new ArrayBuffer(4); // an Int32 takes 4 bytes
const view = new DataView(arr);
view.setUint32(0, payload.length, true);
console.log(arr)
connection.get_output_stream().write(new Uint8Array(arr), null);

console.log('writing payload')
connection
	.get_output_stream()
	.write(enc.encode(payload), null);


console.log('waiting response')
const stream = connection.get_input_stream();

try {
	const response_len = stream.read_bytes(4, null);
	console.log(response_len)
	const test = new DataView(response_len.toArray().buffer).getInt32(0, true);
	console.log({ test })
	const response = stream.read_bytes(test, null);
	const decoder = new TextDecoder();
	const res = JSON.parse(decoder.decode(response.toArray()));
	console.log({ res })
} catch (error) {
	logError(error);
} finally {
	connection.close(null);
}

const Bar = (monitor: number) => Widget.Window({
	name: `bar-${monitor}`,
	child: Widget.Label('hello'),
})

export default {
	windows: [Bar(0)]
}
