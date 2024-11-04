import { lstat, readFile, readlink, rm, symlink } from 'node:fs/promises';
import { resolve } from 'node:path';
import diff from 'fast-diff';

async function fileExist(path: string) {
  try {
    return await lstat(path);
  } catch (err) {
    if (err instanceof Error && 'code' in err && err.code === 'ENOENT') {
      return false;
    }
    throw err;
  }
}

function printDiff(patch: diff.Diff[]) {
  patch.forEach((part) => {
    const color =
      part[0] === 1 ? '\x1b[32m' : part[0] === -1 ? '\x1b[31m' : '\x1b[0m';
    process.stdout.write(color + part[1]);
  });
  process.stdout.write('\x1b[0m');
}

async function makeSoftLink(from: string, to: string) {
  from = from.replace(/^~\//, process.env.HOME + '/');
  to = to.replace(/^~\//, process.env.HOME + '/');
  from = resolve(from);
  to = resolve(to);

  console.log();

  if (!(await fileExist(from))) {
    console.error(`File ${from} does not exist. Skipping...`);
    return;
  }

  console.log(`Creating soft link from ${from} to ${to}`);

  const stat = await fileExist(to);
  if (stat) {
    const contentFrom = await readFile(from, 'utf-8');
    const contentTo = await readFile(to, 'utf-8');

    const differences = diff(contentFrom, contentTo);
    if (differences.length === 1) {
      if (stat.isSymbolicLink()) {
        const link = await readlink(to);
        if (link === from) {
          console.log(`Soft link already exists.`);
        } else {
          console.log(
            `Soft link already exists but points to a different file. ${link}`,
          );
        }
        return;
      }
      rm(to);
    } else {
      console.log(`Files are different. Printing diff...`);
      printDiff(differences);

      console.log(`Do you want to overwrite ${to}?`);

      return;
    }
  }
  // Create soft link
  await symlink(from, to);

  console.log(`Soft link created.`);
}

async function main() {
  await makeSoftLink('./config/mise.toml', '~/.config/mise/config.toml');
  await makeSoftLink('./.zshrc', '~/.zshrc');
  await makeSoftLink(
    './config/lazygit.yml',
    '~/Library/Application Support/lazygit/config.yml',
  );
  await makeSoftLink('./zed/settings.json', '~/.config/zed/settings.json');
}

main();
