import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import { MprisPlayer } from 'types/service/mpris';

const Player = (player: MprisPlayer) => Widget.Box({
	className: "player",
	children: [
		Widget.Box({
			children: [
				Widget.Label({ className: "label" }).hook(player, label => {
					label.label = player.track_title;
				}),
				Widget.Label({
					className: "label",
				}).hook(player, label => {
					const { track_artists } = player;
					label.label = `${track_artists.join(', ')}`;
				}),
			]
		}),
	]
})

export default () => Widget.Box().bind('child', Mpris, 'players', players => {
	const player = players.at(0);
	if (!player || player.play_back_status == 'Stopped') return Widget.Box();
	return Player(player);
});
