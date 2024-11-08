import { lstat, readFile, readlink, rm, symlink } from "node:fs/promises";
import { resolve } from "node:path";
import diff from "fast-diff";

const HOME = process.env.HOME || "~";

async function fileExist(path: string) {
	try {
		return await lstat(path);
	} catch (err) {
		if (err instanceof Error && "code" in err && err.code === "ENOENT") {
			return false;
		}
		throw err;
	}
}

const colors = {
	0: "\x1b[0m",
	"-1": "\x1b[31m",
	1: "\x1b[32m",
};

function printDiff(patch: diff.Diff[]) {
	for (const part of patch) {
		const color = colors[part[0]] || colors[0];
		process.stdout.write(color + part[1]);
	}
	process.stdout.write("\x1b[0m");
}

async function makeSoftLink(_from: string, _to: string) {
	let from = _from.replace(/^~\//, `${process.env.HOME}/`);
	let to = _to.replace(/^~\//, `${process.env.HOME}/`);
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
		const contentFrom = await readFile(from, "utf-8");
		const contentTo = await readFile(to, "utf-8");

		const differences = diff(contentFrom, contentTo);
		if (differences.length === 1) {
			if (stat.isSymbolicLink()) {
				const link = await readlink(to);
				if (link === from) {
					console.log("Soft link already exists.");
				} else {
					console.log(
						`Soft link already exists but points to a different file. ${link}`,
					);
				}
				return;
			}
			rm(to);
		} else {
			console.log("Files are different. Printing diff...");
			printDiff(differences);

			console.log(`Do you want to overwrite ${to}?`);

			return;
		}
	}
	// Create soft link
	await symlink(from, to);

	console.log("Soft link created.");
}

async function copyConfig(scope: string, file: string, destination?: string) {
	const from = resolve(".", scope, file);
	const to = resolve(HOME, ".config", scope, destination || file);
	console.log(`Copying ${from} to ${to}`);
	await makeSoftLink(from, to);
}

async function main() {
	await makeSoftLink(
		"./config/lazygit.yml",
		"~/Library/Application Support/lazygit/config.yml",
	);
	await copyConfig("zed", "settings.json");
	await copyConfig("joshuto", "joshuto.toml");
	await copyConfig("joshuto", "icons.toml");
	await copyConfig("joshuto", "mimetype.toml");
	await copyConfig("joshuto", "preview_file.sh");
}

main();
