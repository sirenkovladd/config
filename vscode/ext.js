import { readFileSync, writeFileSync } from 'node:fs';
import { homedir } from 'node:os';
import { join } from 'node:path';

const extensions = JSON.parse(readFileSync(join(homedir(), '.vscode/extensions/extensions.json')), 'utf8');

const obj = Object.fromEntries(extensions.map(e => [e.identifier.id, e.version]).sort());

const localExtensions = 'vscode/extensions_local.json';
writeFileSync(localExtensions, JSON.stringify(obj, null, 2), 'utf8');

await Bun.$`code --diff vscode/extensions.json ${localExtensions}`