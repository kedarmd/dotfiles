import fs from 'fs';
import path from 'path';

// Function to update Neovim theme
function setNvimTheme(theme) {
    try {
        const target = path.join(process.env.HOME, '.config', 'nvim', 'lua', 'plugins') + '/colorscheme.lua';
        const nvimThemesDir = path.join(process.env.HOME, 'development', 'dotfiles', 'themes', 'nvim/');
        const source = nvimThemesDir + theme + '.lua';
        setThemeCallback(theme, source, target, 'Neovim');
    } catch (error) {
        console.error(`Failed to set Neovim theme: ${error.message}`);
    }
}

function setStarshipTheme(theme) {
    try {
        const target = path.join(process.env.HOME, '.config') + '/starship.toml';
        const starshipThemesDir = path.join(process.env.HOME, 'development', 'dotfiles', 'themes', 'starship/');
        const source = starshipThemesDir + theme + '.toml';
        setThemeCallback(theme, source, target, 'Starship');
    } catch (error) {
        console.error(`Failed to set Neovim theme: ${error.message}`);
    }
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

function updateWeztermTheme(theme) {
    const target = path.join(process.env.HOME, 'development', 'dotfiles') + '/wezterm-theme.lua';
    const wezterFilePath = path.join(process.env.HOME, 'development', 'dotfiles') + '/wezterm.lua';
    const starshipThemesDir = path.join(process.env.HOME, 'development', 'dotfiles', 'themes', 'wezterm/');
    const source = starshipThemesDir + theme + '.lua';
    setThemeCallback(theme, source, target);
    setThemeCallback(theme, wezterFilePath, wezterFilePath, 'Wezterm');
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

const _getCurrentTheme = () => {
    const statePath = path.join(process.env.HOME, 'development', 'dotfiles') + '/state.json';
    const data = fs.readFileSync(statePath, 'utf8')
    const theme = parseStateData(data)?.currentTheme;
    return theme;
}

// Main function to set themes
function main() {
    const theme = process.argv[2];

    if (!theme) {
        console.log("Usage: node script.js <theme>");
        process.exit(1);
    }

    setNvimTheme(theme);
    setStarshipTheme(theme);
    updateWeztermTheme(theme);
    updateState(theme);
    console.log(`All themes changed to ${theme}.`);
}

main();
