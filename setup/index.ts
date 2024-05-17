import diff from 'fast-diff';
import { readFile, stat } from 'node:fs/promises';

async function fileExist(path: string) {
  try {
    await stat(path)
    return true
  } catch (err) {
    console.log(err);
    if (err instanceof Error && 'code' in err && err.code === 'ENOENT') {
      return false
    }
    throw err;
  }
}

function printDiff(patch: diff.Diff[]) {
  patch.forEach((part) => {
    const color = part[0] === 1 ? '\x1b[32m' : part[0] === -1 ? '\x1b[31m' : '\x1b[0m'
    process.stdout.write(color + part[1])
  })
  process.stdout.write('\x1b[0m')
}

async function makeSoftLink(from: string, to: string) {
  from = from.replace(/^~\//, process.env.HOME + '/');
  to = to.replace(/^~\//, process.env.HOME + '/');

  console.log();

  if (!await fileExist(from)) {
    console.error(`File ${from} does not exist. Skipping...`)
    return
  }

  console.log(`Creating soft link from ${from} to ${to}`)

  if (await fileExist(to)) {
    console.log(`File ${to} already exists.`)
    const contentFrom = await readFile(from, 'utf-8')
    const contentTo = await readFile(to, 'utf-8')

    const differences = diff(contentFrom, contentTo)
    if (differences.length === 1) {
      console.log(`Files are the same. Skipping...`)
      return
    }

    console.log(`Files are different. Printing diff...`)
    printDiff(differences)

    console.log(`Do you want to overwrite ${to}?`)

    return
  }
  // Create soft link

  console.log('file doesn\'t exist')
}

async function main() {
  await makeSoftLink('../config/mise.toml', '~/.config/mise/config.toml')
  await makeSoftLink('../.zshrc', '~/.zshrc')
}

main();
