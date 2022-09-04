#!/usr/bin/env node
import inquirer from "inquirer";
import * as fs from "fs";
import { dirname } from "path";
import { fileURLToPath } from "url";
import chalk from "chalk";
import clear from "clear";
import figlet from "figlet";
import createDirectoryContents from "./createDirContents.js";
const CURR_DIR = process.cwd();
const __dirname = dirname(fileURLToPath(import.meta.url));

const CHOICES = fs.readdirSync(`${__dirname}/templates`);

const QUESTIONS = [
    {
        name: "choose-template",
        type: "list",
        message: "Which template would you like to use?",
        choices: CHOICES,
    },
    {
        name: "project-name",
        type: "input",
        message: "Project name:",
        validate: function (input) {
            if (/^([A-Za-z\-\\_\d])+$/.test(input)) return true;
            else
                return "Project name may only include letters, numbers, underscores and hashes.";
        },
    },
];

clear();
console.log(
    chalk.blueBright(
        figlet.textSync("Hestia CLI", { horizontalLayout: "full" })
    )
);

inquirer.prompt(QUESTIONS).then((answers) => {
    const projectChoice = answers["choose-template"];
    const projectName = answers["project-name"];
    const templatePath = `${__dirname}/templates/${projectChoice}`;

    fs.mkdirSync(`${CURR_DIR}/${projectName}`);

    createDirectoryContents(templatePath, projectName);
});
