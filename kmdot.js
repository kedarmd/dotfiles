import { exec } from 'child_process';
import fs from 'fs';
import path from 'path';

const THEME_NAMES = ['catppuccin', 'nord', 'nordic', 'onedark', 'tokyonight'];

// Function to update Neovim theme
function setNvimTheme(theme) {
    try {
        const target = path.join(process.env.HOME, 'development', 'dotfiles', 'config', 'nvim', 'lua', 'plugins') + '/colorscheme.lua';
        const nvimThemesDir = path.join(process.env.HOME, 'development', 'dotfiles', 'themes', 'nvim');
        const source = `${nvimThemesDir}/${theme}.lua`;
        setThemeCallback(theme, source, target, 'Neovim');
    } catch (error) {
        console.error(`Failed to set Neovim theme: ${error.message}`);
    }
}

function setStarshipTheme(theme) {
    try {
        const target = path.join(process.env.HOME, 'development', 'dotfiles', 'config') + '/starship.toml';
        const starshipThemesDir = path.join(process.env.HOME, 'development', 'dotfiles', 'themes', 'starship');
        const source = `${starshipThemesDir}/${theme}.toml`;
        setThemeCallback(theme, source, target, 'Starship');
    } catch (error) {
        console.error(`Failed to set Neovim theme: ${error.message}`);
    }
}

function updateWeztermTheme(theme) {
    const target = path.join(process.env.HOME, 'development', 'dotfiles') + '/wezterm-theme.lua';
    const wezterFilePath = path.join(process.env.HOME, 'development', 'dotfiles') + '/wezterm.lua';
    const weztermThemesDir = path.join(process.env.HOME, 'development', 'dotfiles', 'themes', 'wezterm');
    const source = `${weztermThemesDir}/${theme}.lua`;
    setThemeCallback(theme, source, target);
    setThemeCallback(theme, wezterFilePath, wezterFilePath, 'Wezterm');
}

function updateTmuxTheme(theme) {
    const startMarker = '# Theme';
    const endMarker = '# End of theme setup';
    const tmuxFilePath = path.join(process.env.HOME, 'development', 'dotfiles', 'tmux.conf');

    fs.readFile(tmuxFilePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error while reading tmux.conf');
            return;
        }
        const startIdx = data.indexOf(startMarker);
        const endIdx = data.indexOf(endMarker);
        if (startIdx === -1 || endIdx === -1) {
            console.error('Could not find theme markers in tmux.conf');
            return;
        }
        const beforeContent = data.substring(0, startIdx);
        const endContent = data.substring(endIdx + endMarker.length + 1);
        // console.debug(data.substring(startIdx));
        const newTheme = readTmuxThemeFile(theme);
        const newThemeConfig = `${startMarker}
${newTheme}
${endMarker}
`;
        const newConfig = beforeContent + newThemeConfig + endContent;
        fs.writeFile(tmuxFilePath, newConfig, 'utf8', (err) => {
            if (err) {
                console.error('Error writing tmux.conf file');
                return;
            }
            console.log(`Updated TMUX theme to ${theme}`);
            exec('tmux source-file ~/.tmux.conf');
        })
    })
}

function readTmuxThemeFile(theme) {
    const themePath = path.join(process.env.HOME, 'development', 'dotfiles', 'themes', 'tmux', `${theme}.conf`);
    const data = fs.readFileSync(themePath, 'utf8', (err, data) => {
        if (err) {
            console.error(`Error while reading tmux theme file: ${theme}.conf`);
            return;
        }
        return data;
    })
    return data;
}

function setThemeCallback(theme, sourcePath, targetPath, config) {
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
            })
        })
    } catch (error) {
        console.error(`Failed to set ${config} theme: ${error.message}`);
    }
}

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

    updateWeztermTheme(theme);
    setNvimTheme(theme);
    setStarshipTheme(theme);
    updateState(theme);
    updateTmuxTheme(theme);
    console.log(`All themes changed to ${theme}.`);
}

main();
