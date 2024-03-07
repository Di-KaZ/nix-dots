import Brightness from '../services/brightnessctl';

export default () => Widget.Icon({
	icon: 'display-brightness-high-symbolic'
}).hook(Brightness, self => {
	const b = Brightness.screen_value * 100;
	const icon = [
		[67, 'high'],
		[34, 'medium'],
		[1, 'low'],
		[0, 'off'],
	].find(([threshold]) => +threshold <= b)?.[1];

	self.icon = `display-brightness-${icon}-symbolic`;
	self.tooltip_text = `Brightness ${Math.floor(b)}%`;

});
