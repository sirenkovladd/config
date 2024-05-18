import { readFileSync } from 'node:fs';

const tools = Bun.TOML.parse(readFileSync('./list-tools.toml', 'utf8')) as { brew: string[], cargo: string[] };

function checkMatch(exists: string[], need: string[]) {
  let missing = []
  for (const tool of need) {
    if (!exists.includes(tool)) {
      missing.push(tool)
    }
  }
  if (missing.length !== 0) {
    console.log('missing', missing)
  }
}

if (process.platform === 'darwin') {
  const brewList = await Bun.$`brew list`.text()
  checkMatch(brewList.split('\n'), tools.brew)
}

const cargoList = await Bun.$`cargo install --list`.text()
checkMatch(cargoList.split('\n').filter(e => !/^\s/.test(e)).map(e => e.match(/^([\w-]+)\s/)?.[1]!), tools.cargo)
