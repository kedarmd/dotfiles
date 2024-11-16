import fs from 'fs';
import path from 'path';
import { setNvimTheme, setStarshipTheme, setTmuxTheme, setWeztermTheme } from './themes/index.js';

const THEME_NAMES = ['catppuccin', 'nord', 'nordic', 'onedark', 'tokyonight'];

/**
 * Generic function to update theme of different configs
 * @param {string} theme - The new theme to be applied
 * @param {string} sourcePath - The path of source file in the dotfiles
 * @param {string} targetPath - The path of target file in the dotfiles
 * @param {string} config - the config to be updated
 * @param {Function} cb - Callback function to perform config specific operation after updating the theme
 * @returns {void}
 */
function setTheme(theme, sourcePath, targetPath, config = undefined, cb = undefined) {
    try {
        fs.readFile(sourcePath, 'utf8', (err, data) => {
            if (err) {
                console.error(`Error while setting ${config} theme ${theme} : ${err}`)
                return;
            }
            fs.writeFile(targetPath, data, 'utf8', (err) => {
                if (err) {
                    console.error(`Error while setting ${config} theme ${theme} : ${err}`)
                    return;
                }
                config && console.log(`${config} theme changed to ${theme}.`);
                cb && cb();
            })
        })
    } catch (error) {
        console.error(`Failed to set ${config} theme: ${error.message}`);
    }
}

/**
 * The fuction to update the local state file
 * @param {string} theme - The new theme to be applied 
 * @returns {void} 
 */
function updateState(theme) {
    const statePath = path.join(process.env.HOME, 'development', 'dotfiles') + '/state.json';
    fs.readFile(statePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading state file', err);
            return;
        }
        const parsedData = parseStateData(data);
        const updatedData = { ...parsedData, currentTheme: theme };
        fs.writeFile(statePath, JSON.stringify(updatedData, null, 4), 'utf8', (err) => {
            if (err) {
                console.error('Error writing state file');
                return;
            }
            console.info('Updated state');
        })
    })
}

const parseStateData = (data) => {
    try {
        return JSON.parse(data);
    } catch (error) {
        console.error(error);
        return {};
    }
}

export const getCurrentTheme = () => {
    const statePath = path.join(process.env.HOME, 'development', 'dotfiles') + '/state.json';
    const data = fs.readFileSync(statePath, 'utf8')
    const theme = parseStateData(data)?.currentTheme;
    return theme;
}

// Main function to set themes
function main() {
    const theme = process.argv[2];

    if (!theme || !THEME_NAMES.includes(theme)) {
        console.log(`Usage: kmdot < ${THEME_NAMES.join(' | ')} >`);
        process.exit(1);
    }

    setWeztermTheme(theme, setTheme);
    setNvimTheme(theme, setTheme);
    setStarshipTheme(theme, setTheme);
    setTmuxTheme(theme);
    updateState(theme);
    console.log(`All themes changed to ${theme}.`);
}

main();
