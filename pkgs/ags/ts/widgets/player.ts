import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import { MprisPlayer } from 'types/service/mpris';

const Player = (player: MprisPlayer) => Widget.Overlay({
	className: "player",
	child: Widget.Label({ height_request: 40, width_request: 300 }),
	overlays: [
		Widget.Icon({
			className: "cover",
			icon: player.bind('cover_path'),
			size: 300,
		}),
		Widget.Box({ className: "darken" }),
		Widget.Label({
			className: "label",
		}).hook(player, label => {
			const { track_artists, track_title } = player;
			label.label = `${track_artists.join(', ')} - ${track_title}`;
		}),
	]
	// Widget.ProgressBar({
	// }).poll(1000, self => {
	// 	console.log(player.length, player.position)
	// 	return self.value = player.length / player.position;
	// })
})

export default () => Widget.Box().bind('child', Mpris, 'players', players => {
	const player = players.at(0);
	if (!player || player.play_back_status == 'Stopped') return Widget.Box();
	return Player(player);
});
