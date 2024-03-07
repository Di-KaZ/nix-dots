const entry = App.configDir + '/ts/main.ts'
const outdir = '/tmp/ags/js'

console.log('running ags')

try {
	const res = await Utils.execAsync([
		'bun', 'build', entry,
		'--outdir', outdir,
		'--external', 'resource://*',
		'--external', 'gi://*',
	])
	console.info(res)
} catch (error) {
	console.error(error)
}

const main = await import(`file://${outdir}/main.js`)

export default main.default
